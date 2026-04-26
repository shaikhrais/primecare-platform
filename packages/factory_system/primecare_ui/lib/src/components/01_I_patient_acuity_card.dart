// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_prime_card.dart';

class PatientAcuityCard extends StatelessWidget {
  final String name;
  final int acuityLevel; // 1: green, 2: yellow, 3: red
  const PatientAcuityCard({
    super.key,
    required this.name,
    required this.acuityLevel,
  });

  @override
  Widget build(BuildContext context) {
    final color = acuityLevel == 3
        ? PrimeCareColors.rose
        : acuityLevel == 2
        ? PrimeCareColors.amber
        : PrimeCareColors.emerald;
    return PrimeCard(
      child: Row(
        children: [
          Container(width: 4, height: 40, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.monitor_heart, color: color),
        ],
      ),
    );
  }
}
