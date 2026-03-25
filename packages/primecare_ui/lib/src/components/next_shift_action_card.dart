import 'package:flutter/material.dart';
import 'prime_card.dart';
import 'prime_status_badge.dart';

class NextShiftActionCard extends StatelessWidget {
  final String patientName;
  final String address;
  final String timeText;
  final Color badgeColor;

  const NextShiftActionCard({
    Key? key,
    this.patientName = 'Eleanor Rigby',
    this.address = '123 Penny Lane, Liverpool',
    this.timeText = 'in 45 mins',
    this.badgeColor = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next Shift',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              PrimeStatusBadge(text: timeText, color: badgeColor),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            patientName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            address,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
