import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/api_providers.dart';

class BillingDashboard extends ConsumerWidget {
  const BillingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.watch(dioProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Revenue & Billing Administration',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Managing institutional claims, caregiver payroll cycles, and accounts receivable.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blueGrey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BILLING KPI ROW
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 1200 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Total Revenue', '$142k', Icons.monetization_on_outlined, AppTheme.primary, 'MTD Collection'),
                          _buildKpi(cardWidth, 'Pending Items', '24', Icons.receipt_long_outlined, Colors.orange, 'Unprocessed claims'),
                          _buildKpi(cardWidth, 'Arrears (30d+)', '$12.4k', Icons.warning_amber_outlined, Colors.redAccent, '4 High-risk payers'),
                          _buildKpi(cardWidth, 'Payroll Health', '99.8%', Icons.account_balance_outlined, Colors.teal, 'Verified cycle'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Pending Invoices
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Institutional Claims Queue', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildBillingRow('Hamilton Health Cluster', 'Q1 Services', '$14,200', 'READY'),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildBillingRow('Ministry of Health', 'Provider Remittance', '$82,400', 'OVERDUE', isOverdue: true),
                                  const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                  _buildBillingRow('Private Insurer (Manulife)', 'Occupational Therapy', '$4,200', 'PENDING'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: Ledger Logs
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Financial Audit Trail', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuditLogTile(title: 'Payment Received', subtitle: 'Toronto East - #INV-401', timestamp: '5m ago', icon: Icons.download_done, iconColor: Colors.teal),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Invoice Disputed', subtitle: 'Reason: Hour mismatch', timestamp: '2h ago', icon: Icons.help_outline, iconColor: Colors.orange),
                                  const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                  AuditLogTile(title: 'Payroll Verified', subtitle: '62 Caregivers (MTD)', timestamp: '1d ago', icon: Icons.verified, iconColor: Colors.teal),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color, [String? subtitle]) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, subtitle: subtitle, icon: icon, iconColor: color),
    );
  }

  Widget _buildBillingRow(String entity, String title, String value, String status, {bool isOverdue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isOverdue ? Colors.red.withOpacity(0.1) : AppTheme.primary.withOpacity(0.1),
            child: Icon(Icons.receipt_outlined, color: isOverdue ? Colors.red : AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entity, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(title, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: isOverdue ? Colors.red : AppTheme.primary, fontSize: 14)),
              Text(status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.blueGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
