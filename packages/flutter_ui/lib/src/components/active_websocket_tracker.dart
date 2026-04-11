import 'package:flutter/material.dart';
import 'prime_card.dart';

class ActiveWebSocketTracker extends StatelessWidget {
  final int activeConnections;
  final int pendingJobQueue;
  final double systemScore;

  const ActiveWebSocketTracker({
    super.key,
    this.activeConnections = 142,
    this.pendingJobQueue = 12,
    this.systemScore = 98.5,
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
                'WSS Pool Activity',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            'Active Endpoints',
            activeConnections.toString(),
            Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            'Job Queue (Pending)',
            pendingJobQueue.toString(),
            Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            'Model Health Score',
            '${systemScore.toStringAsFixed(1)}/100',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String val, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.black87),
        ),
        Text(
          val,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
