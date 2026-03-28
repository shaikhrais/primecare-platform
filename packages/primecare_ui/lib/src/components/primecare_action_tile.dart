import 'package:flutter/material.dart';

class PrimeCareActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const PrimeCareActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
