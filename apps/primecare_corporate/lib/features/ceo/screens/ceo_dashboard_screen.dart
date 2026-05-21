import 'package:flutter/material.dart';

class CeoDashboardScreen extends StatefulWidget {
  const CeoDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CeoDashboardScreen> createState() => _CeoDashboardScreenState();
}

class _CeoDashboardScreenState extends State<CeoDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Enterprise Global Overview (CEO)'), backgroundColor: Colors.black87),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PrimeCare Global Performance', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: _buildKpiCard('Gross Revenue (YTD)', '\$14.2M', Icons.monetization_on, Colors.green)),
                  const SizedBox(width: 24),
                  Expanded(child: _buildKpiCard('Active Franchises', '42', Icons.business, Colors.blue)),
                  const SizedBox(width: 24),
                  Expanded(child: _buildKpiCard('Total Patients Served', '128,492', Icons.people, Colors.purple)),
                ],
              ),
              const SizedBox(height: 48),
              const Text('Strategic Expansion Pipeline', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildPipelineItem('Vancouver Clinic Acquisition', 0.8, Colors.blue),
                      const SizedBox(height: 16),
                      _buildPipelineItem('New York Enterprise Launch', 0.4, Colors.orange),
                      const SizedBox(height: 16),
                      _buildPipelineItem('Telehealth Beta Program', 0.95, Colors.green),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ),
      ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(icon, size: 64, color: color),
            const SizedBox(height: 24),
            Text(value, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineItem(String label, double progress, Color color) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(value: progress, minHeight: 12, backgroundColor: Colors.grey.shade200, color: color),
        ),
        const SizedBox(width: 16),
        Text("\${(progress * 100).toInt()}%", style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
