import 'package:flutter/material.dart';

import '../theme/prime_theme.dart';

/// The standard titled section for a managed workspace.
class PrimeWorkspaceSectionCard extends StatelessWidget {
  final String title;
  final String semanticLabel;
  final Widget child;

  const PrimeWorkspaceSectionCard({
    super.key,
    required this.title,
    required this.semanticLabel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    container: true,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(context.theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: context.theme.typography.h3),
            SizedBox(height: context.theme.spacing.md),
            child,
          ],
        ),
      ),
    ),
  );
}
