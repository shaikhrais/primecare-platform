import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswMessagesScreen extends StatelessWidget {
  const PswMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'PswMessagesScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
