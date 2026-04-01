import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CfoSidebar extends StatelessWidget {
  const CfoSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white.withOpacity(0.05),
      child: ListView(
        children: [
          _buildItem(Icons.dashboard_outlined, 'Financial Dashboard'),
          _buildItem(Icons.receipt_long_outlined, 'Ledger Audit'),
          _buildItem(Icons.settings_outlined, 'Fiscal Settings'),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String label) {
    return ListTile(leading: Icon(icon, color: AppTheme.primary), title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)));
  }
}
