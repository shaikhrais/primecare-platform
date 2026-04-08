import 'package:flutter/material.dart';
import 'package:primecare_core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class CfoSidebar extends StatelessWidget {
  const CfoSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white.withValues(alpha: 0.05),
      child: ListView(
        children: [
          _buildItem(context, Icons.dashboard_outlined, 'Financial Dashboard'),
          _buildItem(context, Icons.receipt_long_outlined, 'Ledger Audit'),
          _buildItem(context, Icons.settings_outlined, 'Fiscal Settings'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String label) {
    return ListTile(
      key: const Key('data-status-id=corporate-cfo-cfo-action-1'),
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () => context.go(
        '/dashboard/cfo/${label.toLowerCase().replaceAll(' ', '-')}',
      ),
    );
  }
}
