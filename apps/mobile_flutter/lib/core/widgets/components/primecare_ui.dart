import 'package:flutter/material.dart';

/// Standard Universal PrimeCare Surface Card
/// Replaces hundreds of raw Container(decoration: BoxDecoration) structures.
class PrimeCareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const PrimeCareCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withAlpha(20)),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: card,
      );
    }
    return card;
  }
}

/// Standard Abstracted PrimeCare Button
/// Abstracts padding, text themes, and borders universally reducing boilerplate.
class PrimeCareButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool isLoading;

  const PrimeCareButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isPrimary
        ? ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          )
        : OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            side: BorderSide(color: Theme.of(context).colorScheme.primary.withAlpha(50), width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );

    final childText = isLoading 
        ? SizedBox(
            height: 20, 
            width: 20, 
            child: CircularProgressIndicator(
              color: isPrimary ? Colors.white : Theme.of(context).colorScheme.primary, 
              strokeWidth: 2,
            ),
          )
        : Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isPrimary ? Colors.white : Theme.of(context).colorScheme.primary,
            ),
          );

    if (icon != null && !isLoading) {
      if (isPrimary) {
        return ElevatedButton.icon(onPressed: onPressed, style: style, icon: Icon(icon, color: Colors.white), label: childText);
      } else {
        return OutlinedButton.icon(onPressed: onPressed, style: style, icon: Icon(icon, color: Theme.of(context).colorScheme.primary), label: childText);
      }
    }

    return isPrimary
        ? ElevatedButton(onPressed: onPressed, style: style, child: childText)
        : OutlinedButton(onPressed: onPressed, style: style, child: childText);
  }
}

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
      decoration: InputDecoration(
        labelText: label,
      ),
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
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w900,
        fontSize: 12,
        letterSpacing: 1.5,
      ),
    );
  }
}
