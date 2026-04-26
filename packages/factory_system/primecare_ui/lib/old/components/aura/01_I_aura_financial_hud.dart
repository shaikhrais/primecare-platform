import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../theme/01_I_colors.dart';

class AuraFinancialHud extends StatelessWidget {
  final List<IntelligenceInsight> insights;
  final VoidCallback? onClose;

  const AuraFinancialHud({super.key, required this.insights, this.onClose});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),

            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: PrimeCareColors.white.withValues(alpha: 0.7),
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _AnimatedAuraPulse(),
                        const SizedBox(width: 12),
                        Text(
                          'AURA FINANCIAL INTELLIGENCE',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: const Color(0xFF4338CA),
                          ),
                        ),
                      ],
                    ),
                    if (onClose != null)
                      IconButton(
                        onPressed: onClose,
                        icon: const Icon(LucideIcons.x, size: 20),
                        color: const Color(0xFF64748B),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                if (insights.isEmpty)
                  Text(
                    'Analyzing real-time transaction velocity...',
                    style: GoogleFonts.inter(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF94A3B8),
                    ),
                  )
                else
                  ...insights.map(
                    (insight) => _FinancialInsightTile(insight: insight),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FinancialInsightTile extends StatelessWidget {
  final IntelligenceInsight insight;

  const _FinancialInsightTile({required this.insight});

  @override
  Widget build(BuildContext context) {
    final color = _getImpactColor(insight.impact);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(_getImpactIcon(insight.impact), color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title.translate(context),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.summary.translate(context),
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.5,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getImpactColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.positive:
      case InsightImpact.growth:
        return const Color(0xFF10B981);
      case InsightImpact.caution:
      case InsightImpact.warning:
        return const Color(0xFFF59E0B);
      case InsightImpact.alert:
      case InsightImpact.critical:
        return const Color(0xFFEF4444);
      case InsightImpact.info:
      case InsightImpact.standard:
      case InsightImpact.success:
      case InsightImpact.high:
      case InsightImpact.low:
      case InsightImpact.medium:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _getImpactIcon(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.positive:
      case InsightImpact.growth:
        return LucideIcons.trendingUp;
      case InsightImpact.caution:
      case InsightImpact.warning:
        return LucideIcons.alertTriangle;
      case InsightImpact.alert:
      case InsightImpact.critical:
        return LucideIcons.zap;
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

class _AnimatedAuraPulse extends StatefulWidget {
  @override
  State<_AnimatedAuraPulse> createState() => _AnimatedAuraPulseState();
}

class _AnimatedAuraPulseState extends State<_AnimatedAuraPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF6366F1),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF6366F1,
                ).withValues(alpha: 0.5 * _controller.value),
                blurRadius: 10 * _controller.value,

                spreadRadius: 4 * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
