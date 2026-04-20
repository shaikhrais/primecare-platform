import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
        'Synchronizing Aura IQ...',
        isSyncing: true,
      ),
      error: (err, stack) =>
          _buildStablePulse(context, 'Aura Offline', isDimmed: true),
    );
  }

  Widget _buildSnoozedState(BuildContext context) {
    final color = PrimeCareColors.slate400;
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
          Icon(
            LucideIcons.bellOff,
            color: color.withValues(alpha: 0.5),
            size: 18,
          ),
          const SizedBox(width: 16),
          Text(
            'Aura Alerts Snoozed',
            style: TextStyle(
              color: PrimeCareColors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () =>
                ref.read(auraSnoozeProvider.notifier).update(false),
            child: const Text(
              'RESUME',
              style: TextStyle(
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
    final isAnomaly =
        event.impact == InsightImpact.alert ||
        event.impact == InsightImpact.caution;
    final color = _getColor(event.impact);

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
          _buildPulseIcon(color, isAnomaly),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      event.title.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'REAL-TIME INTELLIGENCE',
                      style: TextStyle(
                        color: PrimeCareColors.white.withValues(alpha: 0.3),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
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

  Widget _buildPulseIcon(Color color, bool isAnomaly) {
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
            isAnomaly ? LucideIcons.alertTriangle : LucideIcons.activity,
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
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'VIEW DETAILS',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Color _getColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
        return const Color(0xFFEF4444); // Red
      case InsightImpact.caution:
        return const Color(0xFFF59E0B); // Amber
      case InsightImpact.positive:
        return const Color(0xFF10B981); // Emerald
      default:
        return const Color(0xFF6366F1); // Indigo
    }
  }
}
