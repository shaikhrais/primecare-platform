import 'package:flutter/material.dart';

class AuditLogTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timestamp;
  final IconData icon;
  final Color iconColor;

  const AuditLogTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(
        timestamp,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
