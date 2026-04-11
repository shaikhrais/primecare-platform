import 'package:flutter/material.dart';

class ComplianceExpiryGauge extends StatelessWidget {
  final Map<String, dynamic>? metrics;

  const ComplianceExpiryGauge({super.key, this.metrics});

  @override
  Widget build(BuildContext context) {
    final total = metrics?['total'] ?? 0;
    final compliant = metrics?['compliant'] ?? 0;
    final percent = total > 0 ? (compliant / total) : 0.0;

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
            color: Colors.grey.shade300,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percent.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.teal],
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
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              '100% Compliant',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10,
                color: percent >= 1.0 ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
