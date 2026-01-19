// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitsPerBoxMeta = const VerificationMeta(
    'unitsPerBox',
  );
  @override
  late final GeneratedColumn<int> unitsPerBox = GeneratedColumn<int>(
    'units_per_box',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _onHandUnitsMeta = const VerificationMeta(
    'onHandUnits',
  );
  @override
  late final GeneratedColumn<int> onHandUnits = GeneratedColumn<int>(
    'on_hand_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    unitsPerBox,
    onHandUnits,
    photoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('units_per_box')) {
      context.handle(
        _unitsPerBoxMeta,
        unitsPerBox.isAcceptableOrUnknown(
          data['units_per_box']!,
          _unitsPerBoxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitsPerBoxMeta);
    }
    if (data.containsKey('on_hand_units')) {
      context.handle(
        _onHandUnitsMeta,
        onHandUnits.isAcceptableOrUnknown(
          data['on_hand_units']!,
          _onHandUnitsMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unitsPerBox: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}units_per_box'],
      )!,
      onHandUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}on_hand_units'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String name;
  final int unitsPerBox;
  final int onHandUnits;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Item({
    required this.id,
    required this.name,
    required this.unitsPerBox,
    required this.onHandUnits,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['units_per_box'] = Variable<int>(unitsPerBox);
    map['on_hand_units'] = Variable<int>(onHandUnits);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      name: Value(name),
      unitsPerBox: Value(unitsPerBox),
      onHandUnits: Value(onHandUnits),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unitsPerBox: serializer.fromJson<int>(json['unitsPerBox']),
      onHandUnits: serializer.fromJson<int>(json['onHandUnits']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unitsPerBox': serializer.toJson<int>(unitsPerBox),
      'onHandUnits': serializer.toJson<int>(onHandUnits),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Item copyWith({
    int? id,
    String? name,
    int? unitsPerBox,
    int? onHandUnits,
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Item(
    id: id ?? this.id,
    name: name ?? this.name,
    unitsPerBox: unitsPerBox ?? this.unitsPerBox,
    onHandUnits: onHandUnits ?? this.onHandUnits,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unitsPerBox: data.unitsPerBox.present
          ? data.unitsPerBox.value
          : this.unitsPerBox,
      onHandUnits: data.onHandUnits.present
          ? data.onHandUnits.value
          : this.onHandUnits,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitsPerBox: $unitsPerBox, ')
          ..write('onHandUnits: $onHandUnits, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    unitsPerBox,
    onHandUnits,
    photoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.name == this.name &&
          other.unitsPerBox == this.unitsPerBox &&
          other.onHandUnits == this.onHandUnits &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> unitsPerBox;
  final Value<int> onHandUnits;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unitsPerBox = const Value.absent(),
    this.onHandUnits = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int unitsPerBox,
    this.onHandUnits = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       unitsPerBox = Value(unitsPerBox);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? unitsPerBox,
    Expression<int>? onHandUnits,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unitsPerBox != null) 'units_per_box': unitsPerBox,
      if (onHandUnits != null) 'on_hand_units': onHandUnits,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? unitsPerBox,
    Value<int>? onHandUnits,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unitsPerBox: unitsPerBox ?? this.unitsPerBox,
      onHandUnits: onHandUnits ?? this.onHandUnits,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unitsPerBox.present) {
      map['units_per_box'] = Variable<int>(unitsPerBox.value);
    }
    if (onHandUnits.present) {
      map['on_hand_units'] = Variable<int>(onHandUnits.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitsPerBox: $unitsPerBox, ')
          ..write('onHandUnits: $onHandUnits, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InventoryTransactionsTable extends InventoryTransactions
    with TableInfo<$InventoryTransactionsTable, InventoryTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaUnitsMeta = const VerificationMeta(
    'deltaUnits',
  );
  @override
  late final GeneratedColumn<int> deltaUnits = GeneratedColumn<int>(
    'delta_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputBoxesMeta = const VerificationMeta(
    'inputBoxes',
  );
  @override
  late final GeneratedColumn<int> inputBoxes = GeneratedColumn<int>(
    'input_boxes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputUnitsMeta = const VerificationMeta(
    'inputUnits',
  );
  @override
  late final GeneratedColumn<int> inputUnits = GeneratedColumn<int>(
    'input_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    action,
    deltaUnits,
    inputBoxes,
    inputUnits,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('delta_units')) {
      context.handle(
        _deltaUnitsMeta,
        deltaUnits.isAcceptableOrUnknown(data['delta_units']!, _deltaUnitsMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaUnitsMeta);
    }
    if (data.containsKey('input_boxes')) {
      context.handle(
        _inputBoxesMeta,
        inputBoxes.isAcceptableOrUnknown(data['input_boxes']!, _inputBoxesMeta),
      );
    }
    if (data.containsKey('input_units')) {
      context.handle(
        _inputUnitsMeta,
        inputUnits.isAcceptableOrUnknown(data['input_units']!, _inputUnitsMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      deltaUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta_units'],
      )!,
      inputBoxes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_boxes'],
      ),
      inputUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_units'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InventoryTransactionsTable createAlias(String alias) {
    return $InventoryTransactionsTable(attachedDatabase, alias);
  }
}

class InventoryTransaction extends DataClass
    implements Insertable<InventoryTransaction> {
  final int id;
  final int itemId;
  final String action;
  final int deltaUnits;
  final int? inputBoxes;
  final int? inputUnits;
  final String? note;
  final DateTime createdAt;
  const InventoryTransaction({
    required this.id,
    required this.itemId,
    required this.action,
    required this.deltaUnits,
    this.inputBoxes,
    this.inputUnits,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['action'] = Variable<String>(action);
    map['delta_units'] = Variable<int>(deltaUnits);
    if (!nullToAbsent || inputBoxes != null) {
      map['input_boxes'] = Variable<int>(inputBoxes);
    }
    if (!nullToAbsent || inputUnits != null) {
      map['input_units'] = Variable<int>(inputUnits);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InventoryTransactionsCompanion toCompanion(bool nullToAbsent) {
    return InventoryTransactionsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      action: Value(action),
      deltaUnits: Value(deltaUnits),
      inputBoxes: inputBoxes == null && nullToAbsent
          ? const Value.absent()
          : Value(inputBoxes),
      inputUnits: inputUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(inputUnits),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory InventoryTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryTransaction(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      action: serializer.fromJson<String>(json['action']),
      deltaUnits: serializer.fromJson<int>(json['deltaUnits']),
      inputBoxes: serializer.fromJson<int?>(json['inputBoxes']),
      inputUnits: serializer.fromJson<int?>(json['inputUnits']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'action': serializer.toJson<String>(action),
      'deltaUnits': serializer.toJson<int>(deltaUnits),
      'inputBoxes': serializer.toJson<int?>(inputBoxes),
      'inputUnits': serializer.toJson<int?>(inputUnits),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InventoryTransaction copyWith({
    int? id,
    int? itemId,
    String? action,
    int? deltaUnits,
    Value<int?> inputBoxes = const Value.absent(),
    Value<int?> inputUnits = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => InventoryTransaction(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    action: action ?? this.action,
    deltaUnits: deltaUnits ?? this.deltaUnits,
    inputBoxes: inputBoxes.present ? inputBoxes.value : this.inputBoxes,
    inputUnits: inputUnits.present ? inputUnits.value : this.inputUnits,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  InventoryTransaction copyWithCompanion(InventoryTransactionsCompanion data) {
    return InventoryTransaction(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      action: data.action.present ? data.action.value : this.action,
      deltaUnits: data.deltaUnits.present
          ? data.deltaUnits.value
          : this.deltaUnits,
      inputBoxes: data.inputBoxes.present
          ? data.inputBoxes.value
          : this.inputBoxes,
      inputUnits: data.inputUnits.present
          ? data.inputUnits.value
          : this.inputUnits,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransaction(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('action: $action, ')
          ..write('deltaUnits: $deltaUnits, ')
          ..write('inputBoxes: $inputBoxes, ')
          ..write('inputUnits: $inputUnits, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    action,
    deltaUnits,
    inputBoxes,
    inputUnits,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryTransaction &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.action == this.action &&
          other.deltaUnits == this.deltaUnits &&
          other.inputBoxes == this.inputBoxes &&
          other.inputUnits == this.inputUnits &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class InventoryTransactionsCompanion
    extends UpdateCompanion<InventoryTransaction> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> action;
  final Value<int> deltaUnits;
  final Value<int?> inputBoxes;
  final Value<int?> inputUnits;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const InventoryTransactionsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.action = const Value.absent(),
    this.deltaUnits = const Value.absent(),
    this.inputBoxes = const Value.absent(),
    this.inputUnits = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InventoryTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String action,
    required int deltaUnits,
    this.inputBoxes = const Value.absent(),
    this.inputUnits = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : itemId = Value(itemId),
       action = Value(action),
       deltaUnits = Value(deltaUnits);
  static Insertable<InventoryTransaction> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? action,
    Expression<int>? deltaUnits,
    Expression<int>? inputBoxes,
    Expression<int>? inputUnits,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (action != null) 'action': action,
      if (deltaUnits != null) 'delta_units': deltaUnits,
      if (inputBoxes != null) 'input_boxes': inputBoxes,
      if (inputUnits != null) 'input_units': inputUnits,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InventoryTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<String>? action,
    Value<int>? deltaUnits,
    Value<int?>? inputBoxes,
    Value<int?>? inputUnits,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return InventoryTransactionsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      action: action ?? this.action,
      deltaUnits: deltaUnits ?? this.deltaUnits,
      inputBoxes: inputBoxes ?? this.inputBoxes,
      inputUnits: inputUnits ?? this.inputUnits,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (deltaUnits.present) {
      map['delta_units'] = Variable<int>(deltaUnits.value);
    }
    if (inputBoxes.present) {
      map['input_boxes'] = Variable<int>(inputBoxes.value);
    }
    if (inputUnits.present) {
      map['input_units'] = Variable<int>(inputUnits.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('action: $action, ')
          ..write('deltaUnits: $deltaUnits, ')
          ..write('inputBoxes: $inputBoxes, ')
          ..write('inputUnits: $inputUnits, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $InventoryTransactionsTable inventoryTransactions =
      $InventoryTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    items,
    inventoryTransactions,
  ];
}

typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String name,
      required int unitsPerBox,
      Value<int> onHandUnits,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> unitsPerBox,
      Value<int> onHandUnits,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDb, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.inventoryTransactions,
    aliasName: $_aliasNameGenerator(
      db.items.id,
      db.inventoryTransactions.itemId,
    ),
  );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDb, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitsPerBox => $composableBuilder(
    column: $table.unitsPerBox,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onHandUnits => $composableBuilder(
    column: $table.onHandUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer extends Composer<_$AppDb, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitsPerBox => $composableBuilder(
    column: $table.unitsPerBox,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onHandUnits => $composableBuilder(
    column: $table.onHandUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemsTableAnnotationComposer extends Composer<_$AppDb, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get unitsPerBox => $composableBuilder(
    column: $table.unitsPerBox,
    builder: (column) => column,
  );

  GeneratedColumn<int> get onHandUnits => $composableBuilder(
    column: $table.onHandUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({bool inventoryTransactionsRefs})
        > {
  $$ItemsTableTableManager(_$AppDb db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> unitsPerBox = const Value.absent(),
                Value<int> onHandUnits = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                name: name,
                unitsPerBox: unitsPerBox,
                onHandUnits: onHandUnits,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int unitsPerBox,
                Value<int> onHandUnits = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                name: name,
                unitsPerBox: unitsPerBox,
                onHandUnits: onHandUnits,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({inventoryTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventoryTransactionsRefs) db.inventoryTransactions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventoryTransactionsRefs)
                    await $_getPrefetchedData<
                      Item,
                      $ItemsTable,
                      InventoryTransaction
                    >(
                      currentTable: table,
                      referencedTable: $$ItemsTableReferences
                          ._inventoryTransactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ItemsTableReferences(
                        db,
                        table,
                        p0,
                      ).inventoryTransactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.itemId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({bool inventoryTransactionsRefs})
    >;
typedef $$InventoryTransactionsTableCreateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      Value<int> id,
      required int itemId,
      required String action,
      required int deltaUnits,
      Value<int?> inputBoxes,
      Value<int?> inputUnits,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$InventoryTransactionsTableUpdateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<String> action,
      Value<int> deltaUnits,
      Value<int?> inputBoxes,
      Value<int?> inputUnits,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$InventoryTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDb,
          $InventoryTransactionsTable,
          InventoryTransaction
        > {
  $$InventoryTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDb db) => db.items.createAlias(
    $_aliasNameGenerator(db.inventoryTransactions.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTransactionsTableFilterComposer
    extends Composer<_$AppDb, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deltaUnits => $composableBuilder(
    column: $table.deltaUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputBoxes => $composableBuilder(
    column: $table.inputBoxes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputUnits => $composableBuilder(
    column: $table.inputUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableOrderingComposer
    extends Composer<_$AppDb, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deltaUnits => $composableBuilder(
    column: $table.deltaUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputBoxes => $composableBuilder(
    column: $table.inputBoxes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputUnits => $composableBuilder(
    column: $table.inputUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableAnnotationComposer
    extends Composer<_$AppDb, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get deltaUnits => $composableBuilder(
    column: $table.deltaUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputBoxes => $composableBuilder(
    column: $table.inputBoxes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputUnits => $composableBuilder(
    column: $table.inputUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $InventoryTransactionsTable,
          InventoryTransaction,
          $$InventoryTransactionsTableFilterComposer,
          $$InventoryTransactionsTableOrderingComposer,
          $$InventoryTransactionsTableAnnotationComposer,
          $$InventoryTransactionsTableCreateCompanionBuilder,
          $$InventoryTransactionsTableUpdateCompanionBuilder,
          (InventoryTransaction, $$InventoryTransactionsTableReferences),
          InventoryTransaction,
          PrefetchHooks Function({bool itemId})
        > {
  $$InventoryTransactionsTableTableManager(
    _$AppDb db,
    $InventoryTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InventoryTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InventoryTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> deltaUnits = const Value.absent(),
                Value<int?> inputBoxes = const Value.absent(),
                Value<int?> inputUnits = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InventoryTransactionsCompanion(
                id: id,
                itemId: itemId,
                action: action,
                deltaUnits: deltaUnits,
                inputBoxes: inputBoxes,
                inputUnits: inputUnits,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required String action,
                required int deltaUnits,
                Value<int?> inputBoxes = const Value.absent(),
                Value<int?> inputUnits = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InventoryTransactionsCompanion.insert(
                id: id,
                itemId: itemId,
                action: action,
                deltaUnits: deltaUnits,
                inputBoxes: inputBoxes,
                inputUnits: inputUnits,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventoryTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itemId,
                                referencedTable:
                                    $$InventoryTransactionsTableReferences
                                        ._itemIdTable(db),
                                referencedColumn:
                                    $$InventoryTransactionsTableReferences
                                        ._itemIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $InventoryTransactionsTable,
      InventoryTransaction,
      $$InventoryTransactionsTableFilterComposer,
      $$InventoryTransactionsTableOrderingComposer,
      $$InventoryTransactionsTableAnnotationComposer,
      $$InventoryTransactionsTableCreateCompanionBuilder,
      $$InventoryTransactionsTableUpdateCompanionBuilder,
      (InventoryTransaction, $$InventoryTransactionsTableReferences),
      InventoryTransaction,
      PrefetchHooks Function({bool itemId})
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$InventoryTransactionsTableTableManager get inventoryTransactions =>
      $$InventoryTransactionsTableTableManager(_db, _db.inventoryTransactions);
}
