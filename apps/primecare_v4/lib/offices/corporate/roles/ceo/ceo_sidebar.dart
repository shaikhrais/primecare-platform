import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class CeoSidebar extends StatelessWidget {
  const CeoSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white.withValues(alpha: 0.05),
      child: ListView(
        children: [
          _buildItem(context, Icons.dashboard_outlined, 'Executive Dashboard'),
          _buildItem(context, Icons.payments_outlined, 'Financial Overview'),
          _buildItem(context, Icons.settings_outlined, 'System Settings'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String label) {
    return ListTile(
      key: const Key('data-status-id=corporate-ceo-ceo-action-1'),
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () => context.go(
        '/dashboard/ceo/${label.toLowerCase().replaceAll(' ', '-')}',
      ),
    );
  }
}
