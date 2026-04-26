// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

class PrimeCareActionTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const PrimeCareActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<PrimeCareActionTile> createState() => _PrimeCareActionTileState();
}

class _PrimeCareActionTileState extends State<PrimeCareActionTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: _isHovering
                ? widget.iconColor.withValues(alpha: 0.03)
                : PrimeCareColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovering
                  ? widget.iconColor.withValues(alpha: 0.4)
                  : PrimeCareColors.slate400.withValues(alpha: 0.12),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovering
                    ? widget.iconColor.withValues(alpha: 0.15)
                    : PrimeCareColors.black.withValues(alpha: 0.04),
                blurRadius: _isHovering ? 16 : 8,
                offset: Offset(0, _isHovering ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovering
                      ? widget.iconColor.withValues(alpha: 0.15)
                      : widget.iconColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: _isHovering ? 32 : 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _isHovering
                      ? widget.iconColor
                      : Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
