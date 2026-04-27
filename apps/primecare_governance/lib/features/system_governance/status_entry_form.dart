import 'package:flutter/material.dart';

class StatusEntryForm extends StatefulWidget {
  const StatusEntryForm({super.key});

  @override
  State<StatusEntryForm> createState() => _StatusEntryFormState();
}

class _StatusEntryFormState extends State<StatusEntryForm> {
  final _statusNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _statusNameController,
          decoration: const InputDecoration(
            labelText: 'Status Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Status')),
      ],
    );
  }
}
