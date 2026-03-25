import 'package:flutter/material.dart';
import 'prime_card.dart';

class MacroFinancialSummaryCard extends StatelessWidget {
  const MacroFinancialSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PrimeCard(
      child: Column(
        children: [
          Text('Branch P&L Target', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text(
            '\$142,500',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            '+4.2% vs Last Month',
            style: TextStyle(color: Colors.green, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
