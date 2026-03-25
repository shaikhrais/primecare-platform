import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

enum PrimeCareButtonType { primary, secondary, text }

class PrimeCareButton extends StatelessWidget {
  final Widget? child;
  final String? label;
  final String? text; // Phase 64 support
  final VoidCallback? onPressed;
  final PrimeCareButtonType type;
  final bool? isPrimary; // Phase 64 support
  final IconData? icon; // Phase 64 support
  final bool isFullWidth;
  final bool isLoading;

  const PrimeCareButton({
    super.key,
    this.child,
    this.label,
    this.text,
    required this.onPressed,
    this.type = PrimeCareButtonType.primary,
    this.isPrimary,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool resolveIsPrimary = isPrimary ?? (type == PrimeCareButtonType.primary);

    Widget displayChild = child ?? Text(label ?? text ?? '');

    if (isLoading) {
      displayChild = const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (icon != null) {
      displayChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: PrimeCareSpacing.sm),
          displayChild,
        ],
      );
    }

    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: isFullWidth ? const Size.fromHeight(48) : null,
      padding: const EdgeInsets.symmetric(
        horizontal: PrimeCareSpacing.lg,
        vertical: PrimeCareSpacing.md,
      ),
    );

    if (!resolveIsPrimary && type != PrimeCareButtonType.text) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: isFullWidth ? const Size.fromHeight(48) : null,
          padding: const EdgeInsets.symmetric(
            horizontal: PrimeCareSpacing.lg,
            vertical: PrimeCareSpacing.md,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: displayChild,
      );
    }

    if (type == PrimeCareButtonType.text) {
      return TextButton(
        style: TextButton.styleFrom(
          minimumSize: isFullWidth ? const Size.fromHeight(48) : null,
          padding: const EdgeInsets.symmetric(
            horizontal: PrimeCareSpacing.lg,
            vertical: PrimeCareSpacing.md,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: displayChild,
      );
    }

    return ElevatedButton(
      style: buttonStyle,
      onPressed: isLoading ? null : onPressed,
      child: displayChild,
    );
  }
}
