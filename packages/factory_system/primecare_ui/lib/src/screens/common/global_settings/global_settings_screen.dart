import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_ui/src/components/page_template.dart';

class GlobalSettings extends StatelessWidget {
  const GlobalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Settings',
      subtitle: 'Platform-wide configuration and preferences.',
      icon: LucideIcons.layoutGrid,
      bodySections: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.packageOpen,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Global Settings - Under Construction',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'The Global Settings high-fidelity view is currently being integrated.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
