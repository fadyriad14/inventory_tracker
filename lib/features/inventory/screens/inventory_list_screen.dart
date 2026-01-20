// lib/features/inventory/screens/inventory_list_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../data/db/app_db.dart';
import 'item_details_screen.dart';
import 'new_item_screen.dart';

const _knownSizes = {'S', 'M', 'L', 'XL'};

class _ParsedName {
  final String group; // e.g. "Floral"
  final String? size; // e.g. "S" (null if not a sized item)

  const _ParsedName({required this.group, required this.size});
}

_ParsedName _parseGroupAndSize(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) {
    return _ParsedName(group: name.trim(), size: null);
  }

  final last = parts.last.toUpperCase();
  if (_knownSizes.contains(last) && parts.length >= 2) {
    final group = parts.sublist(0, parts.length - 1).join(' ').trim();
    return _ParsedName(group: group, size: last);
  }

  return _ParsedName(group: name.trim(), size: null);
}

int _sizeOrder(String? size) {
  switch (size) {
    case 'S':
      return 0;
    case 'M':
      return 1;
    case 'L':
      return 2;
    case 'XL':
      return 3;
    default:
      return 99;
  }
}

class InventoryListScreen extends StatefulWidget {
  final AppDb db;
  const InventoryListScreen({super.key, required this.db});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim().toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewItemScreen(db: widget.db)),
          );
          // stream updates automatically
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search items (e.g., Floral)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() {});
                        },
                      ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: widget.db.watchAllItems(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final all = snapshot.data ?? [];

                // Apply search (name OR sku)
                final filtered = query.isEmpty
                    ? all
                    : all.where((i) {
                        final nameMatch = i.name.toLowerCase().contains(query);
                        final skuMatch =
                            ((i.sku ?? '').toLowerCase()).contains(query);
                        return nameMatch || skuMatch;
                      }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      query.isEmpty
                          ? 'No inventory yet.\nTap + to add your first item.'
                          : 'No results for "$query".',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Group sized items; keep non-sized items separate
                final Map<String, List<Item>> groups = {};
                final List<Item> ungrouped = [];

                for (final item in filtered) {
                  final parsed = _parseGroupAndSize(item.name);
                  if (parsed.size == null) {
                    ungrouped.add(item);
                  } else {
                    groups.putIfAbsent(parsed.group, () => []).add(item);
                  }
                }

                // Sort each group by size order
                for (final entry in groups.entries) {
                  entry.value.sort((a, b) {
                    final sa = _parseGroupAndSize(a.name).size;
                    final sb = _parseGroupAndSize(b.name).size;
                    return _sizeOrder(sa).compareTo(_sizeOrder(sb));
                  });
                }

                // Sort group names
                final groupNames = groups.keys.toList()
                  ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

                // Sort ungrouped by name
                ungrouped.sort((a, b) =>
                    a.name.toLowerCase().compareTo(b.name.toLowerCase()));

                return ListView(
                  children: [
                    // Expandable groups
                    for (final group in groupNames)
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ExpansionTile(
                          title: Text(group),
                          children: [
                            for (final item in groups[group]!)
                              _ItemRow(
                                item: item,
                                db: widget.db,
                              ),
                          ],
                        ),
                      ),

                    // Ungrouped items (show normal)
                    if (ungrouped.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 6),
                        child: Text(
                          'Other',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Column(
                          children: [
                            for (int i = 0; i < ungrouped.length; i++) ...[
                              _ItemRow(item: ungrouped[i], db: widget.db),
                              if (i != ungrouped.length - 1)
                                const Divider(height: 1),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final Item item;
  final AppDb db;

  const _ItemRow({required this.item, required this.db});

  @override
  Widget build(BuildContext context) {
    final boxes = item.onHandUnits ~/ item.unitsPerBox;
    final units = item.onHandUnits % item.unitsPerBox;

    final skuText = (item.sku ?? '').trim();
    final hasSku = skuText.isNotEmpty;

    return ListTile(
      leading: item.photoPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(item.photoPath!),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.inventory_2),
      title: Text(item.name),
      subtitle: Text(
        hasSku
            ? '$boxes box(es) + $units unit(s) • ${item.unitsPerBox} per box\nSKU: $skuText'
            : '$boxes box(es) + $units unit(s) • ${item.unitsPerBox} per box',
      ),
      isThreeLine: hasSku,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemDetailsScreen(
              db: db,
              itemId: item.id,
            ),
          ),
        );
      },
    );
  }
}
