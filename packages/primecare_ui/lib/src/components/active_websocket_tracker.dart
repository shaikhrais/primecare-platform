import 'package:flutter/material.dart';

class ActiveWebSocketTracker extends StatelessWidget {
  const ActiveWebSocketTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'WSS Connections',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.green, size: 12),
              SizedBox(width: 8),
              Text(
                '1,402 Active',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
