import 'package:flutter/material.dart';

class ModuleEntryForm extends StatefulWidget {
  const ModuleEntryForm({super.key});

  @override
  State<ModuleEntryForm> createState() => _ModuleEntryFormState();
}

class _ModuleEntryFormState extends State<ModuleEntryForm> {
  final _moduleNameController = TextEditingController();
  String _moduleApp = 'Corporate Admin App';
  String _modulePriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Module Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _moduleNameController,
          decoration: const InputDecoration(
            labelText: 'Module Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _moduleApp,
          decoration: const InputDecoration(
            labelText: 'Parent App',
            border: OutlineInputBorder(),
          ),
          items: [
            'Corporate Admin App',
            'PSW App',
            'Client Family App',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _moduleApp = val!),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _modulePriority,
          decoration: const InputDecoration(
            labelText: 'Priority',
            border: OutlineInputBorder(),
          ),
          items: [
            'High',
            'Medium',
            'Low',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _modulePriority = val!),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Module')),
      ],
    );
  }
}
