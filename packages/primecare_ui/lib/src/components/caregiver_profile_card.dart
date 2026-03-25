import 'package:flutter/material.dart';
import 'prime_avatar.dart';

class CaregiverProfileCard extends StatelessWidget {
  const CaregiverProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const PrimeAvatar(fallbackInitials: 'FA', radius: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fatima Ahmed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                Text(
                  'Fluent in Arabic & English',
                  style: TextStyle(color: Colors.deepPurple.shade400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
