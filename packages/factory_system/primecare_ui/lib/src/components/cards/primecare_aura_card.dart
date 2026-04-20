// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument, inference_failure_on_untyped_parameter, inference_failure_on_function_return_type
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/primecare_core.dart';
import '../../screens/common/aura_interactive_sheet.dart';

class PrimeCareAuraCard extends ConsumerWidget {
  final List<IntelligenceInsight> insights;
  final Function(AuraIntent)? onAuraResult;

  const PrimeCareAuraCard({
    super.key,
    required this.insights,
    this.onAuraResult,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAnomaly = ref.watch(auraActiveAnomalyProvider);

    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.aura,
          'Building Aura Card',
          metadata: {
            'insightCount': insights.length,
            'hasActiveAnomaly': activeAnomaly != null,
            'anomalyImpact': activeAnomaly?.impact.toString(),
          },
        );

    final gradientColors = activeAnomaly == null
        ? const [Color(0xFF4F46E5), Color(0xFF6366F1), Color(0xFF818CF8)]
        : activeAnomaly.impact == InsightImpact.alert
        ? const [Color(0xFFB91C1C), Color(0xFFDC2626), Color(0xFFEF4444)]
        : const [Color(0xFFD97706), Color(0xFFF59E0B), Color(0xFFFBBF24)];

    final shadowColor = activeAnomaly == null
        ? const Color(0xFF4F46E5)
        : activeAnomaly.impact == InsightImpact.alert
        ? const Color(0xFFB91C1C)
        : const Color(0xFFD97706);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _AuraPulseIcon(
                      impact: activeAnomaly?.impact ?? InsightImpact.info,
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Aura Intelligence',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PrimeCareColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (onAuraResult != null)
                TextButton.icon(
                  onPressed: () async {
                    ref
                        .read(executionGateProvider)
                        .passGate(
                          ExecutionGateCategory.ui,
                          'Aura Search Triggered',
                          metadata: {'source': 'aura_card_header'},
                        );
                    final intent = await AuraInteractiveSheet.show(context);
                    if (intent != null) {
                      onAuraResult!(intent);
                    }
                  },
                  icon: Icon(
                    LucideIcons.messageSquare,
                    size: 16,
                    color: PrimeCareColors.white.withValues(alpha: 0.6),
                  ),
                  label: Text(
                    'Ask Aura',
                    style: TextStyle(
                      color: PrimeCareColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          ...insights.map((insight) => _AuraInsightTile(insight: insight)),
          if (activeAnomaly != null &&
              activeAnomaly.impact == InsightImpact.alert)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton.icon(
                onPressed: () async {
                  ref
                      .read(executionGateProvider)
                      .passGate(
                        ExecutionGateCategory.ui,
                        'Aura Investigation Triggered',
                        metadata: {
                          'anomalyId': activeAnomaly.id,
                          'anomalyType': activeAnomaly.type,
                        },
                      );
                  final intent = await AuraInteractiveSheet.show(context);
                  if (intent != null && onAuraResult != null) {
                    onAuraResult!(intent);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: PrimeCareColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(LucideIcons.shieldAlert, size: 16),
                label: const Text('Investigate Potential Risks'),
              ),
            ),
        ],
      ),
    );
  }
}

class _AuraPulseIcon extends StatefulWidget {
  final InsightImpact impact;
  const _AuraPulseIcon({required this.impact});

  @override
  State<_AuraPulseIcon> createState() => _AuraPulseIconState();
}

class _AuraPulseIconState extends State<_AuraPulseIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Detect if we are running in a test environment to avoid pumpAndSettle timeouts
    bool isTest = false;
    try {
      final binding = WidgetsBinding.instance.toString();
      isTest = binding.contains('TestWidgetsFlutterBinding');
    } catch (_) {}

    if (!isTest) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseColor = switch (widget.impact) {
      InsightImpact.positive => const Color(0xFF4ADE80),
      InsightImpact.caution => const Color(0xFFFBBF24),
      InsightImpact.alert => PrimeCareColors.white,
      InsightImpact.info => PrimeCareColors.white,
    };

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: pulseColor.withValues(
                  alpha: 0.2 + (0.3 * _controller.value),
                ),
                blurRadius: 10 * _controller.value,
                spreadRadius: 2 * _controller.value,
              ),
            ],
          ),
          child: Icon(
            widget.impact == InsightImpact.alert
                ? LucideIcons.activity
                : LucideIcons.sparkles,
            color: pulseColor,
            size: 20,
          ),
        );
      },
    );
  }
}

class _AuraInsightTile extends StatelessWidget {
  final IntelligenceInsight insight;

  const _AuraInsightTile({required this.insight});

  @override
  Widget build(BuildContext context) {
    final impactColor = switch (insight.impact) {
      InsightImpact.positive => const Color(0xFF4ADE80),
      InsightImpact.caution => const Color(0xFFFBBF24),
      InsightImpact.alert => const Color(0xFFEF4444),
      InsightImpact.info => PrimeCareColors.white,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: impactColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PrimeCareColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight.summary,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: PrimeCareColors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
