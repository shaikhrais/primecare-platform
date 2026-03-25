import 'package:flutter/material.dart';
import 'prime_card.dart';
import 'prime_status_badge.dart';

class NextShiftActionCard extends StatelessWidget {
  const NextShiftActionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PrimeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next Shift',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              PrimeStatusBadge(text: 'in 45 mins', color: Colors.orange),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Eleanor Rigby',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '123 Penny Lane, Liverpool',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
