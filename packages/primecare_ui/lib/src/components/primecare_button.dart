import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

enum PrimeCareButtonType { primary, secondary, text }

class PrimeCareButton extends StatefulWidget {
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
  State<PrimeCareButton> createState() => _PrimeCareButtonState();
}

class _PrimeCareButtonState extends State<PrimeCareButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    bool resolveIsPrimary = widget.isPrimary ?? (widget.type == PrimeCareButtonType.primary);

    Widget displayChild = widget.child ?? Text(widget.label ?? widget.text ?? '', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: resolveIsPrimary ? Colors.white : Colors.indigo,
        letterSpacing: 0.5,),
    );

    if (widget.isLoading) {
      displayChild = const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      );
    } else if (widget.icon != null) {
      displayChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 20, color: resolveIsPrimary ? Colors.white : Colors.indigo),
          const SizedBox(width: 8),
          displayChild,
        ],
      );
    }

    if (widget.type == PrimeCareButtonType.text) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: displayChild,
      );
    }

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: resolveIsPrimary
          ? LinearGradient(
              colors: _isHovering ? [Colors.indigo.shade600, Theme.of(context).primaryColorLight] : [Colors.indigo, Theme.of(context).colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      color: resolveIsPrimary ? null : (_isHovering ? Colors.indigo.shade50 : Colors.white),
      border: resolveIsPrimary ? null : Border.all(color: Colors.indigo.withOpacity(0.3), width: 1.5),
      boxShadow: resolveIsPrimary
          ? [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(_isHovering ? 0.6 : 0.3),
                blurRadius: _isHovering ? 16 : 8,
                offset: const Offset(0, 4),
              )
            ]
          : [],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) {
          _animationController.reverse();
          if (!widget.isLoading && widget.onPressed != null) widget.onPressed!();
        },
        onTapCancel: () => _animationController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: widget.isFullWidth ? double.infinity : null,
            decoration: decoration,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: Center(
              widthFactor: widget.isFullWidth ? null : 1.0,
              child: displayChild,
            ),
          ),
        ),
      ),
    );
  }
}
