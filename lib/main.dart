import 'package:flutter/material.dart';
import 'data/db/app_db.dart';
import 'features/inventory/screens/inventory_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDb();
  runApp(InventoryApp(db: db));
}

class InventoryApp extends StatelessWidget {
  final AppDb db;
  const InventoryApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: InventoryListScreen(db: db),
    );
  }
}
