// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_core/providers/03_D_portal_providers.dart';
import 'package:primecare_ui/00_B_theme.dart';

enum PrimeCareButtonType { primary, secondary, text, danger }

class PrimeCareButton extends ConsumerStatefulWidget {
  final Widget? child;
  final String? label;
  final String? text;
  final VoidCallback? onPressed;
  final PrimeCareButtonType type;
  final bool? isPrimary;
  final IconData? icon;
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
  ConsumerState<PrimeCareButton> createState() => _PrimeCareButtonState();
}

class _PrimeCareButtonState extends ConsumerState<PrimeCareButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);

    bool resolveIsPrimary =
        widget.isPrimary ?? (widget.type == PrimeCareButtonType.primary);

    Color buttonColor;
    Color textColor;

    switch (widget.type) {
      case PrimeCareButtonType.primary:
        buttonColor = ds.colors.primary;
        textColor = PrimeCareColors.white;
        break;
      case PrimeCareButtonType.secondary:
        buttonColor = Colors.transparent;
        textColor = ds.colors.primary;
        break;
      case PrimeCareButtonType.danger:
        buttonColor = ds.colors.danger;
        textColor = PrimeCareColors.white;
        break;
      case PrimeCareButtonType.text:
        buttonColor = Colors.transparent;
        textColor = ds.colors.primary;
        break;
    }

    Widget displayChild =
        widget.child ??
        Text(
          (widget.label ?? widget.text ?? '').toUpperCase(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: GoogleFonts.outfit(
            fontSize: PrimeCareSpacing.scaled(14, scale).toDouble(),
            fontWeight: FontWeight.bold,
            color: resolveIsPrimary ? textColor : buttonColor,
            letterSpacing: 0.5 * scale,
          ),
        );

    if (widget.isLoading) {
      displayChild = SizedBox(
        width: 18.0 * scale,
        height: 18.0 * scale,
        child: CircularProgressIndicator(
          strokeWidth: 2.0 * scale,
          valueColor: AlwaysStoppedAnimation<Color>(
            resolveIsPrimary ? textColor : buttonColor,
          ),
        ),
      );
    } else if (widget.icon != null) {
      displayChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 18.0 * scale,
            color: resolveIsPrimary ? textColor : buttonColor,
          ),
          SizedBox(width: 8.0 * scale),
          displayChild,
        ],
      );
    }

    final borderRadius = PrimeCareRadii.scaled(scale);

    if (widget.type == PrimeCareButtonType.text) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: PrimeCareSpacing.scaled(16, scale).toDouble(),
            vertical: PrimeCareSpacing.scaled(8, scale).toDouble(),
          ),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: displayChild,
      );
    }

    final decoration = BoxDecoration(
      borderRadius: borderRadius,
      color: resolveIsPrimary
          ? (widget.onPressed == null ? ds.colors.textTertiary : buttonColor)
          : Colors.transparent,
      border: resolveIsPrimary
          ? null
          : Border.all(
              color: widget.onPressed == null
                  ? ds.colors.borderSubtle
                  : buttonColor.withValues(alpha: 0.5),
              width: 1.5 * scale,
            ),
      boxShadow: resolveIsPrimary && widget.onPressed != null
          ? [
              BoxShadow(
                color: buttonColor.withValues(alpha: 0.2),
                blurRadius: 8.0 * scale,
                offset: Offset(0, 4.0 * scale),
              ),
            ]
          : null,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) {
          _animationController.reverse();
          if (!widget.isLoading && widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        onTapCancel: () => _animationController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: widget.isFullWidth ? double.infinity : null,
            decoration: decoration,
            padding: EdgeInsets.symmetric(
              horizontal: PrimeCareSpacing.scaled(24, scale).toDouble(),
              vertical: PrimeCareSpacing.scaled(14, scale).toDouble(),
            ),
            child: Center(
              widthFactor: widget.isFullWidth ? null : 1.0,
              child: Opacity(
                opacity: _isHovering && widget.onPressed != null ? 0.9 : 1.0,
                child: displayChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
