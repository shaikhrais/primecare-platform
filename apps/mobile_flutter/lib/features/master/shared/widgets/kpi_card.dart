import 'package:flutter/material.dart';

class UnifiedKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  
  const UnifiedKpiCard({
    super.key, 
    required this.title, 
    required this.value,
    this.icon = Icons.insights,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
