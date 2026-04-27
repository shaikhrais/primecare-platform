import 'package:flutter/material.dart';

class AppEntryForm extends StatefulWidget {
  const AppEntryForm({super.key});

  @override
  State<AppEntryForm> createState() => _AppEntryFormState();
}

class _AppEntryFormState extends State<AppEntryForm> {
  final _appNameController = TextEditingController();
  String _appStatus = 'Draft';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _appNameController,
          decoration: const InputDecoration(
            labelText: 'App Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _appStatus,
          decoration: const InputDecoration(
            labelText: 'Status',
            border: OutlineInputBorder(),
          ),
          items: [
            'Draft',
            'Active',
            'Deprecated',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _appStatus = val!),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save App')),
      ],
    );
  }
}
