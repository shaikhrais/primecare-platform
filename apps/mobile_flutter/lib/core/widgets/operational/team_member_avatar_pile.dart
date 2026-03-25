import 'package:flutter/material.dart';

/// Auto-Scaffolded Component: [TeamMemberAvatarPile]
class TeamMemberAvatarPile extends StatelessWidget {
  final List<dynamic>? members;
  
  const TeamMemberAvatarPile({super.key, this.members});

  @override
  Widget build(BuildContext context) {
    if (members == null || members!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.people_outline, size: 24, color: Colors.blueGrey),
            SizedBox(height: 8),
            Text(
              'No active team members',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: -8, // overlap effect
      children: members!.take(15).map((m) {
        final name = m['name'] as String? ?? 'U';
        final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';
        return CircleAvatar(
          backgroundColor: Colors.blueAccent.shade100,
          child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }
}
