import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/db/app_db.dart';

class EditItemScreen extends StatefulWidget {
  final AppDb db;
  final Item item;

  const EditItemScreen({
    super.key,
    required this.db,
    required this.item,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  String? _photoPath;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.item.name);
    _photoPath = widget.item.photoPath;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;

    setState(() => _photoPath = file.path);
  }

  Future<void> _removePhoto() async {
    setState(() => _photoPath = null);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      await widget.db.updateItem(
        itemId: widget.item.id,
        name: _nameCtrl.text.trim(),
        photoPath: _photoPath,
      );

      if (!mounted) return;
      Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
Future<void> _confirmDelete() async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete item?'),
      content: const Text(
        'This will permanently delete this item and its full history.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (ok != true) return;

  setState(() => _saving = true);
  try {
    await widget.db.deleteItem(widget.item.id);
    if (!mounted) return;

    // Close Edit screen
    Navigator.pop(context);

    // Close Item Details screen (since item is gone)
    Navigator.pop(context);
  } finally {
    if (mounted) setState(() => _saving = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Photo preview
            if (_photoPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(_photoPath!),
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
                child: const Center(child: Icon(Icons.photo, size: 48)),
              ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _saving ? null : _pickPhoto,
                    icon: const Icon(Icons.image),
                    label: const Text('Change photo'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_saving || _photoPath == null) ? null : _removePhoto,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Remove'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Item name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
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
                    : const Text('Save changes'),
              ),
            ),
            const SizedBox(height: 24),
                SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                    onPressed: _saving ? null : _confirmDelete,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete item'),
                ),
                ),

          ],
        ),
      ),
    );
  }
}
