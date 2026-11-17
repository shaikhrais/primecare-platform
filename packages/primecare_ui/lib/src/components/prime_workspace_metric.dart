import 'package:flutter/material.dart';

import '../theme/prime_theme.dart';

/// Display-only metric for a managed workspace section.
class PrimeWorkspaceMetric extends StatelessWidget {
  final String title;
  final String value;

  const PrimeWorkspaceMetric({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    label: title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: context.theme.typography.h1),
        Text(title),
      ],
    ),
  );
}
