import 'package:flutter/material.dart';

class PrimeCareTaskRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color statusColor;
  final VoidCallback onTap;

  const PrimeCareTaskRow({
    super.key,
    required this.icon,
    required this.title,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.circle, size: 12, color: statusColor),
      onTap: onTap,
    );
  }
}
