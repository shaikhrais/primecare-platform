const fs = require('fs');

const leadsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerLeadsScreen extends StatefulWidget {
  const FranchiseSalesManagerLeadsScreen({super.key});

  @override
  State<FranchiseSalesManagerLeadsScreen> createState() => _FranchiseSalesManagerLeadsScreenState();
}

class _FranchiseSalesManagerLeadsScreenState extends State<FranchiseSalesManagerLeadsScreen> {
  final List<Map<String, dynamic>> _leads = [
    {'name': 'Marcus Vance', 'city': 'Austin, TX', 'budget': r'$150,000', 'source': 'Organic Search', 'status': 'New', 'color': Colors.blue},
    {'name': 'Sarah Jenkins', 'city': 'Denver, CO', 'budget': r'$300,000', 'source': 'Broker Referral', 'status': 'Contacted', 'color': Colors.orange},
    {'name': 'Robert Chen', 'city': 'Seattle, WA', 'budget': r'$250,000', 'source': 'LinkedIn Outbound', 'status': 'Qualified', 'color': Colors.green},
    {'name': 'Emma Watson', 'city': 'Orlando, FL', 'budget': r'$180,000', 'source': 'Franchise Expo', 'status': 'New', 'color': Colors.blue},
    {'name': 'David Miller', 'city': 'Chicago, IL', 'budget': r'$500,000', 'source': 'Direct Inquiry', 'status': 'Nurturing', 'color': Colors.purple},
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredLeads = _leads.where((lead) {
      return lead['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          lead['city'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Franchise Leads CRM'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search leads by name or region...',
                prefixIcon: const Icon(LucideIcons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\${filteredLeads.length} Active Leads', style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.filter, size: 16),
                  label: const Text('Filters'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredLeads.length,
              itemBuilder: (context, index) {
                final lead = filteredLeads[index];
                return Card(
                  margin: const EdgeInsets.bottom(12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: (lead['color'] as Color).withOpacity(0.1),
                      child: Icon(LucideIcons.user, color: lead['color'] as Color),
                    ),
                    title: Text(lead['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(LucideIcons.mapPin, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(lead['city'] as String, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(LucideIcons.dollarSign, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('Budget: \${lead['budget']}', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (lead['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            lead['status'] as String,
                            style: TextStyle(color: lead['color'] as Color, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(lead['source'] as String, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        child: const Icon(LucideIcons.plus),
      ),
    );
  }
}
`;

const prospectsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerProspectsScreen extends StatelessWidget {
  const FranchiseSalesManagerProspectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> prospects = [
      {'name': 'Summit Group LLC', 'score': 92, 'capital': r'$1.5M', 'interest': 'Multi-unit (3)', 'status': 'Hot', 'color': Colors.red},
      {'name': 'Dr. Amanda Reyes', 'score': 85, 'capital': r'$450k', 'interest': 'Single-unit', 'status': 'Hot', 'color': Colors.red},
      {'name': 'Arthur Pendelton', 'score': 74, 'capital': r'$600k', 'interest': 'Single-unit', 'status': 'Warm', 'color': Colors.orange},
      {'name': 'Vanguard Care Inc.', 'score': 68, 'capital': r'$2.2M', 'interest': 'Area Developer', 'status': 'Warm', 'color': Colors.orange},
      {'name': 'Jessica Sterling', 'score': 45, 'capital': r'$350k', 'interest': 'Single-unit', 'status': 'Cold', 'color': Colors.blue},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qualified Prospects'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prospect Lead Scoring & Assets',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Prospects are auto-scored based on net worth, background checks, and intent markers.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: prospects.length,
              itemBuilder: (context, index) {
                final prospect = prospects[index];
                return Card(
                  margin: const EdgeInsets.bottom(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prospect['name'] as String,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (prospect['color'] as Color).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Score: \${prospect['score']}',
                                style: TextStyle(
                                  color: prospect['color'] as Color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Liquid Capital', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  const SizedBox(height: 2),
                                  Text(prospect['capital'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Intent Area', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  const SizedBox(height: 2),
                                  Text(prospect['interest'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Priority Tag', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  const SizedBox(height: 2),
                                  Text(prospect['status'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: prospect['color'] as Color)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(LucideIcons.fileText, size: 14),
                              label: const Text('Send Package'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(LucideIcons.calendar, size: 14),
                              label: const Text('Book Audit'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
`;

const discoveryCallsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerDiscoveryCallsScreen extends StatelessWidget {
  const FranchiseSalesManagerDiscoveryCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> calls = [
      {'name': 'Marcus Vance', 'time': '10:00 AM - 10:30 AM', 'date': 'Today', 'topic': 'Franchise Fee Structure', 'status': 'Confirmed'},
      {'name': 'Sarah Jenkins', 'time': '2:00 PM - 2:45 PM', 'date': 'Today', 'topic': 'Territory Availability: Denver', 'status': 'Pending Confirmation'},
      {'name': 'Arthur Pendelton', 'time': '11:00 AM - 11:30 AM', 'date': 'Tomorrow', 'topic': 'Clinical Quality Standards', 'status': 'Confirmed'},
      {'name': 'Vanguard Care Inc.', 'time': '4:00 PM - 5:00 PM', 'date': 'Tomorrow', 'topic': 'Area Development Proposal', 'status': 'Confirmed'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery Calls Calendar'),
        backgroundColor: const Color(0xFFD97706),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Discovery Runs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.calendar),
                  color: const Color(0xFFD97706),
                )
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: calls.length,
              itemBuilder: (context, index) {
                final call = calls[index];
                final isConfirmed = call['status'] == 'Confirmed';
                return Card(
                  margin: const EdgeInsets.bottom(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD97706).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.phoneCall, color: Color(0xFFD97706)),
                    ),
                    title: Text(
                      call['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(LucideIcons.calendarDays, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('\${call['date']} | \${call['time']}', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(LucideIcons.info, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(call['topic']!, style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        call['status']!,
                        style: TextStyle(
                          color: isConfirmed ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: isConfirmed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
`;

const proposalsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerProposalsScreen extends StatelessWidget {
  const FranchiseSalesManagerProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> proposals = [
      {'partner': 'Summit Group LLC', 'fee': r'$45,000', 'status': 'Under Review', 'date': 'May 14, 2026', 'color': Colors.orange},
      {'partner': 'Dr. Amanda Reyes', 'fee': r'$45,000', 'status': 'Approved', 'date': 'May 10, 2026', 'color': Colors.green},
      {'partner': 'Arthur Pendelton', 'fee': r'$45,000', 'status': 'Draft', 'date': 'May 20, 2026', 'color': Colors.grey},
      {'partner': 'Vanguard Care Inc.', 'fee': r'$120,000', 'status': 'Negotiating', 'date': 'May 08, 2026', 'color': Colors.purple},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Franchise Proposals Tracker'),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Deal Outlines & Estimates',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: proposals.length,
              itemBuilder: (context, index) {
                final prop = proposals[index];
                return Card(
                  margin: const EdgeInsets.bottom(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prop['partner'] as String,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (prop['color'] as Color).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                prop['status'] as String,
                                style: TextStyle(color: prop['color'] as Color, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Franchise Fee: \${prop['fee']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Created: \${prop['date']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(LucideIcons.edit, size: 14),
                              label: const Text('Modify Terms'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(LucideIcons.send, size: 14),
                              label: const Text('Resend API'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
`;

const salesPipelineScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerSalesPipelineScreen extends StatelessWidget {
  const FranchiseSalesManagerSalesPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deal Stage Pipeline'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sales Stage Funnel Velocity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Average days spent per sales cohort and deal flow conversion targets.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _PipelineCard('1. Discovery / Qualification', '12 Active deals', 0.85, Colors.blue, 'Avg. 8 days'),
            _PipelineCard('2. Proposal Customization', '8 Active deals', 0.60, Colors.purple, 'Avg. 14 days'),
            _PipelineCard('3. Legal / Franchise Disclosure', '4 Active deals', 0.40, Colors.orange, 'Avg. 21 days'),
            _PipelineCard('4. Financial Review / Audit', '3 Active deals', 0.25, Colors.pink, 'Avg. 6 days'),
            _PipelineCard('5. Final Board Approval', '2 Active deals', 0.10, Colors.green, 'Avg. 3 days'),
          ],
        ),
      ),
    );
  }

  Widget _PipelineCard(String stage, String active, double progress, Color color, String speed) {
    return Card(
      margin: const EdgeInsets.bottom(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(speed, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(active, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: Colors.grey.shade200,
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}
`;

const contractsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerContractsScreen extends StatelessWidget {
  const FranchiseSalesManagerContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contracts = [
      {'partner': 'Summit Group LLC', 'fee': r'$45,000', 'royalty': '5%', 'date': 'May 12, 2026', 'rep': 'Marcus Vance'},
      {'partner': 'Dr. Amanda Reyes', 'fee': r'$45,000', 'royalty': '4.5%', 'date': 'May 08, 2026', 'rep': 'Sarah Jenkins'},
      {'partner': 'Calgary Senior Care', 'fee': r'$45,000', 'royalty': '5%', 'date': 'Apr 24, 2026', 'rep': 'Self'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signed Agreements & Royalties'),
        backgroundColor: const Color(0xFF047857),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: _MiniCard('Signed (YTD)', '12', Colors.green),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _MiniCard('Commission Due', r'$8,400', Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Executed Franchise Contracts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final contract = contracts[index];
                return Card(
                  margin: const EdgeInsets.bottom(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contract['partner']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Icon(LucideIcons.checkCircle2, color: Colors.green),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Franchise Fee', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                Text(contract['fee']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Royalty Share', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                Text(contract['royalty']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('E-Signature Date', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                Text(contract['date']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _MiniCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
`;

const followUpsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerFollowUpsScreen extends StatelessWidget {
  const FranchiseSalesManagerFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> followups = [
      {'name': 'Marcus Vance', 'task': 'Nudge for Franchise Disclosure Document', 'due': 'Today'},
      {'name': 'Sarah Jenkins', 'task': 'Confirm location survey for Denver branch', 'due': 'Today'},
      {'name': 'Robert Chen', 'task': 'Request business plan from broker referral', 'due': 'Tomorrow'},
      {'name': 'Evergreen Pharmacies', 'task': 'Send updated royalty draft', 'due': 'In 3 days'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Ups & Reminders'),
        backgroundColor: const Color(0xFF6B7280),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Automated Outreach Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: followups.length,
              itemBuilder: (context, index) {
                final task = followups[index];
                return Card(
                  margin: const EdgeInsets.bottom(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Checkbox(
                      value: false,
                      onChanged: (val) {},
                    ),
                    title: Text(
                      task['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(task['task']!),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task['due']!,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
`;

const reportsScreenContent = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerReportsScreen extends StatelessWidget {
  const FranchiseSalesManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executive Growth Metrics'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sales Channel Analytics & Target YTD',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _MetricRow('Total Signed Units', '12 / 20 Target', 0.60, Colors.green),
                    const SizedBox(height: 16),
                    _MetricRow('Organic Conversion Rate', '8.4%', 0.84, Colors.blue),
                    const SizedBox(height: 16),
                    _MetricRow('Broker Payout Allocation', r'$45k / $100k cap', 0.45, Colors.purple),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sales Channel Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _BarChartRow('Broker Referrals', '42%', Colors.blue, 0.42),
                    _BarChartRow('Direct Website Inquiry', '35%', Colors.green, 0.35),
                    _BarChartRow('LinkedIn Outbound', '15%', Colors.purple, 0.15),
                    _BarChartRow('Events / Expo', '8%', Colors.orange, 0.08),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _MetricRow(String label, String value, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: Colors.grey.shade100,
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _BarChartRow(String label, String value, Color color, double fraction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: fraction,
              color: color,
              backgroundColor: Colors.grey.shade100,
              minHeight: 12,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(width: 40, child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_leads_screen.dart', leadsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_prospects_screen.dart', prospectsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_discovery_calls_screen.dart', discoveryCallsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_proposals_screen.dart', proposalsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_sales_pipeline_screen.dart', salesPipelineScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_contracts_screen.dart', contractsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_follow_ups_screen.dart', followUpsScreenContent);
fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_reports_screen.dart', reportsScreenContent);

console.log('Successfully wrote high-fidelity Franchise Sales Manager screens!');
