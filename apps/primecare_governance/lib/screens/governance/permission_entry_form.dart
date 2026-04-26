import 'package:flutter/material.dart';

class PermissionEntryForm extends StatefulWidget {
  const PermissionEntryForm({super.key});

  @override
  State<PermissionEntryForm> createState() => _PermissionEntryFormState();
}

class _PermissionEntryFormState extends State<PermissionEntryForm> {
  final _permissionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Permission Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _permissionNameController,
          decoration: const InputDecoration(
            labelText: 'Permission Code',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Permission')),
      ],
    );
  }
}
