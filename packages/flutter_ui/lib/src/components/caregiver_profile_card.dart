import 'package:flutter/material.dart';
import 'prime_card.dart';

class CaregiverProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;
  final String specialty;

  const CaregiverProfileCard({
    super.key,
    this.name = 'Sarah Jenkins',
    this.role = 'Primary PSW',
    this.rating = 4.9,
    this.specialty = 'Dementia Specialist',
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColorLight,
            child: Icon(
              Icons.person,
              size: 36,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        specialty,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
