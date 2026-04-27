import 'package:flutter/material.dart';

class LanguageEntryForm extends StatefulWidget {
  const LanguageEntryForm({super.key});

  @override
  State<LanguageEntryForm> createState() => _LanguageEntryFormState();
}

class _LanguageEntryFormState extends State<LanguageEntryForm> {
  final _languageKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Language Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _languageKeyController,
          decoration: const InputDecoration(
            labelText: 'Translation Key',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Save Language Key'),
        ),
      ],
    );
  }
}
