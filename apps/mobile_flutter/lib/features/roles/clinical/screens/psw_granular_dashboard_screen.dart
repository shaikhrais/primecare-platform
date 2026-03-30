import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/api_client.dart';

final pswMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await apiClient.get('/v1/clinical/psw/metrics');
});

class PswGranularDashboardScreen extends ConsumerWidget {
  const PswGranularDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(pswMetricsProvider);

    return PageTemplate(
      title: 'PSW Management Dashboard | June 18, 2024',
      subtitle: 'Welcome, Administrator Sarah J.',
      kpiCards: null, // Custom Grid below
      children: [
        metricsAsync.when(
          data: (data) => _buildDashboardGrid(context, data),
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (err, stack) => Center(child: Text('Error loading dashboard: $err', style: const TextStyle(color: Colors.red))),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context, Map<String, dynamic> data) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Overview, Map, Feed
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 2 : 0, child: _buildOverviewCard()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 2 : 0, child: _buildMapCard()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: isDesktop ? 1 : 0, child: _buildActivityFeed()),
          ],
        ),
        const SizedBox(height: 16),
        // Bottom Row: Clients, Staff, Tasks, Satisfaction
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _buildClientManagement()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildStaffAvailability()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildUpcomingTasks()),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
            Expanded(flex: 1, child: _buildVisitSatisfaction()),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Chip(label: const Text('Daily visits', style: TextStyle(fontSize: 12)), backgroundColor: Colors.teal.shade50),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               _statColumn('Active PSWs', '142'),
               _statColumn('Scheduled Visits', '387'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [FlSpot(0, 50), FlSpot(1, 100), FlSpot(2, 80), FlSpot(3, 150), FlSpot(4, 90), FlSpot(5, 200), FlSpot(6, 120)],
                    isCurved: true,
                    color: Colors.teal,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: true, color: Colors.teal.withOpacity(0.2)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               _statColumn('Clients Served', '215'),
               _statColumn('Performance Score', '94%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ],
    );
  }

  Widget _buildMapCard() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Real-Time Map', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('24 active PSWs and scheduled client visits in the city.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          SizedBox(
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(43.651070, -79.347015), // Example City
                  initialZoom: 11.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.primecare.app',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(point: LatLng(43.66, -79.35), child: Icon(Icons.location_on, color: Colors.teal, size: 30)),
                      Marker(point: LatLng(43.64, -79.38), child: Icon(Icons.location_on, color: Colors.amber, size: 30)),
                      Marker(point: LatLng(43.68, -79.40), child: Icon(Icons.location_on, color: Colors.redAccent, size: 30)),
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

  Widget _buildActivityFeed() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Activity Feed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
             height: 250,
             child: ListView(
                children: _buildFeedItems(),
             ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildFeedItems() {
     return [
        _feedItem('David L.', 'started visit @ 9:02 AM', Colors.teal),
        _feedItem('Maria K.', 'completed care plan @ 8:45 AM', Colors.grey),
        _feedItem('Maria L.', 'completed completed care plan @ 8:45 AM', Colors.teal),
        _feedItem('David L.', 'started visit @ 9:02 AM', Colors.teal),
     ];
  }

  Widget _feedItem(String name, String action, Color badgeColor) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 12.0),
       child: Row(
         children: [
            CircleAvatar(radius: 12, backgroundColor: badgeColor, child: const Icon(Icons.access_time, size: 12, color: Colors.white)),
            const SizedBox(width: 12),
            Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(action, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                 ],
               )
            )
         ],
       ),
     );
  }

  Widget _buildClientManagement() {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Client Management', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Client Needs Breakdown', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                   BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 60, color: Colors.teal)]),
                   BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 40, color: Colors.teal.shade300)]),
                   BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 90, color: Colors.teal.shade700)]),
                   BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 75, color: Colors.teal)]),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildStaffAvailability() {
    return PrimeCareCard(
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            const Text('Staff Availability', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
               height: 160,
               child: Stack(
                 alignment: Alignment.center,
                 children: [
                   PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: [
                           PieChartSectionData(color: Colors.teal, value: 68, title: '', radius: 25),
                           PieChartSectionData(color: Colors.teal.shade300, value: 22, title: '', radius: 25),
                           PieChartSectionData(color: Colors.grey.shade400, value: 10, title: '', radius: 25),
                        ]
                      )
                   ),
                   const Text('68%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                 ],
               ),
            ),
         ]
      )
    );
  }

  Widget _buildUpcomingTasks() {
     return PrimeCareCard(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('Upcoming Tasks', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
             const SizedBox(height: 16),
             _taskItem('Important deadlines', 'June 18, 2024', Colors.red),
             _taskItem('Schedule Visit', 'June 18, 2024', Colors.teal),
             _taskItem('Maria K. completed care plan @ visit', 'June 18, 2024', Colors.teal.shade300),
             _taskItem('Companion', 'June 18, 2024', Colors.teal),
          ]
       )
     );
  }

  Widget _taskItem(String title, String date, Color color) {
     return Container(
       margin: const EdgeInsets.only(bottom: 12),
       decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 4))
       ),
       padding: const EdgeInsets.only(left: 8),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
         ],
       )
     );
  }

  Widget _buildVisitSatisfaction() {
     return PrimeCareCard(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('Visit Satisfaction', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
             const Text('Average Rating', style: TextStyle(color: Colors.grey, fontSize: 12)),
             const Text('4.8/5.0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
             const SizedBox(height: 16),
             SizedBox(
               height: 110,
               child: LineChart(
                 LineChartData(
                   gridData: const FlGridData(show: false),
                   titlesData: const FlTitlesData(show: false),
                   borderData: FlBorderData(show: false),
                   lineBarsData: [
                     LineChartBarData(
                       spots: const [FlSpot(0, 2), FlSpot(1, 1.5), FlSpot(2, 3), FlSpot(3, 2.5), FlSpot(4, 4), FlSpot(5, 3.8), FlSpot(6, 4.8)],
                       isCurved: true,
                       color: Colors.teal,
                       barWidth: 3,
                       dotData: const FlDotData(show: false),
                     )
                   ]
                 )
               )
             )
          ]
       )
     );
  }
}
