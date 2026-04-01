import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/health_indicator.dart';
import '../../../../core/theme/app_theme.dart';

class CooDashboard extends ConsumerWidget {
  const CooDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent, // Inherit shell background
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'COO Operations Dashboard',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real-time metrics across top franchise territories.',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 32),
                  
                  // TOP KPI ROW (Responsive)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth > 900 ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildKpi(cardWidth, 'Staffing Efficiency', '94%', Icons.group_add, Colors.blue),
                          _buildKpi(cardWidth, 'Scheduling Accuracy', '98%', Icons.event_available, Colors.green),
                          _buildKpi(cardWidth, 'Avg Incident Response', '14m', Icons.report_problem, Colors.orange),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),

                  // BRANCH PERFORMANCE & ISSUES
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN: Branch Performance
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Branch Operational Performance', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildBranchMetric('Ontario South', 0.92, '92% Capacity'),
                                  const SizedBox(height: 24),
                                  _buildBranchMetric('New York Metro', 0.78, '78% Capacity'),
                                  const SizedBox(height: 24),
                                  _buildBranchMetric('Texas Central', 0.85, '85% Capacity'),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            Text('Staffing Efficiency Heatmap', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.map, size: 48, color: AppTheme.primary.withOpacity(0.5)),
                                    const SizedBox(height: 16),
                                    const Text('Interactive Staffing Heatmap Placeholder', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      
                      const SizedBox(width: 24),
                      
                      // RIGHT COLUMN: Critical Issues & Health
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Critical Issues', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _buildCriticalIssueCard('Hamilton Staffing Shortage', 'Night Shift', 'Low Coverage', Colors.red),
                            _buildCriticalIssueCard('Compliance Audit: NY', 'Documentation', 'Action Required', Colors.orange),
                            
                            const SizedBox(height: 32),
                            
                            Text('Service Delivery Health', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            GlassSurface(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Aggregated delivery success rates across all service lines (Last 30 Days)', style: TextStyle(color: Colors.blueGrey, fontSize: 13)),
                                  const SizedBox(height: 20),
                                  _buildDeliveryMetric('Nursing Visits', 0.98),
                                  const SizedBox(height: 16),
                                  _buildDeliveryMetric('PSW Care', 0.84),
                                  const SizedBox(height: 16),
                                  _buildDeliveryMetric('Therapy Services', 0.91),
                                ],
                              ),
                            )
                          ],
                        )
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

  Widget _buildKpi(double width, String title, String value, IconData icon, Color color) {
    return SizedBox(
      width: width,
      child: KpiStatCard(title: title, value: value, icon: icon, iconColor: color),
    );
  }

  Widget _buildBranchMetric(String name, double progress, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        HealthIndicator(progress: progress, height: 10),
      ],
    );
  }

  Widget _buildCriticalIssueCard(String title, String category, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('$category • $status', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryMetric(String name, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        HealthIndicator(progress: progress, height: 8),
      ],
    );
  }
}
