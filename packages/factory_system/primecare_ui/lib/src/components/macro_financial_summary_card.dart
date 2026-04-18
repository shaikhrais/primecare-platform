import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'prime_card.dart';
import 'package:intl/intl.dart';

class MacroFinancialSummaryCard extends StatelessWidget {
  final double currentRevenue;
  final double targetRevenue;

  const MacroFinancialSummaryCard({
    super.key,
    this.currentRevenue = 24500.0,
    this.targetRevenue = 25000.0,
  });

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
              const Text(
                'Period Revenue',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: PrimeCareColors.slate400,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive
                    ? PrimeCareColors.emerald
                    : PrimeCareColors.rose,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormatter.format(currentRevenue),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            backgroundColor: PrimeCareColors.slate400,
            color: isPositive
                ? PrimeCareColors.emerald
                : Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ${currencyFormatter.format(targetRevenue)}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: PrimeCareColors.slate400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
