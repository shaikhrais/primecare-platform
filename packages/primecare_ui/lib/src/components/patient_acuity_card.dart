import 'package:flutter/material.dart';
import 'prime_card.dart';

class PatientAcuityCard extends StatelessWidget {
  final String name;
  final int acuityLevel; // 1: green, 2: yellow, 3: red
  const PatientAcuityCard({
    Key? key,
    required this.name,
    required this.acuityLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = acuityLevel == 3
        ? Colors.red
        : acuityLevel == 2
        ? Colors.orange
        : Colors.green;
    return PrimeCard(
      child: Row(
        children: [
          Container(width: 4, height: 40, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.monitor_heart, color: color),
        ],
      ),
    );
  }
}
