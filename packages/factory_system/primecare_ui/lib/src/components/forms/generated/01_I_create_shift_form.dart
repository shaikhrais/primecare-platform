// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

class $pageName extends StatelessWidget {
  const $pageName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CreateShiftForm Planned View',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          // Scaffolded field
          TextFormField(
            key: const Key('shift_date_input'),
            decoration: const InputDecoration(
              labelText: 'shift_date_input Field',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: const Text('Submit')),
        ],
      ),
    );
  }
}
