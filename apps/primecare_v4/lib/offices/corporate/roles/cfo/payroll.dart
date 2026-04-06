import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class PayrollScreen extends ConsumerWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payroll & Compensation',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'High-level tracking of employee and contractor compensation.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('Total Monthly Run', '\$2.8M', LucideIcons.coins)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetric('Benefits Cost', '\$450k', LucideIcons.heartPulse)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetric('Tax Withholdings', '\$920k', LucideIcons.landmark)),
              ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Upcoming Payroll Runs', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 16),
                  _buildRunRow('Bi-Weekly Salaried', 'April 15, 2026', '\$1.2M', 'Pending Approval'),
                  _buildRunRow('Clinical Contractors', 'April 30, 2026', '\$850k', 'Processing'),
                  _buildRunRow('Executive Comp & Bonus', 'May 1, 2026', '\$250k', 'Draft'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String title, String value, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: PrimeCareTheme.colors.slateGray),
          const SizedBox(height: 16),
          Text(title, style: PrimeCareTheme.typography.label),
          const SizedBox(height: 8),
          Text(value, style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
        ],
      ),
    );
  }

  Widget _buildRunRow(String type, String date, String amt, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(type, style: PrimeCareTheme.typography.h3)),
          Expanded(flex: 2, child: Text(date, style: PrimeCareTheme.typography.body)),
          Expanded(flex: 2, child: Text(amt, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
