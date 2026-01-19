import 'package:flutter/material.dart';
import '../../../data/db/app_db.dart';

class SetExactStockSheet extends StatefulWidget {
  final AppDb db;
  final Item item;

  const SetExactStockSheet({
    super.key,
    required this.db,
    required this.item,
  });

  @override
  State<SetExactStockSheet> createState() => _SetExactStockSheetState();
}

class _SetExactStockSheetState extends State<SetExactStockSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _boxesCtrl;
  late final TextEditingController _unitsCtrl;
  final TextEditingController _noteCtrl = TextEditingController();

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    final currentBoxes = widget.item.onHandUnits ~/ widget.item.unitsPerBox;
    final currentUnits = widget.item.onHandUnits % widget.item.unitsPerBox;

    _boxesCtrl = TextEditingController(text: '$currentBoxes');
    _unitsCtrl = TextEditingController(text: '$currentUnits');
  }

  @override
  void dispose() {
    _boxesCtrl.dispose();
    _unitsCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  int _parseInt(String s) => int.tryParse(s.trim()) ?? 0;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      final boxes = _parseInt(_boxesCtrl.text);
      final units = _parseInt(_unitsCtrl.text);
      final note = _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim();

      await widget.db.setExactStock(
        itemId: widget.item.id,
        boxes: boxes,
        unitsRemainder: units,
        note: note,
      );

      if (!mounted) return;
      Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final perBox = widget.item.unitsPerBox;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set exact stock',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _boxesCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Boxes',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      if (n == null || n < 0) return '0 or more';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _unitsCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Units (0–${perBox - 1})',
                      border: const OutlineInputBorder(),
                      helperText: '$perBox per box',
                    ),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      if (n == null) return 'Enter a number';
                      if (n < 0) return '0 or more';
                      if (n >= perBox) return 'Must be < $perBox';
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
