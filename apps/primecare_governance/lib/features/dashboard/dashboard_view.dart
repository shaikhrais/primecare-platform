import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../core/ui/app_drawer.dart';
import '../../../core/ui/dev_toolbox.dart';
import '../../../core/ui/telemetry_hud.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enterprise Insights')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: _buildMetricCard('Active Users', '1,284', Icons.people, Colors.blue),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: TelemetryHud(),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: GestureDetector(
                onTap: () => context.push('/health'),
                child: _buildMetricCard('System Health', '99.9%', Icons.speed, Colors.green),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: GestureDetector(
                onTap: () => context.push('/governance/hud'),
                child: _buildMetricCard('Platform Governance', '0% Drift', Icons.gavel, Colors.deepPurple),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: GestureDetector(
                onTap: () => context.push('/proposals'),
                child: _buildMetricCard('Governance Proposals', '8 Pending', Icons.inbox_outlined, Colors.indigo),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: _buildMetricCard('Pending Audits', '14', Icons.assignment_late, Colors.orange),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: PrimeCareChartCard(
                title: 'User Activity Trend',
                chart: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(2.6, 2),
                            FlSpot(4.9, 5),
                            FlSpot(6.8, 3.1),
                            FlSpot(8, 4),
                            FlSpot(9.5, 3),
                            FlSpot(11, 4),
                          ],
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 4,
                          belowBarData: BarAreaData(show: true, color: Colors.blue.withValues(alpha: 0.1)),
                        ),
                      ],
                    ),
                  ),
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 1,
              child: DevToolbox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return PrimeCareKpiCard(
      title: title,
      value: value,
      icon: icon,
      color: color.withValues(alpha: 0.1),
    );
  }
}
