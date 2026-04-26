// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_prime_card.dart';
import 'package:primecare_ui/src/components/01_I_prime_status_badge.dart';

class NextShiftActionCard extends StatelessWidget {
  final String patientName;
  final String address;
  final String timeText;
  final Color badgeColor;

  const NextShiftActionCard({
    super.key,
    this.patientName = 'Eleanor Rigby',
    this.address = '123 Penny Lane, Liverpool',
    this.timeText = 'in 45 mins',
    this.badgeColor = PrimeCareColors.amber,
  });

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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              PrimeStatusBadge(text: timeText, color: badgeColor),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            patientName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            address,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: PrimeCareColors.slate400),
          ),
        ],
      ),
    );
  }
}
