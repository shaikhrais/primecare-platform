import 'package:flutter/material.dart';

class RouteEntryForm extends StatefulWidget {
  const RouteEntryForm({super.key});

  @override
  State<RouteEntryForm> createState() => _RouteEntryFormState();
}

class _RouteEntryFormState extends State<RouteEntryForm> {
  final _routePathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Route Entry',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _routePathController,
          decoration: const InputDecoration(
            labelText: 'URL Path',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () {}, child: const Text('Save Route')),
      ],
    );
  }
}
