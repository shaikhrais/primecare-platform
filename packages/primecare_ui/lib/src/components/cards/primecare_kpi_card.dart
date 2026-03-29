import 'package:flutter/material.dart';

class PrimeCareKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String subtitle;

  const PrimeCareKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF1E88E5), size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 6,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            subtitle,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A)),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
