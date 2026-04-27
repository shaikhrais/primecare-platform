import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env_config.dart';

class DevToolbox extends ConsumerWidget {
  const DevToolbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (EnvConfig.environment == Environment.prod) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.amber[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dev Toolbox', style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            Row(
              children: [
                const Text('Env:'),
                const SizedBox(width: 8),
                DropdownButton<Environment>(
                  value: EnvConfig.environment,
                  items: Environment.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      EnvConfig.environment = val;
                      // Trigger global restart or reload
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
