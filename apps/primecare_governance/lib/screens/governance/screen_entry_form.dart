import 'package:flutter/material.dart';

class ScreenEntryForm extends StatefulWidget {
  const ScreenEntryForm({super.key});

  @override
  State<ScreenEntryForm> createState() => _ScreenEntryFormState();
}

class _ScreenEntryFormState extends State<ScreenEntryForm> {
  final _screenNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Screen Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _screenNameController,
          decoration: const InputDecoration(
            labelText: 'Screen Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Screen')),
      ],
    );
  }
}
