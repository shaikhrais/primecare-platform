import 'package:flutter/material.dart';
import 'prime_card.dart';
import 'package:intl/intl.dart';

class MacroFinancialSummaryCard extends StatelessWidget {
  final double currentRevenue;
  final double targetRevenue;

  const MacroFinancialSummaryCard({
    Key? key,
    this.currentRevenue = 24500.0,
    this.targetRevenue = 25000.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final ratio = currentRevenue / targetRevenue;
    final isPositive = ratio >= 1.0;

    return PrimeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Period Revenue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? Colors.green : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormatter.format(currentRevenue),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade200,
            color: isPositive ? Colors.green : Colors.blue,
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ${currencyFormatter.format(targetRevenue)}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
