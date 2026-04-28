// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

export 'shared/src/core/primecare_components.dart';

// Standard PrimeCare Input Configuration
// Overrides localized generic InputDecorations securely.

/// Universal Header specifically mapped for RnData Matrix groupings ("EVIDENCE CAPTURE", "INCIDENT DETAILS")
class PrimeCareSectionHeader extends StatelessWidget {
  final String title;

  const PrimeCareSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,
        fontSize: 12,
        letterSpacing: 1.5,
      ),
    );
  }
}

/// Universal standardized Avatar module natively inheriting dimensions
class PrimeCareAvatar extends StatelessWidget {
  final double radius;
  final String? base64Image;
  final IconData defaultIcon;

  const PrimeCareAvatar({
    super.key,
    this.radius = 24,
    this.base64Image,
    this.defaultIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(20),
      child: Icon(
        defaultIcon,
        color: Theme.of(context).colorScheme.primary,
        size: radius * 1.2,
      ),
    );
  }
}
