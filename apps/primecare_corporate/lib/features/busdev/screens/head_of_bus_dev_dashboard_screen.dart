import 'package:flutter/material.dart';

class HeadOfBusDevDashboardScreen extends StatefulWidget {
  const HeadOfBusDevDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HeadOfBusDevDashboardScreen> createState() => _HeadOfBusDevDashboardScreenState();
}

class _HeadOfBusDevDashboardScreenState extends State<HeadOfBusDevDashboardScreen> {
  final List<Map<String, dynamic>> _pipeline = [
    {'deal': 'MedClinic Group Acquisition', 'stage': 'Due Diligence', 'value': '\$2.4M', 'prob': 0.8},
    {'deal': 'Toronto West Franchise', 'stage': 'Contract Sent', 'value': '\$450K', 'prob': 0.95},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Business Development'), backgroundColor: Colors.amber.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('Franchise & M&A Pipeline', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('Total Pipeline Value', '\$8.5M', Colors.green)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Active Deals', '14', Colors.blue)),
              ],
            ),
            const SizedBox(height: 48),
            const Text('Active Opportunities', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._pipeline.map((deal) => Card(
              child: ListTile(
                leading: Icon(Icons.handshake, color: Colors.amber, size: 40),
                title: Text(deal['deal'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Stage: ${deal['stage']} | Value: ${deal['value']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${(deal['prob'] * 100).toInt()}% Close Prob.", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => deal['stage'] = 'Closed Won');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deal ${deal['deal']} marked as Closed!")));
                      },
                      child: const Text('Advance Stage'),
                    )
                  ],
                ),
              ),
            )).toList()
          ],
        ),
        ),
      ),
      ),
    );
  }

  Widget _buildMetric(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
