import 'package:flutter/material.dart';
import 'package:flutter_ui/flutter_ui.dart';

class PrimeClientIntelCard extends StatelessWidget {
  final String clientName;
  final int age;
  final String condition;
  final List<Widget> conditionBadges;

  const PrimeClientIntelCard({
    super.key,
    required this.clientName,
    required this.age,
    required this.condition,
    required this.conditionBadges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Client Intel",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        PrimeCareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$clientName ($age)',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Condition: $condition',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Wrap(spacing: 8.0, runSpacing: 8.0, children: conditionBadges),
            ],
          ),
        ),
      ],
    );
  }
}
