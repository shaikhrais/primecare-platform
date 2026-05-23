// Governance - Category: service | Purpose: Core implementation file for the Dev Toolbox platform logic.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../config/env_config.dart';
import '../governance/screen_registry.dart';

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
            const Text(
              'Dev Toolbox',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              children: [
                Text('governance.devToolbox.env'.tr()),
                const SizedBox(width: 8),
                DropdownButton<Environment>(
                  value: EnvConfig.environment,
                  items: Environment.values
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                      )
                      .toList(),
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
                  onPressed: () {
                    final screen = ScreenRegistry.getById(
                      'VERIFICATION_CENTER',
                    );
                    if (screen != null) {
                      context.push(screen.routePath);
                    }
                  },
                  icon: const Icon(Icons.analytics_outlined, size: 18),
                  label: Text('governance.devToolbox.systemVerify'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                  ),
                ),

                if (EnvConfig.environment == Environment.demo)
                  TextButton.icon(
                    onPressed: () {
                      // Logic to clear demo session and go back to login
                      final screen = ScreenRegistry.getById('LOGIN');
                      if (screen != null) {
                        context.go(screen.routePath);
                      }
                    },
                    icon: const Icon(Icons.logout, size: 18),
                    label: Text('governance.devToolbox.exitDemo'.tr()),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red[700],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
