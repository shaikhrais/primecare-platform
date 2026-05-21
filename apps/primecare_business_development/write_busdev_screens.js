const fs = require('fs');

const franchise = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FranchiseSalesManagerDashboardScreen extends StatefulWidget {
  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  State<FranchiseSalesManagerDashboardScreen> createState() => _FranchiseSalesManagerDashboardScreenState();
}

class _FranchiseSalesManagerDashboardScreenState extends State<FranchiseSalesManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Franchise Sales Manager Dashboard'), backgroundColor: const Color(0xFF0F172A), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _StatCard('Active Deals', '24', LucideIcons.briefcase, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Discovery Calls', '12', LucideIcons.phone, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Signed Contracts', '4', LucideIcons.fileSignature, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Commission Proj.', r'$18,500', LucideIcons.dollarSign, Colors.purple)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Deal Stage Funnel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _FunnelRow('Prospects', 120, 1.0, Colors.grey),
                    _FunnelRow('Qualified Leads', 45, 0.6, Colors.blue),
                    _FunnelRow('Proposals Sent', 18, 0.3, Colors.orange),
                    _FunnelRow('Negotiation', 8, 0.15, Colors.purple),
                    _FunnelRow('Closed Won', 4, 0.05, Colors.green),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FunnelRow extends StatelessWidget {
  final String label;
  final int count;
  final double fraction;
  final Color color;

  const _FunnelRow(this.label, this.count, this.fraction, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                height: 32,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8),
                child: Text(count.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
`;

const partnership = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PartnershipManagerDashboardScreen extends StatefulWidget {
  const PartnershipManagerDashboardScreen({super.key});

  @override
  State<PartnershipManagerDashboardScreen> createState() => _PartnershipManagerDashboardScreenState();
}

class _PartnershipManagerDashboardScreenState extends State<PartnershipManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partnership Manager Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _StatCard('Active B2B Deals', '15', LucideIcons.building, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Renewal Rate', '94%', LucideIcons.refreshCcw, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Recent Outreach', '42', LucideIcons.mail, Colors.orange)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('High Priority Renewals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Partner')),
                  DataColumn(label: Text('Contract Value')),
                  DataColumn(label: Text('Expiry')),
                  DataColumn(label: Text('Status')),
                ],
                rows: [
                  DataRow(cells: [DataCell(Text('Sunrise Senior Care')), DataCell(Text(r'$140,000/yr')), DataCell(Text('Nov 15, 2023')), DataCell(Chip(label: Text('At Risk'), backgroundColor: Colors.red.shade100))]),
                  DataRow(cells: [DataCell(Text('Toronto General Hospital')), DataCell(Text(r'$250,000/yr')), DataCell(Text('Dec 01, 2023')), DataCell(Chip(label: Text('Negotiating'), backgroundColor: Colors.orange.shade100))]),
                  DataRow(cells: [DataCell(Text('Evergreen Pharmacies')), DataCell(Text(r'$80,000/yr')), DataCell(Text('Dec 15, 2023')), DataCell(Chip(label: Text('Committed'), backgroundColor: Colors.green.shade100))]),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
`;

const regionalBdm = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegionalBdmDashboardScreen extends StatefulWidget {
  const RegionalBdmDashboardScreen({super.key});

  @override
  State<RegionalBdmDashboardScreen> createState() => _RegionalBdmDashboardScreenState();
}

class _RegionalBdmDashboardScreenState extends State<RegionalBdmDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regional BDM Dashboard'), backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _StatCard('Market Share', '14%', LucideIcons.pieChart, Colors.purple)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Active Territories', '8', LucideIcons.map, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Pipeline Value', r'$1.2M', LucideIcons.trendingUp, Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Territory Growth', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _TerritoryRow('Greater Toronto Area', 0.8),
                    _TerritoryRow('Vancouver Metro', 0.6),
                    _TerritoryRow('Calgary Region', 0.4),
                    _TerritoryRow('Halifax Regional', 0.2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TerritoryRow extends StatelessWidget {
  final String name;
  final double growth;

  const _TerritoryRow(this.name, this.growth);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: LinearProgressIndicator(value: growth, backgroundColor: Colors.grey.shade200, minHeight: 8, color: Colors.indigo)),
          const SizedBox(width: 16),
          Text('\${(growth * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
`;

const expansion = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TerritoryExpansionManagerDashboardScreen extends StatefulWidget {
  const TerritoryExpansionManagerDashboardScreen({super.key});

  @override
  State<TerritoryExpansionManagerDashboardScreen> createState() => _TerritoryExpansionManagerDashboardScreenState();
}

class _TerritoryExpansionManagerDashboardScreenState extends State<TerritoryExpansionManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Territory Expansion Dashboard'), backgroundColor: const Color(0xFFC026D3), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _StatCard('Open Territories', '45', LucideIcons.mapPin, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('Site Selections', '12', LucideIcons.building2, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard('12-mo Forecast', '+8 Nodes', LucideIcons.calendar, Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Demographics Heatmap', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.map, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Interactive Territory Map (Placeholder)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/sales/screens/franchise_sales_manager_dashboard_screen.dart', franchise);
fs.writeFileSync('lib/features/partnership/screens/partnership_manager_dashboard_screen.dart', partnership);
fs.writeFileSync('lib/features/bdm/screens/regional_bdm_dashboard_screen.dart', regionalBdm);
fs.writeFileSync('lib/features/expansion/screens/territory_expansion_manager_dashboard_screen.dart', expansion);

// Wire into app_router.dart
let router = fs.readFileSync('lib/core/routing/app_router.dart', 'utf8');

const routes = "      GoRoute(path: '/busdev/sales', builder: (context, state) => const FranchiseSalesManagerDashboardScreen()),\\n      GoRoute(path: '/busdev/partnership', builder: (context, state) => const PartnershipManagerDashboardScreen()),\\n      GoRoute(path: '/busdev/bdm', builder: (context, state) => const RegionalBdmDashboardScreen()),\\n      GoRoute(path: '/busdev/expansion', builder: (context, state) => const TerritoryExpansionManagerDashboardScreen()),";

if (!router.includes('/busdev/sales')) {
  router = router.replace("publicRoutes: [", "publicRoutes: [\\n" + routes);
}

fs.writeFileSync('lib/core/routing/app_router.dart', router);
