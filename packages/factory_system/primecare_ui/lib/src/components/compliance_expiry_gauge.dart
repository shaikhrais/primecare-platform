// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class ComplianceExpiryGauge extends StatelessWidget {
  final Map<String, dynamic>? metrics;

  const ComplianceExpiryGauge({super.key, this.metrics});

  @override
  Widget build(BuildContext context) {
    final num total = (metrics?['total'] as num?) ?? 0;
    final num compliant = (metrics?['compliant'] as num?) ?? 0;
    final double percent = total > 0 ? (compliant / total).toDouble() : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compliance Gauge: ${(percent * 100).toStringAsFixed(1)}% ($compliant / $total)',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: PrimeCareColors.slate400,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percent.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [PrimeCareColors.emerald, PrimeCareColors.skyBlue],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '0%',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10, color: PrimeCareColors.slate400),
            ),
            Text(
              '100% Compliant',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10,
                color: percent >= 1.0
                    ? PrimeCareColors.emerald
                    : PrimeCareColors.slate400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
