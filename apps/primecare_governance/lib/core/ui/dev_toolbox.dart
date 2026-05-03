import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env_config.dart';
import 'package:flutter_core/registry/governance_registry.dart';

class DevToolbox extends ConsumerWidget {
  const DevToolbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (EnvConfig.environment == Environment.prod) {
      return const SizedBox.shrink();
    }

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
                const Spacer(),
              ],
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/verification'),
                  icon: const Icon(Icons.analytics_outlined, size: 18),
                  label: const Text('System Verify'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    GovernanceRegistry.remediateDrift();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Architectural Drift Remediated')),
                    );
                  },
                  icon: const Icon(Icons.auto_fix_high_outlined, size: 18),
                  label: const Text('Auto-Fix Drift'),
                ),
                if (EnvConfig.environment == Environment.demo)
                  TextButton.icon(
                    onPressed: () {
                      // Logic to clear demo session and go back to login
                      context.go('/login');
                    },
                    icon: const Icon(Icons.logout, size: 18),
                    label: const Text('Exit Demo'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red[700]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
