// Governance - Category: view | Purpose: UI Screen component rendering the Territory Sales Manager Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TerritorySalesManagerDashboardScreen extends StatefulWidget {
  const TerritorySalesManagerDashboardScreen({super.key});

  @override
  State<TerritorySalesManagerDashboardScreen> createState() =>
      _TerritorySalesManagerDashboardScreenState();
}

class _TerritorySalesManagerDashboardScreenState
    extends State<TerritorySalesManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Territory Sales Dashboard'),
        backgroundColor: const Color(0xFF1E3A8A), // Royal Indigo
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEFF6FF), // Indigo tint background
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Territory Performance Intelligence',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Track regional conversions, hospital discharge planners, and site visits.',
                      style: TextStyle(color: Colors.indigo.shade800.withOpacity(0.7), fontSize: 14),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on, size: 18),
                  label: const Text('Map View'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Top Metrics Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                final bool isMobile = width < 768;
                return GridView.count(
                  crossAxisCount: isMobile ? 2 : 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isMobile ? 1.4 : 1.6,
                  children: [
                    _buildMetricCard(
                      'Pipeline Value',
                      r'$425,000',
                      LucideIcons.trendingUp,
                      const Color(0xFF2563EB),
                    ),
                    _buildMetricCard(
                      'Field Sites Visited',
                      '18 / 25',
                      LucideIcons.mapPin,
                      const Color(0xFF10B981),
                    ),
                    _buildMetricCard(
                      'Conversion Rate',
                      '8.2%',
                      LucideIcons.percent,
                      const Color(0xFFF59E0B),
                    ),
                    _buildMetricCard(
                      'Active Reps',
                      '4 Active',
                      LucideIcons.shieldAlert,
                      const Color(0xFFEC4899),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),

            // Main Content Area
            LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                if (width < 1024) {
                  return Column(
                    children: [
                      _buildSalesFunnel(),
                      const SizedBox(height: 24),
                      _buildTerritoryOverview(),
                      const SizedBox(height: 24),
                      _buildFieldActivityFeed(),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildSalesFunnel(),
                            const SizedBox(height: 24),
                            _buildTerritoryOverview(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: _buildFieldActivityFeed(),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesFunnel() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Territory Deal Stage Funnel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(LucideIcons.activity, color: Colors.indigo),
            ],
          ),
          const SizedBox(height: 20),
          _buildFunnelRow('Leads Generated', 320, 1.0, Colors.grey),
          _buildFunnelRow('Qualified & Visited', 140, 0.44, Colors.blue),
          _buildFunnelRow('Consultations Booked', 48, 0.15, Colors.orange),
          _buildFunnelRow('Converted Deals', 26, 0.08, Colors.green),
        ],
      ),
    );
  }

  Widget _buildFunnelRow(
      String label, int count, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerritoryOverview() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Territory Demographics & Market Share',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Zone / County', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Total Pop.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Senior %', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Active Clients', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Share', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                ],
              ),
              _buildTerritoryRow('Downtown Core', '124,000', '18.4%', '42', '12%'),
              _buildTerritoryRow('Westside Suburban', '185,000', '22.1%', '85', '28%'),
              _buildTerritoryRow('East Gate County', '94,000', '26.8%', '54', '18%'),
              _buildTerritoryRow('North Valley', '68,000', '14.2%', '18', '6%'),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTerritoryRow(
      String zone, String pop, String seniorDensity, String clients, String share) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(zone, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(pop, style: TextStyle(color: Colors.grey.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(seniorDensity, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(clients, style: TextStyle(color: Colors.grey.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(share, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildFieldActivityFeed() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Field Activity Feed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(LucideIcons.compass, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 18),
          _buildActivityItem('Hospital Visit', 'Met with St. Jude Discharge Planners, dropped off flyers.', '2 hours ago', Colors.purple),
          _buildActivityItem('Senior Living Presentation', 'Hosted wellness mobility Q&A at Oakridge Manor.', '5 hours ago', Colors.green),
          _buildActivityItem('Physician Outreach', 'B2B meeting with Westside Family Clinic Clinical Director.', 'Yesterday', Colors.blue),
          _buildActivityItem('Community Booth Set Up', 'Secured active booth placement for Spring Mobility Fair.', '2 days ago', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String desc, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
