import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AuditLogTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String timestamp;
  final IconData? icon;
  final Color? iconColor;

  const AuditLogTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.timestamp,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (iconColor ?? AppTheme.primary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon ?? Icons.history,
              size: 20,
              color: iconColor ?? AppTheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.blueGrey.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
