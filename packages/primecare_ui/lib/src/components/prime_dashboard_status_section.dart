import 'package:flutter/widgets.dart';
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;

import '../theme/prime_theme.dart';

/// Shared presentation for an existing dashboard's status section.
class PrimeDashboardStatusSection extends StatelessWidget {
  const PrimeDashboardStatusSection({
    super.key,
    required this.semanticLabel,
    required this.heading,
    required this.status,
  });

  final String semanticLabel;
  final String heading;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Semantics(
      label: semanticLabel,
      container: true,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: theme.typography.h3),
            SizedBox(height: theme.spacing.xs),
            PrimeStatusText(status, tone: PrimeStatusTone.muted),
          ],
        ),
      ),
    );
  }
}
