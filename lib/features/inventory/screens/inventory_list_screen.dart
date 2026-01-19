import 'dart:io';

import 'package:flutter/material.dart';
import '../../../data/db/app_db.dart';
import 'item_details_screen.dart';
import 'new_item_screen.dart';

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
          // No need to do anything else; stream updates.
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
               hintText: 'Search items (e.g., Cedar)',
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
                final items = query.isEmpty
                    ? all
                    : all.where((i) => i.name.toLowerCase().contains(query)).toList();

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      query.isEmpty
                          ? 'No inventory yet.\nTap + to add your first item.'
                          : 'No results for "$query".',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final item = items[i];

                    final boxes = item.onHandUnits ~/ item.unitsPerBox;
                    final units = item.onHandUnits % item.unitsPerBox;

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
                        '$boxes box(es) + $units unit(s) • ${item.unitsPerBox} per box',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemDetailsScreen(
                              db: widget.db,
                              itemId: item.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
