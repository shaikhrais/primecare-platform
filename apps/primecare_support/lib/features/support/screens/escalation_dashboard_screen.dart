// Governance - Category: view | Purpose: UI Screen component rendering the Escalation Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EscalationDashboardScreen extends StatefulWidget {
  const EscalationDashboardScreen({Key? key}) : super(key: key);

  @override
  State<EscalationDashboardScreen> createState() => _EscalationDashboardScreenState();
}

class _EscalationDashboardScreenState extends State<EscalationDashboardScreen> {
  final List<Map<String, dynamic>> _escalations = [
    {
      'id': 'ESC-102',
      'title': 'P0 Outage: Geolocation Service Failure',
      'subsystem': 'INFRASTRUCTURE',
      'impact': 'PSW clock-ins disabled systemwide',
      'age': '14m elapsed',
      'priority': 'Critical (P0)',
      'status': 'Acknowledged',
    },
    {
      'id': 'ESC-103',
      'title': 'SLA Breach: Franchise Payment Webhooks Locked',
      'subsystem': 'BILLING',
      'impact': 'Transactions fail to reconcile',
      'age': '1h 22m elapsed',
      'priority': 'High (P1)',
      'status': 'Investigating',
    },
    {
      'id': 'ESC-104',
      'title': 'SLA Threat: RN Intake Referrals lag > 4h',
      'subsystem': 'CLINICAL',
      'impact': 'Intake coordinator screen timing out',
      'age': '3h 5m elapsed',
      'priority': 'High (P1)',
      'status': 'Queued',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFDC2626); // Crimson Red
    const cardBgColor = Color(0xFF1E293B); // Slate Blue
    const textLightColor = Colors.white;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A), // Dark Midnight
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(LucideIcons.alertTriangle, color: primaryColor, size: 28),
              SizedBox(width: 12),
              Text(
                'PrimeCare Escalation Control Center',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1E293B),
          elevation: 4,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Escalated Incidents & Outages',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: textLightColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'System SLA exceptions, critical resource failures, and incident responses.',
                            style: TextStyle(fontSize: 15, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                      // Emergency Active Banner
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          border: Border.all(color: primaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'P0 CRISIS STATUS ACTIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
    
                  // KPI Metric row
                  Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          label: 'SLA Breaches',
                          value: '2 Breached',
                          subtext: '4 near breach',
                          icon: LucideIcons.timer,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          label: 'Active Escalations',
                          value: '7 Tickets',
                          subtext: 'Assigned to DevOps',
                          icon: LucideIcons.shieldAlert,
                          color: Colors.orange.shade500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          label: 'P0 Incidents',
                          value: '1 Outage',
                          subtext: 'AWS Replica Node #4',
                          icon: LucideIcons.server,
                          color: Colors.red.shade500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          label: 'Avg Resolution Time',
                          value: '14 mins',
                          subtext: 'SLA Target < 30m',
                          icon: LucideIcons.activity,
                          color: Colors.green.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
    
                  // Layout splits
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Incident feed
                      Expanded(
                        flex: 2,
                        child: Card(
                          color: cardBgColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Urgent Escalation Feed',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildEscalationFeedList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
    
                      // Actions & Statistics
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // Categories
                            Card(
                              color: cardBgColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Incidents by System',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildSystemStatBar(label: 'Auth & Geolocation Fails', value: 0.65, count: 4, color: primaryColor),
                                    const SizedBox(height: 12),
                                    _buildSystemStatBar(label: 'Franchise Billing & Webhooks', value: 0.25, count: 2, color: Colors.orange),
                                    const SizedBox(height: 12),
                                    _buildSystemStatBar(label: 'Clinical App DB Lag', value: 0.10, count: 1, color: Colors.blue),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
    
                            // Disaster Actions
                            Card(
                              color: cardBgColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Emergency Protocols',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildDisasterButton(
                                      label: 'Initiate P0 Incident Protocol',
                                      icon: LucideIcons.flame,
                                      color: primaryColor,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Crisis control room conference link created.')),
                                        );
                                      },
                                    ),
                                    _buildDisasterButton(
                                      label: 'Trigger PagerDuty / On-Call',
                                      icon: LucideIcons.radio,
                                      color: Colors.amber.shade700,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('On-call Devops Engineers paged.')),
                                        );
                                      },
                                    ),
                                     _buildDisasterButton(
                                       label: 'Notify COO & Exec Leadership',
                                       icon: LucideIcons.megaphone,
                                       color: const Color(0xFF475569),
                                       onPressed: () {
                                         ScaffoldMessenger.of(context).showSnackBar(
                                           const SnackBar(content: Text('COO notified via private enterprise SMS.')),
                                         );
                                       },
                                     ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard({
    required String label,
    required String value,
    required String subtext,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      color: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtext,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEscalationFeedList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _escalations.length,
      itemBuilder: (context, index) {
        final esc = _escalations[index];
        final badgeColor = esc['priority'].contains('Critical') ? Color(0xFFDC2626) : Colors.orange.shade500;
        final statusColor = esc['status'] == 'Acknowledged' ? Colors.green.shade500 : Colors.amber.shade500;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF334155).withOpacity(0.4),
            border: Border.all(color: Colors.white10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.15),
                          border: Border.all(color: badgeColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          esc['priority'],
                          style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        esc['id'],
                        style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(LucideIcons.clock, color: Color(0xFF64748B), size: 14),
                      const SizedBox(width: 4),
                      Text(esc['age'], style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                esc['title'],
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Impact: ${esc['impact']}',
                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Subsystem: ',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                      Text(
                        esc['subsystem'],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Status: ',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                      Text(
                        esc['status'],
                        style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Acknowledged escalation ${esc['id']}.')),
                          );
                        },
                        icon: const Icon(LucideIcons.checkSquare, size: 14, color: Colors.greenAccent),
                        label: const Text('Acknowledge', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Incident ${esc['id']} escalated to DevOps lead.')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Escalate', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSystemStatBar({
    required String label,
    required double value,
    required int count,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
            Text('$count Incidents', style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white10,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildDisasterButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}