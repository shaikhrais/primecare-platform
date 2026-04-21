// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

/// Standard PrimeCare Input Configuration
/// Overrides localized generic InputDecorations securely.
class PrimeCareTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  const PrimeCareTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
    );
  }
}

/// Universal Header specifically mapped for Data Matrix groupings ("EVIDENCE CAPTURE", "INCIDENT DETAILS")
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

/// Standardized PrimeCare Badge for status parameters
class PrimeCareBadge extends StatelessWidget {
  final String text;
  final Color color;

  const PrimeCareBadge({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Text(
        text.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
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
    // In actual production, base64Image might be a Network URL string natively.
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
