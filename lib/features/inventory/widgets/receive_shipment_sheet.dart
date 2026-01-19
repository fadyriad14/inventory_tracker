import 'package:flutter/material.dart';
import '../../../data/db/app_db.dart';

class ReceiveShipmentSheet extends StatefulWidget {
  final AppDb db;
  final Item item;

  const ReceiveShipmentSheet({
    super.key,
    required this.db,
    required this.item,
  });

  @override
  State<ReceiveShipmentSheet> createState() => _ReceiveShipmentSheetState();
}

class _ReceiveShipmentSheetState extends State<ReceiveShipmentSheet> {
  final _formKey = GlobalKey<FormState>();

  final _boxesCtrl = TextEditingController(text: '0');
  final _unitsCtrl = TextEditingController(text: '0');
  final _noteCtrl = TextEditingController(text: 'Shipment');

  bool _saving = false;

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

      await widget.db.applyDelta(
        itemId: widget.item.id,
        action: TxAction.add,
        boxes: boxes == 0 ? null : boxes,
        units: units == 0 ? null : units,
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
              'Receive shipment',
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
                      labelText: 'Boxes received',
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
                      labelText: 'Units received',
                      helperText: '$perBox per box',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      if (n == null || n < 0) return '0 or more';
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
              child: FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: const Icon(Icons.add),
                label: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Add to inventory'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
