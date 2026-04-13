import 'package:flutter/material.dart';

import '../theme/design_system.dart';

class PrimeCareFunnelStep {
  final String label;
  final int count;
  final Color? color;

  const PrimeCareFunnelStep({
    required this.label,
    required this.count,
    this.color,
  });
}

class PrimeCareFunnelChart extends StatelessWidget {
  final List<PrimeCareFunnelStep> steps;
  final double height;
  final String title;

  const PrimeCareFunnelChart({
    super.key,
    required this.steps,
    this.height = 250,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox();
    final maxCount = steps.first.count; // Assuming funnel is sorted desc

    return Container(
      height: height,
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.md),
          ],
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final stepHeight = constraints.maxHeight / steps.length;

                return Column(
                  children: List.generate(steps.length, (index) {
                    final step = steps[index];
                    final double widthRatio = maxCount == 0
                        ? 0
                        : step.count / maxCount;
                    // Min width 20% so text fits
                    final double finalWidth = (maxWidth * widthRatio).clamp(
                      maxWidth * 0.2,
                      maxWidth,
                    );
                    final isLast = index == steps.length - 1;

                    return Container(
                      height: stepHeight,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: finalWidth,
                            height: stepHeight - (isLast ? 0 : 4),
                            decoration: BoxDecoration(
                              color:
                                  step.color ??
                                  Theme.of(context).primaryColor.withValues(
                                    alpha: 0.8 - (index * 0.1),
                                  ),
                              borderRadius: PrimeCareRadii.boardSm,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  step.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${step.count}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
