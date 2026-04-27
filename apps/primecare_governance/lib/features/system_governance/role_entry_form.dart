import 'package:flutter/material.dart';

class RoleEntryForm extends StatefulWidget {
  const RoleEntryForm({super.key});

  @override
  State<RoleEntryForm> createState() => _RoleEntryFormState();
}

class _RoleEntryFormState extends State<RoleEntryForm> {
  final _roleNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Role Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _roleNameController,
          decoration: const InputDecoration(
            labelText: 'Role Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Role')),
      ],
    );
  }
}
