// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareKpiCard extends ConsumerWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final bool isPinned;
  final VoidCallback onPinToggle;

  const PrimeCareKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.isPinned = false,
    required this.onPinToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.ui,
          'Building KPI Card: $title',
          metadata: {'value': value, 'isPinned': isPinned},
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.skyBlue.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: isPinned
              ? PrimeCareColors.skyBlue.withValues(alpha: 0.2)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(executionGateProvider)
                    .passGate(
                      ExecutionGateCategory.ui,
                      'Toggling Pin for KPI: $title',
                      metadata: {'pinned': !isPinned},
                    );
                onPinToggle();
              },
              child: Icon(
                isPinned ? LucideIcons.pin : LucideIcons.pinOff,
                size: 16,
                color: isPinned
                    ? PrimeCareColors.skyBlue
                    : PrimeCareColors.slate400.withValues(alpha: 0.4),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PrimeCareColors.skyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: PrimeCareColors.skyBlue, size: 24),
              ),
              const SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color(0xFF1E3A8A),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
