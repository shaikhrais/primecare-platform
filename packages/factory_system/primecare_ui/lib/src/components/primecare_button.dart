import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/providers/portal_providers.dart';
import '../theme/theme_tokens.dart';

enum PrimeCareButtonType { primary, secondary, text }

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
    final theme = Theme.of(context);

    bool resolveIsPrimary =
        widget.isPrimary ?? (widget.type == PrimeCareButtonType.primary);

    final primaryColor = theme.primaryColor;
    final onPrimaryColor = Colors.white;

    Widget displayChild =
        widget.child ??
        Text(
          widget.label ?? widget.text ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15 * scale,
            fontWeight: FontWeight.w600, // Semi-bold for institutional look
            color: resolveIsPrimary ? onPrimaryColor : primaryColor,
            letterSpacing: 0.2,
          ),
        );

    if (widget.isLoading) {
      displayChild = SizedBox(
        width: 18 * scale,
        height: 18 * scale,
        child: CircularProgressIndicator(
          strokeWidth: 2 * scale,
          valueColor: AlwaysStoppedAnimation<Color>(
            resolveIsPrimary ? onPrimaryColor : primaryColor,
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
            size: 18 * scale,
            color: resolveIsPrimary ? onPrimaryColor : primaryColor,
          ),
          SizedBox(width: 8 * scale),
          displayChild,
        ],
      );
    }

    final borderRadius = PrimeCareRadii.scaled(scale);

    if (widget.type == PrimeCareButtonType.text) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 8 * scale,
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
          ? (widget.onPressed == null ? theme.disabledColor : primaryColor)
          : Colors.transparent,
      border: resolveIsPrimary
          ? null
          : Border.all(
              color: widget.onPressed == null
                  ? theme.disabledColor.withValues(alpha: 0.3)
                  : primaryColor.withValues(alpha: 0.5),
              width: 1.0,
            ),
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
              horizontal: 24 * scale,
              vertical: 12 * scale,
            ),
            child: Center(
              widthFactor: widget.isFullWidth ? null : 1.0,
              child: Opacity(
                opacity: _isHovering ? 0.9 : 1.0,
                child: displayChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
