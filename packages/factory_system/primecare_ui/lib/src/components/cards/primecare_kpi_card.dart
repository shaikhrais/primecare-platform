import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

class PrimeCareKpiCard extends ConsumerWidget {
  final String title;
  final String value;
  final IconData icon;
  final String subtitle;
  final bool isPinned;
  final VoidCallback? onPinToggle;

  const PrimeCareKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle = '',
    this.isPinned = false,
    this.onPinToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.metricsLayer,
          'Hydrating KPI: $title with value: $value',
        );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPinned ? const Color(0xFF1E88E5) : const Color(0xFFE2E8F0),
          width: isPinned ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (onPinToggle != null)
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: Icon(
                  isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  size: 18,
                  color: isPinned
                      ? const Color(0xFF1E88E5)
                      : const Color(0xFF94A3B8),
                ),
                onPressed: onPinToggle,
                tooltip: isPinned ? 'Unpin from top' : 'Pin to top',
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF1E88E5), size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 24.0,
                      ), // Space for pin
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 6,
                      children: [
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E3A8A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
