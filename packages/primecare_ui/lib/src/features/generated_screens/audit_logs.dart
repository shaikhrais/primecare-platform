import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AuditLogs extends StatelessWidget {
  const AuditLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'AuditLogs',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
