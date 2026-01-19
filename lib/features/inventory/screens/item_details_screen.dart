import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/db/app_db.dart';
import '../widgets/set_exact_stock_sheet.dart';
import '../widgets/receive_shipment_sheet.dart';
import '../widgets/deduct_order_sheet.dart';
import 'edit_item_screen.dart';


class ItemDetailsScreen extends StatelessWidget {
  final AppDb db;
  final int itemId;

  const ItemDetailsScreen({
    super.key,
    required this.db,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Item>(
      stream: db.watchItem(itemId),
      builder: (context, itemSnap) {
        final item = itemSnap.data;

        if (!itemSnap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final boxes = item!.onHandUnits ~/ item.unitsPerBox;
        final units = item.onHandUnits % item.unitsPerBox;

        return Scaffold(
          appBar: AppBar(
            title: Text(item.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditItemScreen(db: db, item: item),
                    ),
                  );
                },
              ),
            ],
          ),

          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Photo (optional)
                if (item.photoPath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(item.photoPath!),
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const Center(child: Icon(Icons.inventory_2, size: 48)),
                  ),

                const SizedBox(height: 16),

                // Big stock display
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'On Hand',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$boxes box(es)',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '$units unit(s)',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${item.onHandUnits} total units • ${item.unitsPerBox} per box',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Quick adjust buttons
                Text(
                  'Quick Adjust',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => db.applyDelta(
                          itemId: item.id,
                          action: TxAction.add,
                          boxes: 1,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('+1 box'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => db.applyDelta(
                          itemId: item.id,
                          action: TxAction.remove,
                          boxes: 1,
                        ),
                        icon: const Icon(Icons.remove),
                        label: const Text('-1 box'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => db.applyDelta(
                          itemId: item.id,
                          action: TxAction.add,
                          units: 1,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('+1 unit'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => db.applyDelta(
                          itemId: item.id,
                          action: TxAction.remove,
                          units: 1,
                        ),
                        icon: const Icon(Icons.remove),
                        label: const Text('-1 unit'),
                      ),
                    ),
                  ],
                ),
const SizedBox(height: 12),

Row(
  children: [
    Expanded(
      child: FilledButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ReceiveShipmentSheet(db: db, item: item),
          );
        },
        icon: const Icon(Icons.local_shipping),
        label: const Text('Receive shipment'),
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => DeductOrderSheet(db: db, item: item),
          );
        },
        icon: const Icon(Icons.shopping_cart_checkout),
        label: const Text('Deduct order'),
      ),
    ),
  ],
),

                // ✅ THIS IS WHERE "SET EXACT AMOUNT" GOES
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => SetExactStockSheet(db: db, item: item),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Set exact amount'),
                  ),
                ),

                const SizedBox(height: 20),

                // History
                Text(
                  'History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                StreamBuilder<List<InventoryTransaction>>(
                  stream: db.watchTransactionsForItem(item.id),
                  builder: (context, txSnap) {
                    final txs = txSnap.data ?? [];

                    if (!txSnap.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (txs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('No history yet. Adjust stock to create entries.'),
                      );
                    }

                    final fmt = DateFormat('MMM d, yyyy • h:mm a');

                    return Card(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: txs.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final tx = txs[i];

                          final delta = tx.deltaUnits;
                          final sign = delta >= 0 ? '+' : '';
                          final when = fmt.format(tx.createdAt);

                          final typed = _prettyTx(tx);

                          final note = (tx.note ?? '').trim();

                            return ListTile(
                            title: Text(typed),
                            subtitle: Text(
                                note.isEmpty ? when : '$when\n$note',
                            ),
                            isThreeLine: note.isNotEmpty,
                            trailing: Text('$sign$delta'),
                            );

                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _prettyTx(InventoryTransaction tx) {
    final a = tx.action; // "add" / "remove" / "set"
    final b = tx.inputBoxes;
    final u = tx.inputUnits;

    String input = '';
    if (b != null && b != 0) input += '${b} box(es)';
    if (u != null && u != 0) {
      if (input.isNotEmpty) input += ' + ';
      input += '${u} unit(s)';
    }
    if (input.isEmpty) input = 'units';

    if (a == TxAction.add.name) return 'Added $input';
    if (a == TxAction.remove.name) return 'Removed $input';
    if (a == TxAction.set.name) return 'Set to $input';
    return 'Updated';
  }
}
