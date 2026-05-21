import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CommunityOutreachDashboardScreen extends StatefulWidget {
  const CommunityOutreachDashboardScreen({super.key});

  @override
  State<CommunityOutreachDashboardScreen> createState() =>
      _CommunityOutreachDashboardScreenState();
}

class _CommunityOutreachDashboardScreenState
    extends State<CommunityOutreachDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Outreach Dashboard'),
        backgroundColor: const Color(0xFF0F766E), // Sleek Teal
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF0FDF4), // Minty background
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
                      'Outreach & Engagement Hub',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF115E59),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage community seminars, volunteer staffing, and clinic partnerships.',
                      style: TextStyle(color: Colors.teal.shade800.withOpacity(0.7), fontSize: 14),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: const Text('Schedule Event'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
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
                      'Active Volunteers',
                      '148 Users',
                      LucideIcons.users,
                      const Color(0xFF0D9488),
                    ),
                    _buildMetricCard(
                      'Upcoming Events',
                      '5 Slated',
                      LucideIcons.calendar,
                      const Color(0xFF3B82F6),
                    ),
                    _buildMetricCard(
                      'Active Partners',
                      '12 B2B Org',
                      LucideIcons.heart,
                      const Color(0xFF8B5CF6),
                    ),
                    _buildMetricCard(
                      'Event RSVP Goal',
                      '340 / 400',
                      LucideIcons.smile,
                      const Color(0xFFF59E0B),
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
                      _buildUpcomingEvents(),
                      const SizedBox(height: 24),
                      _buildB2BPartnerships(),
                      const SizedBox(height: 24),
                      _buildVolunteerActivity(),
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
                            _buildUpcomingEvents(),
                            const SizedBox(height: 24),
                            _buildB2BPartnerships(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: _buildVolunteerActivity(),
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
            color: Colors.teal.withOpacity(0.04),
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

  Widget _buildUpcomingEvents() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.04),
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
                'Slated Outreach Seminars & Events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(LucideIcons.calendarRange, color: Colors.teal),
            ],
          ),
          const SizedBox(height: 20),
          _buildEventItem(
            'Oakridge Senior Center Health Seminar',
            'May 24, 2026 at 2:00 PM',
            'Oakridge Center Hall',
            '4 Volunteers Staged',
            Colors.teal,
          ),
          _buildEventItem(
            'Spring Wellness & Mobility Fair',
            'May 28, 2026 at 10:00 AM',
            'Civic Center Arena',
            '12 Volunteers Staged',
            Colors.blue,
          ),
          _buildEventItem(
            'Hospital Care Coordinators Networking Luncheon',
            'June 02, 2026 at 12:30 PM',
            'Granite Club Room A',
            '2 Staff Staged',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(
      String title, String datetime, String location, String staffStatus, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(LucideIcons.checkSquare, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(LucideIcons.clock, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(datetime, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    const SizedBox(width: 12),
                    Icon(LucideIcons.mapPin, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(location, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              staffStatus,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildB2BPartnerships() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active B2B Partnerships',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(1.8),
              2: FlexColumnWidth(1.8),
              3: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Partner Entity', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Outreach Frequency', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                ],
              ),
              _buildPartnerRow('Westside Community Clinic', 'Clinical Referral', 'Monthly Seminars', 'Active', Colors.green),
              _buildPartnerRow('Oakridge Manor Seniors', 'Assisted Living', 'Bi-Weekly Visits', 'Active', Colors.green),
              _buildPartnerRow('St. Jude Discharge Dept.', 'Hospital Planner', 'Weekly Drops', 'Pending Renewal', Colors.orange),
              _buildPartnerRow('Trinity Health Association', 'NGO Foundation', 'Quarterly Co-Host', 'Active', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildPartnerRow(
      String partner, String type, String frequency, String status, Color statusColor) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(partner, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(type, style: TextStyle(color: Colors.grey.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(frequency, style: TextStyle(color: Colors.grey.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVolunteerActivity() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.04),
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
                'Volunteer Tracking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(LucideIcons.users, color: Colors.teal),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Onboarding Checklist',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 12),
          _buildChecklistItem('Verify background checks', 0.90, '14 Done / 15 Pending', Colors.teal),
          _buildChecklistItem('Verify CPR / First Aid Cert', 0.70, '10 Done / 15 Pending', Colors.blue),
          _buildChecklistItem('Complete Orientation seminar', 0.45, '6 Done / 15 Pending', Colors.purple),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'Quick Actions',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(backgroundColor: Color(0xFFE0F2FE), child: Icon(Icons.send, color: Colors.blue)),
            title: const Text('Send Newsletter Blast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            subtitle: const Text('Outreach newsletter template', style: TextStyle(fontSize: 11)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(backgroundColor: Color(0xFFF3E8FF), child: Icon(Icons.call, color: Colors.purple)),
            title: const Text('Call Pending Volunteers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            subtitle: const Text('Call pipeline backlog list', style: TextStyle(fontSize: 11)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(
      String title, double progress, String metrics, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF334155),
                ),
              ),
              Text(
                metrics,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}