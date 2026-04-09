import 'package:flutter/material.dart';
import 'prime_card.dart';

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
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.directions_car, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fatima is arriving soon', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('ETA: 14 Mins • 2.1 miles away', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
