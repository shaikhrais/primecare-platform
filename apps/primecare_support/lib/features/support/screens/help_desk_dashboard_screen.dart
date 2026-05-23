// Governance - Category: view | Purpose: UI Screen component rendering the Help Desk Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HelpDeskDashboardScreen extends StatefulWidget {
  const HelpDeskDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HelpDeskDashboardScreen> createState() => _HelpDeskDashboardScreenState();
}

class _HelpDeskDashboardScreenState extends State<HelpDeskDashboardScreen> {
  String _selectedPriorityFilter = 'All';
  final List<Map<String, dynamic>> _tickets = [
    {
      'id': 'TKT-9201',
      'client': 'Aria Smith (Franchise #104)',
      'issue': 'Billing sync failure after checkout',
      'priority': 'High',
      'status': 'In Progress',
      'assignedTo': 'John Doe',
      'elapsed': '12m ago',
    },
    {
      'id': 'TKT-9202',
      'client': 'Robert Chen (Patient Portal)',
      'issue': 'Password reset verification email not received',
      'priority': 'Medium',
      'status': 'Open',
      'assignedTo': 'Sarah Jenkins',
      'elapsed': '24m ago',
    },
    {
      'id': 'TKT-9203',
      'client': 'Janet Taylor (Physician App)',
      'issue': 'Prescription signature screen lagging on tablet',
      'priority': 'High',
      'status': 'In Progress',
      'assignedTo': 'David Smith',
      'elapsed': '8m ago',
    },
    {
      'id': 'TKT-9204',
      'client': 'System Watchdog',
      'issue': 'API Gateway replica latency above 500ms',
      'priority': 'High',
      'status': 'Open',
      'assignedTo': 'Unassigned',
      'elapsed': '1m ago',
    },
    {
      'id': 'TKT-9205',
      'client': 'William Vance (PSW App)',
      'issue': 'Clock-in geolocation mismatch error',
      'priority': 'Low',
      'status': 'Resolved',
      'assignedTo': 'Jane Miller',
      'elapsed': '1h ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Theme palette
    const primaryColor = Color(0xFFEA580C); // Deep Orange
    const cardBgColor = Color(0xFF1E293B); // Sleek slate color
    const textColor = Colors.white;

    final filteredTickets = _selectedPriorityFilter == 'All'
        ? _tickets
        : _tickets.where((t) => t['priority'] == _selectedPriorityFilter).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A), // Premium Dark Midnight Blue
        appBar: AppBar(
          title: Row(
            children: const [
              Icon(LucideIcons.helpCircle, color: primaryColor, size: 28),
              SizedBox(width: 12),
              Text(
                'PrimeCare Help Desk Portal',
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
                  // Header text
                  const Text(
                    'Help Desk Overview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Monitor active customer success metrics, open ticket queues, and SLA alerts.',
                    style: TextStyle(fontSize: 15, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 24),
    
                  // Metrics Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Open Tickets',
                          value: '42 Tickets',
                          change: '5 unresolved',
                          icon: LucideIcons.ticket,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Response SLA',
                          value: '98.4%',
                          change: '+0.8% today',
                          icon: LucideIcons.clock,
                          color: Colors.green.shade500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          title: 'CSAT Score',
                          value: '94.8%',
                          change: 'Target 92%',
                          icon: LucideIcons.smile,
                          color: Colors.blue.shade500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Agents Online',
                          value: '12 Active',
                          change: '3 on break',
                          icon: LucideIcons.users,
                          color: Colors.purple.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
    
                  // Main Section: Queue & Quick Actions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Queue list
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Live Support Ticket Queue',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    _buildPriorityFilterDropdown(),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildTicketQueueTable(filteredTickets),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
    
                      // SLA Fulfillment and Quick Actions
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // SLA breakdown
                            Card(
                              color: cardBgColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SLA Fulfillment Speed',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildProgressBar(label: 'Immediate / Urgent (<15m)', value: 0.92, color: Colors.red),
                                    const SizedBox(height: 12),
                                    _buildProgressBar(label: 'Standard Priority (<2h)', value: 0.97, color: Colors.orange),
                                    const SizedBox(height: 12),
                                    _buildProgressBar(label: 'Low Priority (<24h)', value: 1.0, color: Colors.green),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
    
                            // Quick Actions
                            Card(
                              color: cardBgColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Quick Support Actions',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildQuickActionButton(
                                      label: 'Create Support Ticket',
                                      icon: LucideIcons.plusCircle,
                                      color: primaryColor,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Support ticket builder opened successfully.')),
                                        );
                                      },
                                    ),
                                    _buildQuickActionButton(
                                      label: 'Assign Agent Queue',
                                      icon: LucideIcons.userCheck,
                                      color: const Color(0xFF475569),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Auto-assign algorithm initiated.')),
                                        );
                                      },
                                    ),
                                    _buildQuickActionButton(
                                      label: 'Download SLA Report',
                                      icon: LucideIcons.download,
                                      color: const Color(0xFF475569),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('SLA PDF report generated.')),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String change,
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
                Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
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
                  change,
                  style: TextStyle(
                    color: change.contains('+') || change.contains('Target') ? Colors.green : Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPriorityFilter,
          dropdownColor: const Color(0xFF334155),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          icon: const Icon(LucideIcons.chevronDown, color: Colors.white70, size: 16),
          items: <String>['All', 'High', 'Medium', 'Low'].map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text('Priority: $val'),
            );
          }).toList(),
          onChanged: (String? newVal) {
            if (newVal != null) {
              setState(() {
                _selectedPriorityFilter = newVal;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildTicketQueueTable(List<Map<String, dynamic>> tickets) {
    if (tickets.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: const Text('No tickets match this filter.', style: TextStyle(color: Colors.white54)),
      );
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(2.0),
        2: FlexColumnWidth(0.8),
        3: FlexColumnWidth(1.0),
        4: FlexColumnWidth(1.0),
      },
      children: [
        // Table Header
        TableRow(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white12, width: 1.5)),
          ),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Ticket ID',
                style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Client / Issue',
                style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Priority',
                style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Status',
                style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Action',
                style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Table Rows
        ...tickets.map((t) {
          final priorityColor = t['priority'] == 'High'
              ? Colors.red.shade400
              : (t['priority'] == 'Medium' ? Colors.orange.shade400 : Colors.green.shade400);

          final statusColor = t['status'] == 'Resolved'
              ? Colors.green.shade500
              : (t['status'] == 'Open' ? Colors.red.shade500 : Colors.blue.shade500);

          return TableRow(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10, width: 1.0)),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(t['id'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['client'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      t['issue'],
                      style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    t['priority'],
                    style: TextStyle(color: priorityColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: statusColor),
                    const SizedBox(width: 6),
                    Text(
                      t['status'],
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewing ticket ${t['id']} details...')),
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Inspect',
                        style: TextStyle(color: Colors.cyanAccent, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 4),
                      Icon(LucideIcons.chevronRight, color: Colors.cyanAccent, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildProgressBar({
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
            Text('${(value * 100).toInt()}%', style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
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

  Widget _buildQuickActionButton({
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