import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OperationsOverviewScreen extends StatelessWidget {
  const OperationsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildHealthMatrix(context),
                            const SizedBox(height: 24),
                            _buildRecentAlerts(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildQuickActions(context),
                            const SizedBox(height: 24),
                            _buildPlatformStatus(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Operations Command Center',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Global franchise operations, health status, and active alerts overview',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.refreshCw, 'Refresh Dash'),
            const SizedBox(width: 12),
             _buildActionIconButton(context, LucideIcons.download, 'Daily Report'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'Global Efficiency', '94.2%', LucideIcons.activity, '+1.2%', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Active Branches', '42 / 42', LucideIcons.building2, '100%', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Active Staff', '1,204', LucideIcons.users, '-52', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Pending Escalations', '12', LucideIcons.alertOctagon, '+3', Colors.redAccent)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String trend, Color trendColor) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: PrimeCareTheme.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: trendColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    Widget _buildHealthMatrix(BuildContext context) {
      return ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    'Regional Health Matrix',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                      children: [
                          Expanded(child: _buildRegionHealth('Eastern', 0.98, PrimeCareTheme.emeraldTeal, 'Stable')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildRegionHealth('Central', 0.95, PrimeCareTheme.emeraldTeal, 'Stable')),
                          const SizedBox(width: 16),
                            Expanded(child: _buildRegionHealth('Western', 0.85, Colors.orange, 'Issues')),
                          const SizedBox(width: 16),
                           Expanded(child: _buildRegionHealth('Atlantic', 0.92, PrimeCareTheme.emeraldTeal, 'Stable')),
                      ],
                  )
              ],
          )
      );
  }

  Widget _buildRegionHealth(String region, double score, Color color, String status) {
      return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text(region, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  Stack(
                      alignment: Alignment.center,
                      children: [
                          SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                  value: score,
                                  backgroundColor: Colors.white12,
                                  color: color,
                                  strokeWidth: 6,
                              ),
                          ),
                          Text('${(score * 100).toInt()}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                  ),
                  const SizedBox(height: 12),
                  Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
          ),
      );
  }

  Widget _buildRecentAlerts(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Recent Global Alerts',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                TextButton(onPressed: (){}, child: const Text('View All', style: TextStyle(color: PrimeCareTheme.emeraldTeal)))
            ],
          ),
          const SizedBox(height: 16),
          _buildAlertItem('SUP-9021 Escalated', 'Vancouver West CRM outage confirmed. CTO notified.', 'Critical', Colors.redAccent, '10m ago'),
          const Divider(color: Colors.white12, height: 24),
          _buildAlertItem('Staffing Shortage Warning', 'Calgary North dip below 85% fill rate.', 'High', Colors.orange, '45m ago'),
          const Divider(color: Colors.white12, height: 24),
           _buildAlertItem('Compliance Audit Scheduled', 'Toronto Central unannounced audit next week.', 'Info', Colors.blue, '2h ago'),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String desc, String severity, Color color, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.bell, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
               Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const SizedBox(height: 16),
            _buildActionButton(LucideIcons.messageSquare, 'Message Branch Managers'),
            const SizedBox(height: 12),
            _buildActionButton(LucideIcons.fileSpreadsheet, 'Generate Custom Report'),
            const SizedBox(height: 12),
            _buildActionButton(LucideIcons.megaphone, 'Issue Global Directive'),
             const SizedBox(height: 12),
            _buildActionButton(LucideIcons.calendarPlus, 'Schedule Emergency Ops Call'),

          ],
        ),
      );
  }

   Widget _buildActionButton(IconData icon, String label) {
       return SizedBox(
           width: double.infinity,
           child: ElevatedButton.icon(
               icon: Icon(icon, size: 18),
               label: Text(label),
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white.withValues(alpha: 0.1),
                   foregroundColor: Colors.white,
                   alignment: Alignment.centerLeft,
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                   side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
               ),
               onPressed: (){},
           ),
       );
   }

    Widget _buildPlatformStatus(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.server, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Platform Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSystemStatus('Core Registry', true),
            const SizedBox(height: 12),
            _buildSystemStatus('Routing Logic', true),
             const SizedBox(height: 12),
            _buildSystemStatus('CRM Database', false),
            const SizedBox(height: 12),
            _buildSystemStatus('Payroll Integration', true),
          ],
        ),
      );
    }

     Widget _buildSystemStatus(String system, bool isOnline) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(system, style: const TextStyle(color: Colors.white70)),
                Row(
                    children: [
                        Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isOnline ? PrimeCareTheme.emeraldTeal : Colors.redAccent,
                            )
                        ),
                        const SizedBox(width: 8),
                        Text(isOnline ? 'Online' : 'Outage', style: TextStyle(color: isOnline ? Colors.white : Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                    ]
                )
            ]
        );
     }
}
