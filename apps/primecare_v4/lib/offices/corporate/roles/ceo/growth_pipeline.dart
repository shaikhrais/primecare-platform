import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoGrowthPipelineScreen extends ConsumerStatefulWidget {
  const CeoGrowthPipelineScreen({super.key});

  @override
  ConsumerState<CeoGrowthPipelineScreen> createState() => _CeoGrowthPipelineScreenState();
}

class _CeoGrowthPipelineScreenState extends ConsumerState<CeoGrowthPipelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildKPIs(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildPipelineFunnelWidget(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildUpcomingLaunchesWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.gitMerge, color: PrimeCareTheme.colors.navyIndigo, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Growth Pipeline',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Track expansion initiatives and the new franchise acquisition pipeline.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
           children: [
               Container(
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(LucideIcons.filter, size: 18, color: PrimeCareTheme.colors.slateGray),
                      const SizedBox(width: 8),
                      Text('All Markets', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                       const SizedBox(width: 8),
                      Icon(LucideIcons.chevronDown, size: 18, color: PrimeCareTheme.colors.slateGray),
                    ],
                  ),
                ),
           ]
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
             title: 'Active Leads',
             value: '142',
             icon: LucideIcons.users,
             trend: '+12 this month',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Target Markets',
            value: '8',
            icon: LucideIcons.mapPin,
            trend: 'Across 2 regions',
            isNeutral: true,
          ),
        ),
        const SizedBox(width: 24),
         Expanded(
          child: _buildMetricCard(
             title: 'Win Rate',
             value: '24.5%',
             icon: LucideIcons.checkCircle,
             trend: '+2.1% YoY',
             isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Deal Size',
            value: '\$125K',
            icon: LucideIcons.dollarSign,
            trend: 'Franchise Fee',
            isNeutral: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required IconData icon, required String trend, bool isWarning = false, bool isPositive = false, bool isNeutral = false}) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;
    
    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (isNeutral) {
      trendColor = PrimeCareTheme.colors.navyIndigo;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 title,
                 style: PrimeCareTheme.typography.label.copyWith(
                   color: PrimeCareTheme.colors.slateGray,
                 ),
               ),
               Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPipelineFunnelWidget() {
     return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                           'Sales Pipeline Funnel',
                           style: PrimeCareTheme.typography.h3.copyWith(
                              color: PrimeCareTheme.colors.navyIndigo,
                           ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                           'Franchise acquisition stages.',
                           style: PrimeCareTheme.typography.body.copyWith(
                              color: PrimeCareTheme.colors.slateGray,
                           ),
                        ),
                     ],
                  ),
                  Icon(LucideIcons.filter, color: PrimeCareTheme.colors.emeraldTeal, size: 28),
               ],
            ),
            const SizedBox(height: 48),
            _buildFunnelLevel('Prospects', 142, '\$17.7M', 1.0, PrimeCareTheme.colors.navyIndigo),
            const SizedBox(height: 16),
             _buildFunnelLevel('Qualified', 86, '\$10.7M', 0.8, PrimeCareTheme.colors.emeraldTeal),
             const SizedBox(height: 16),
             _buildFunnelLevel('Contracting', 32, '\$4.0M', 0.6, Colors.amber.shade600),
             const SizedBox(height: 16),
             _buildFunnelLevel('Closed Won', 15, '\$1.8M', 0.4, PrimeCareTheme.colors.navyIndigo),
        ],
      )
     );
  }

  Widget _buildFunnelLevel(String stage, int count, String value, double widthFactor, Color color) {
       return Center(
          child: FractionallySizedBox(
             widthFactor: widthFactor,
             child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                   color: color.withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(12),
                   border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Text(
                         stage,
                         style: PrimeCareTheme.typography.body.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                         ),
                      ),
                      Row(
                         children: [
                           Text(
                               '$count',
                               style: PrimeCareTheme.typography.body.copyWith(
                                  color: PrimeCareTheme.colors.navyIndigo,
                                  fontWeight: FontWeight.bold,
                               ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                               value,
                               style: PrimeCareTheme.typography.label.copyWith(
                                  color: PrimeCareTheme.colors.slateGray,
                               ),
                            ),
                         ],
                      )
                   ],
                ),
             )
          ),
       );
  }


   Widget _buildUpcomingLaunchesWidget() {
     return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
             padding: const EdgeInsets.all(24.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  Text(
                    'Upcoming Launches',
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                   Icon(LucideIcons.rocket, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
               ],
             ),
          ),
          Container(
             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
             color: PrimeCareTheme.colors.surfaceContainerLow,
             child: Row(
               children: [
                 Expanded(flex: 3, child: Text('LOCATION', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                 Expanded(flex: 2, child: Text('DATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
                 Expanded(flex: 2, child: Text('STATUS', textAlign: TextAlign.right, style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
               ],
             ),
          ),
          _buildLaunchRow('Denver Central', 'Oct 15, 2026', 'On Track', PrimeCareTheme.colors.emeraldTeal),
           Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildLaunchRow('Miami South', 'Nov 01, 2026', 'On Track', PrimeCareTheme.colors.emeraldTeal),
           Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildLaunchRow('Chicago Metro', 'Dec 15, 2026', 'Delayed', Colors.amber.shade700),
           Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildLaunchRow('Boston East', 'Jan 10, 2027', 'Planning', PrimeCareTheme.colors.navyIndigo),
           Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildLaunchRow('Phoenix Valley', 'Feb 05, 2027', 'Planning', PrimeCareTheme.colors.navyIndigo),
          const SizedBox(height: 12),
        ],
      )
     );
   }

   Widget _buildLaunchRow(String location, String date, String status, Color statusColor) {
      return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
         child: Row(
            children: [
               Expanded(flex: 3, child: Text(location, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold))),
               Expanded(flex: 2, child: Text(date, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray))),
               Expanded(flex: 2, child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                     decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                     child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
                  ),
               )),
            ],
         ),
      );
   }
}
