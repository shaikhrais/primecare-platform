// Layer: 02_COMPONENTS
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/theme/theme_tokens.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// V4 "No-Line" Card with 16dp radius and depth-first surfacing.
class PrimeCareV4Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;

  const PrimeCareV4Card({
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(PrimeCareSpacing.sm),
      padding: padding ?? const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardTheme.color,
        borderRadius: PrimeCareRadii.boardXxl,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// V4 "No-Line" Button with premium interaction states.
class PrimeCareV4Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool isSecondary;

  const PrimeCareV4Button({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isSecondary = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? colorScheme.surface : colorScheme.primary,
        foregroundColor: isSecondary ? colorScheme.primary : colorScheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.boardXxl,
        ),
      ).copyWith(
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) return 8;
          if (states.contains(WidgetState.pressed)) return 2;
          return 4;
        }),
        shadowColor: WidgetStateProperty.all(
          isSecondary ? Colors.transparent : colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// V4 Aura HUD Component for high-fidelity telemetry.
class AuraV4Hud extends StatelessWidget {
  final String title;
  final String value;
  final List<Color> gradient;
  final String auraLabel;

  const AuraV4Hud({
    required this.title,
    required this.value,
    required this.gradient,
    required this.auraLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PrimeCareSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: PrimeCareRadii.boardXxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                auraLabel,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 2.0,
                ),
              ),
              const Icon(Icons.waves, color: Colors.white, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -1.0,
            ),
          ),
        ],
      ),
    );
  }
}

/// V4 Stat Card with tonal surfacing.
class PrimeCareV4StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;
  final IconData icon;
  final Color? color;

  const PrimeCareV4StatCard({
    required this.title,
    required this.value,
    this.trend,
    required this.icon,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return PrimeCareV4Card(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (color ?? theme.colorScheme.primary).withValues(alpha: 0.1),
              borderRadius: PrimeCareRadii.boardXl,
            ),
            child: Icon(icon, color: color ?? theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if (trend != null) ...[
            const SizedBox(height: 8),
            Text(
              trend!,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: trend!.contains('+') ? PrimeCareColors.emerald : PrimeCareColors.rose,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
