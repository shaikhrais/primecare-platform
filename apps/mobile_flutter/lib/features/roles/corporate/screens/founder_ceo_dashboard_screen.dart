import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FounderCeoDashboardScreen extends StatelessWidget {
  const FounderCeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'CEO Executive Dashboard | PrimeCare Health'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Dr. Eleanor Carter'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 32),
            const Text('Performance Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPerformanceRow(context),
            const SizedBox(height: 32),
            const Text('Operations & Growth', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildOperationsRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return const PrimeCareResponsiveKpiGrid(
 children: [
         SizedBox(child: PrimeCareStatCard(
                title: 'Total Franchise Locations',
                value: '38 active',
                delta: 3.2,
                icon: Icons.store_mall_directory,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'Total Revenue (YTD)',
                value: '\$24.8M',
                delta: 12.5,
                icon: Icons.attach_money,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'Total Patient Admissions',
                value: '112,450',
                delta: 8.1,
                icon: Icons.personal_injury,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'Average Clinic Rating',
                value: '4.8/5',
                delta: 0.2,
                icon: Icons.star_rate,
            ),
         ),
      ],
    );
  }

  Widget _buildPerformanceRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Map Placeholder
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Franchise Revenue Distribution', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  height: 220,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                      fit: BoxFit.contain,
                      opacity: 0.2,
                    )
                  ),
                  child: const Icon(Icons.location_on, size: 48, color: Color(0xFF0F4C81)),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Line Chart Placeholder 
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Network Performance vs Targets', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const SizedBox(
                  height: 220,
                  child: ServerLoadGraph(), // Native PrimeCare chart mapped visually to multiple lines
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Data Table Top Franchises
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Top Performing Franchises', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220,
                  child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Location', 'Director', 'Metric'],
                    data: const [
                      {'loc': 'Northon', 'dir': 'Dr. Carter', 'adm': '\$22.9M'},
                      {'loc': 'Weenchers', 'dir': 'Dr. Carter', 'adm': '\$22.8M'},
                      {'loc': 'Mendonarry', 'dir': 'Dr. Carter', 'adm': '\$24.8M'},
                      {'loc': 'Kantery', 'dir': 'Dr. Carter', 'adm': '\$24.8M'},
                    ],
                    rowBuilder: (data) => [
                      DataCell(Text(data['loc']!)),
                      DataCell(Text(data['dir']!)),
                      DataCell(Text(data['adm']!)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOperationsRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Bar Chart
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quarterly Revenue Trend', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const SizedBox(
                  height: 200,
                  child: PrimeCareBarChart(
                    data: {
                      'Q1': 2.4,
                      'Q2': 3.1,
                      'Q3': 3.8,
                      'Q4': 4.2
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Donut Chart Placeholder
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Patient Demographics', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                           width: 140, 
                           height: 140, 
                           child: CircularProgressIndicator(value: 1.0, color: Colors.teal.shade300, strokeWidth: 30)
                        ),
                        const SizedBox(
                           width: 140, 
                           height: 140, 
                           child: CircularProgressIndicator(value: 0.65, color: Color(0xFF0F4C81), strokeWidth: 30)
                        ),
                        const SizedBox(
                           width: 140, 
                           height: 140, 
                           child: CircularProgressIndicator(value: 0.25, color: Colors.lightBlue, strokeWidth: 30)
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Quality Metrics Progress Bars
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quality Metrics', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                _buildProgressMetric('Patient Satisfaction', 0.92, '92%'),
                const SizedBox(height: 16),
                _buildProgressMetric('Appointment Adherence', 0.96, '96%'),
                const SizedBox(height: 16),
                _buildProgressMetric('Staff Efficiency', 0.89, '89%'),
                const SizedBox(height: 16),
                _buildProgressMetric('System Analytics', 0.99, '99.9%'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressMetric(String label, double value, String percentageText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
             Text(percentageText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
           ],
        ),
        const SizedBox(height: 6),
        PrimeCareProgressBar(progress: value, activeColor: const Color(0xFF0F4C81)),
      ],
    );
  }
}
