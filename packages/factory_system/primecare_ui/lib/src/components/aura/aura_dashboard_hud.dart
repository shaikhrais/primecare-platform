import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_adapters/src/models/core/dashboard_models.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/components/aura/aura_briefing_panel.dart';
import 'package:flutter_core/src/resilience/system_recovery_manager.dart';
import 'package:flutter_core/aura_providers.dart';
import 'package:flutter_core/src/models/aura_event.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';

/// A high-fidelity Dashboard HUD that displays real-time intelligence pulses from Aura.
class AuraDashboardHud extends ConsumerStatefulWidget {
  const AuraDashboardHud({super.key});

  @override
  ConsumerState<AuraDashboardHud> createState() => _AuraDashboardHudState();
}

class _AuraDashboardHudState extends ConsumerState<AuraDashboardHud>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ MECHANICAL STABILITY: Mark the system as stable once the HUD hydrates.
    // This stops the auto-healing loop from attempting further resets.
    SystemRecoveryManager.markStable();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 2.0, end: 12.0).animate(
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
    final isSnoozed = ref.watch(auraSnoozeProvider);
    if (isSnoozed) return _buildSnoozedState(context);

    final pulseAsync = ref.watch(auraPulseProvider);

    return pulseAsync.when(
      data: (event) => _buildHudContent(context, event),
      loading: () => _buildStablePulse(
        context,
        'aura.synchronizing'.tr(),
        isSyncing: true,
      ),
      error: (err, stack) =>
          _buildStablePulse(context, 'aura.offline'.tr(), isDimmed: true),
    );
  }

  Widget _buildSnoozedState(BuildContext context) {
    final color = PrimeCareColors.slate400;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF0F172A).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.bellOff,
            color: color.withValues(alpha: 0.5),
            size: 18,
          ),
          SizedBox(width: 16),
          Text(
            'aura.snoozed'.tr(),
            style: TextStyle(
              color: PrimeCareColors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () =>
                ref.read(auraSnoozeProvider.notifier).update(false),
            child: Text(
              'aura.resume'.tr(),
              style: const TextStyle(
                color: Color(0xFF6366F1),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHudContent(BuildContext context, AuraEvent event) {
    final isDrift = event.type == AuraEventType.architecturalDrift;
    final isAnomaly =
        event.impact == InsightImpact.alert ||
        event.impact == InsightImpact.caution ||
        isDrift;
    final color = isDrift ? const Color(0xFFA855F7) : _getColor(event.impact);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildPulseIcon(color, isAnomaly, isDrift),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      isDrift
                          ? 'aura.governance_alert'.tr()
                          : event.title.tr().toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'aura.real_time_intelligence'.tr(),
                      style: TextStyle(
                        color: PrimeCareColors.white.withValues(alpha: 0.3),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  isDrift
                      ? 'aura.events.architectural_drift_desc'.tr(
                          args: <String>[
                            (event.metadata?['route']?.toString() ?? 'Unknown'),
                            (event.metadata?['critical'] as List?)?.join(
                                  ', ',
                                ) ??
                                'None',
                          ],
                        )
                      : event.description.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: PrimeCareColors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildActionHint(color),
        ],
      ),
    );
  }

  Widget _buildPulseIcon(Color color, bool isAnomaly, bool isDrift) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.1),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: _glowAnimation.value,
                spreadRadius: _glowAnimation.value / 4,
              ),
            ],
          ),
          child: Icon(
            isDrift
                ? LucideIcons.shieldAlert
                : (isAnomaly
                      ? LucideIcons.alertTriangle
                      : LucideIcons.activity),
            color: color,
            size: 24,
          ),
        );
      },
    );
  }

  Widget _buildStablePulse(
    BuildContext context,
    String message, {
    bool isSyncing = false,
    bool isDimmed = false,
  }) {
    final color = isDimmed ? PrimeCareColors.slate400 : const Color(0xFF6366F1);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: isSyncing
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color.withValues(alpha: 0.5),
                  )
                : Icon(
                    LucideIcons.shieldCheck,
                    color: color.withValues(alpha: 0.5),
                    size: 18,
                  ),
          ),
          const SizedBox(width: 16),
          Text(
            message,
            style: TextStyle(
              color: PrimeCareColors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionHint(Color color) {
    return Row(
      children: [
        InkWell(
          onTap: () => ref.read(auraSnoozeProvider.notifier).update(true),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PrimeCareColors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              LucideIcons.bellOff,
              color: PrimeCareColors.white.withValues(alpha: 0.5),
              size: 16,
            ),
          ),
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: () => AuraBriefingPanel.show(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'aura.view_details'.tr(),
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
      case InsightImpact.critical:
        return const Color(0xFFEF4444); // Red
      case InsightImpact.caution:
      case InsightImpact.warning:
        return const Color(0xFFF59E0B); // Amber
      case InsightImpact.positive:
      case InsightImpact.growth:
        return const Color(0xFF10B981); // Emerald
      case InsightImpact.info:
      case InsightImpact.standard:
      case InsightImpact.success:
      case InsightImpact.high:
      case InsightImpact.low:
      case InsightImpact.medium:
        return const Color(0xFF6366F1); // Indigo
    }
  }
}
