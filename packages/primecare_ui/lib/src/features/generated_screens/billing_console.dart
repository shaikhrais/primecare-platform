import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BillingConsole extends StatelessWidget {
  const BillingConsole({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'BillingConsole',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
