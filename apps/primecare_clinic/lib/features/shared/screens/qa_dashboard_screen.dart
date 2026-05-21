import 'package:flutter/material.dart';

class QualityAssuranceDashboardScreen extends StatefulWidget {
  const QualityAssuranceDashboardScreen({Key? key}) : super(key: key);

  @override
  State<QualityAssuranceDashboardScreen> createState() => _QualityAssuranceDashboardScreenState();
}

class _QualityAssuranceDashboardScreenState extends State<QualityAssuranceDashboardScreen> {
  final List<Map<String, dynamic>> _audits = [
    {'title': 'Nursing Chart Review - May 2026', 'score': 98.5},
    {'title': 'Hand Hygiene Compliance Audit', 'score': 94.2},
    {'title': 'Medication Error Reporting Log', 'score': 100.0},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Quality Assurance & Audits'), backgroundColor: Colors.amber.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text('Compliance Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildScoreCard('Overall Clinic Health', '97.6%', Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildScoreCard('Active Investigations', '0', Colors.blue)),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Recent Audits', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._audits.map((a) => Card(
              child: ListTile(
                leading: const Icon(Icons.fact_check, color: Colors.amber),
                title: Text(a['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Chip(
                  label: Text("\${a['score']}%"),
                  backgroundColor: a['score'] > 95 ? Colors.green.shade100 : Colors.orange.shade100,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening detailed report for \${a['title']}")));
                },
              ),
            )).toList(),
          ],
        ),
        ),
      ),
      ),
    );
  }

  Widget _buildScoreCard(String title, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}