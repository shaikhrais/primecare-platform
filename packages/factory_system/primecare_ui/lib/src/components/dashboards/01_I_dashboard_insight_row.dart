// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../theme/01_I_primecare_theme.dart';

/// A standard row widget for displaying dashboard insights with type indicators.
class DashboardInsightRow extends StatelessWidget {
  final String title;
  final String description;
  final String type;

  const DashboardInsightRow({
    super.key,
    required this.title,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: _getTypeColor(type),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.typography.bodySmall.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'positive':
      case 'growth':
        return Colors.green;
      case 'warning':
      case 'risk':
        return Colors.orange;
      case 'negative':
      case 'critical':
        return Colors.red;
      case 'info':
      default:
        return Colors.blue;
    }
  }
}
