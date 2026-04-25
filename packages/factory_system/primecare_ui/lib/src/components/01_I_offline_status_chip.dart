// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

class OfflineStatusChip extends StatelessWidget {
  const OfflineStatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        border: Border.all(color: const Color(0xFFEF4444)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off, size: 12, color: Color(0xFFEF4444)),
          SizedBox(width: 4),
          Text(
            'OFFLINE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }
}
