import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class Referrals extends StatelessWidget {
  const Referrals({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'Referrals',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
