// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_prime_card.dart';

class EtaTrackerWidget extends StatelessWidget {
  const EtaTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareColors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.directions_car,
              color: PrimeCareColors.white,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fatima is arriving soon',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'ETA: 14 Mins • 2.1 miles away',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: PrimeCareColors.slate400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
