import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  // ✅ NEW: optional SKU
  TextColumn get sku => text().nullable()();

  // Example: Cedar Small = 40, Cedar Medium = 24
  IntColumn get unitsPerBox => integer()();

  // Single source of truth: TOTAL single units on hand
  IntColumn get onHandUnits => integer().withDefault(const Constant(0))();

  // Local file path for an image (optional)
  TextColumn get photoPath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

enum TxAction { add, remove, set }

class InventoryTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get itemId => integer().references(Items, #id)();

  // "add", "remove", "set"
  TextColumn get action => text()();

  // Always stored in SINGLE units (+/-). For "set", we store delta too.
  IntColumn get deltaUnits => integer()();

  // What you typed (optional, helps show history nicely)
  IntColumn get inputBoxes => integer().nullable()();
  IntColumn get inputUnits => integer().nullable()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Items, InventoryTransactions])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // ✅ IMPORTANT: migration for adding sku when upgrading from schemaVersion 1 -> 2
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(items, items.sku);
          }
        },
      );

  // --- Reads ---
  Stream<List<Item>> watchAllItems() {
    final q = select(items)..orderBy([(t) => OrderingTerm(expression: t.name)]);
    return q.watch();
  }

  Stream<Item> watchItem(int id) {
    return (select(items)..where((t) => t.id.equals(id))).watchSingle();
  }

  Stream<List<InventoryTransaction>> watchTransactionsForItem(int itemId) {
    final q = (select(inventoryTransactions)
      ..where((t) => t.itemId.equals(itemId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]));
    return q.watch();
  }

  // --- Writes ---
  Future<int> createItem({
    required String name,
    String? sku, // ✅ NEW
    required int unitsPerBox,
    int initialUnits = 0,
    String? photoPath,
  }) {
    final normalizedSku = (sku ?? '').trim();
    return into(items).insert(
      ItemsCompanion.insert(
        name: name,
        sku: Value(normalizedSku.isEmpty ? null : normalizedSku), // ✅ NEW
        unitsPerBox: unitsPerBox,
        onHandUnits: Value(initialUnits),
        photoPath: Value(photoPath),
      ),
    );
  }

  Future<void> applyDelta({
    required int itemId,
    required TxAction action,
    int? boxes,
    int? units,
    String? note,
  }) async {
    final item =
        await (select(items)..where((t) => t.id.equals(itemId))).getSingle();

    final b = boxes ?? 0;
    final u = units ?? 0;

    final deltaAbs = (b * item.unitsPerBox) + u;
    if (deltaAbs == 0) return;

    final signedDelta = (action == TxAction.remove) ? -deltaAbs : deltaAbs;

    final newOnHand = item.onHandUnits + signedDelta;
    final clamped = newOnHand < 0 ? 0 : newOnHand;

    // If clamped, make sure history matches what actually happened
    final actualDelta = clamped - item.onHandUnits;

    await transaction(() async {
      await (update(items)..where((t) => t.id.equals(itemId))).write(
        ItemsCompanion(
          onHandUnits: Value(clamped),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await into(inventoryTransactions).insert(
        InventoryTransactionsCompanion.insert(
          itemId: itemId,
          action: action.name,
          deltaUnits: actualDelta,
          inputBoxes: Value(boxes),
          inputUnits: Value(units),
          note: Value(note),
        ),
      );
    });
  }

  Future<void> updateItem({
    required int itemId,
    required String name,
    String? sku, // ✅ NEW
    String? photoPath,
  }) async {
    final normalizedSku = (sku ?? '').trim();

    await (update(items)..where((t) => t.id.equals(itemId))).write(
      ItemsCompanion(
        name: Value(name),
        sku: Value(normalizedSku.isEmpty ? null : normalizedSku), // ✅ NEW
        photoPath: Value(photoPath),
        updatedAt: Value(DateTime.now()), // ✅ keep updatedAt accurate
      ),
    );
  }

  Future<void> deleteItem(int itemId) async {
    await transaction(() async {
      await (delete(inventoryTransactions)
            ..where((t) => t.itemId.equals(itemId)))
          .go();
      await (delete(items)..where((t) => t.id.equals(itemId))).go();
    });
  }

  Future<void> setExactStock({
    required int itemId,
    required int boxes,
    required int unitsRemainder,
    String? note,
  }) async {
    final item =
        await (select(items)..where((t) => t.id.equals(itemId))).getSingle();

    final targetUnits = (boxes * item.unitsPerBox) + unitsRemainder;
    final clamped = targetUnits < 0 ? 0 : targetUnits;
    final delta = clamped - item.onHandUnits;

    await transaction(() async {
      await (update(items)..where((t) => t.id.equals(itemId))).write(
        ItemsCompanion(
          onHandUnits: Value(clamped),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await into(inventoryTransactions).insert(
        InventoryTransactionsCompanion.insert(
          itemId: itemId,
          action: TxAction.set.name,
          deltaUnits: delta,
          inputBoxes: Value(boxes),
          inputUnits: Value(unitsRemainder),
          note: Value(note),
        ),
      );
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'inventory.sqlite'));
    return NativeDatabase(file);
  });
}
