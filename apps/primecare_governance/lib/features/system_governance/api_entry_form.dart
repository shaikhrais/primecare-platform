import 'package:flutter/material.dart';

class ApiEntryForm extends StatefulWidget {
  const ApiEntryForm({super.key});

  @override
  State<ApiEntryForm> createState() => _ApiEntryFormState();
}

class _ApiEntryFormState extends State<ApiEntryForm> {
  final _apiEndpointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'API Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _apiEndpointController,
          decoration: const InputDecoration(
            labelText: 'API Endpoint',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save API')),
      ],
    );
  }
}
