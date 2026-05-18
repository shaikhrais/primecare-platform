import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class NotificationCenter extends StatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'NotificationCenter',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
