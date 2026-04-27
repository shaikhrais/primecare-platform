import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/src/models/aura_event.dart';
import 'package:flutter_core/providers/portal_providers.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/shared/src/models/core/dashboard_models.dart';

class AuraInsightCard extends ConsumerStatefulWidget {
  final AuraEvent event;
  final VoidCallback? onDismiss;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AuraInsightCard({
    super.key,
    required this.event,
    this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  @override
  ConsumerState<AuraInsightCard> createState() => _AuraInsightCardState();
}

class _AuraInsightCardState extends ConsumerState<AuraInsightCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    final impactColor = _getImpactColor(widget.event.impact);
    final impactIcon = _getImpactIcon(widget.event.impact);

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 300 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16 * scale),
            boxShadow: [
              BoxShadow(
                color: impactColor.withValues(
                  alpha: 0.3 * _pulseController.value,
                ),
                blurRadius: _glowAnimation.value * scale,
                spreadRadius: 1 * scale,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16 * scale),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: PrimeCareColors.white.withValues(alpha: 0.7),
                  border: Border.all(
                    color: widget.event.isPredictive
                        ? const Color(0xFF6366F1).withValues(
                            alpha: 0.5 + (0.5 * _pulseController.value),
                          )
                        : impactColor.withValues(alpha: 0.5),
                    width: 1.5 * scale,
                  ),
                  borderRadius: BorderRadius.circular(16 * scale),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6 * scale),
                          decoration: BoxDecoration(
                            color: impactColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            impactIcon,
                            size: 14 * scale,
                            color: impactColor,
                          ),
                        ),
                        SizedBox(width: 10 * scale),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                widget.event.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14 * scale,
                                  color: const Color(0xFF1E3A8A),
                                ),
                              ),
                              if (widget.event.isPredictive) ...[
                                SizedBox(width: 8 * scale),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6 * scale,
                                    vertical: 2 * scale,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6366F1),
                                    borderRadius: BorderRadius.circular(
                                      4 * scale,
                                    ),
                                  ),
                                  child: Text(
                                    'PREDICTIVE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8 * scale,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (widget.onDismiss != null)
                          GestureDetector(
                            onTap: widget.onDismiss,
                            child: Icon(
                              LucideIcons.x,
                              size: 14 * scale,
                              color: PrimeCareColors.slate400,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8 * scale),
                    Text(
                      widget.event.description,
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: const Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12 * scale),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AURA AI INSIGHT',
                          style: TextStyle(
                            fontSize: 9 * scale,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            color: impactColor.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          'JUST NOW',
                          style: TextStyle(
                            fontSize: 9 * scale,
                            color: PrimeCareColors.slate400,
                          ),
                        ),
                      ],
                    ),
                    if (widget.actionLabel != null) ...[
                      SizedBox(height: 16 * scale),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: widget.onAction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: impactColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 8 * scale),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8 * scale),
                            ),
                          ),
                          child: Text(
                            widget.actionLabel!,
                            style: TextStyle(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getImpactColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
      case InsightImpact.warning:
      case InsightImpact.critical:
        return PrimeCareColors.rose;
      case InsightImpact.caution:
        return PrimeCareColors.amber;
      case InsightImpact.positive:
      case InsightImpact.growth:
        return PrimeCareColors.emerald;
      case InsightImpact.info:
      case InsightImpact.standard:
      case InsightImpact.success:
      case InsightImpact.high:
      case InsightImpact.low:
      case InsightImpact.medium:
        return PrimeCareColors.skyBlue;
    }
  }

  IconData _getImpactIcon(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
      case InsightImpact.warning:
      case InsightImpact.critical:
        return LucideIcons.alertTriangle;
      case InsightImpact.caution:
        return LucideIcons.zap;
      case InsightImpact.positive:
      case InsightImpact.growth:
        return LucideIcons.trendingUp;
      case InsightImpact.info:
      case InsightImpact.standard:
      case InsightImpact.success:
      case InsightImpact.high:
      case InsightImpact.low:
      case InsightImpact.medium:
        return LucideIcons.info;
    }
  }
}
