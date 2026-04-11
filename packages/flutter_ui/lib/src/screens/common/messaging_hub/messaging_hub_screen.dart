import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_ui/src/components/page_template.dart';

class MessagingHub extends StatelessWidget {
  const MessagingHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Messaging Hub',
      subtitle: 'Encrypted clinical and corporate communication.',
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
                  'Messaging Hub - Under Construction',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'The Messaging Hub high-fidelity view is currently being integrated.',
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
