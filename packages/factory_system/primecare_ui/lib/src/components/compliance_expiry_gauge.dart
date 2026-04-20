// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument, inference_failure_on_untyped_parameter, inference_failure_on_function_return_type
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class ComplianceExpiryGauge extends StatelessWidget {
  final Map<String, dynamic>? metrics;

  const ComplianceExpiryGauge({super.key, this.metrics});

  @override
  Widget build(BuildContext context) {
    final num total = metrics?['total'] ?? 0;
    final num compliant = metrics?['compliant'] ?? 0;
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
