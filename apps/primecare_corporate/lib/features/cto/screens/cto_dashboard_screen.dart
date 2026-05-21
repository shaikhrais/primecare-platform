import 'package:flutter/material.dart';

class CtoDashboardScreen extends StatefulWidget {
  const CtoDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CtoDashboardScreen> createState() => _CtoDashboardScreenState();
}

class _CtoDashboardScreenState extends State<CtoDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Platform Health (CTO)'), backgroundColor: Colors.blueGrey.shade900),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('PrimeCare Infrastructure Metrics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetric('API Latency (p99)', '42ms', Colors.green)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Active Sessions', '8,492', Colors.blue)),
                const SizedBox(width: 24),
                Expanded(child: _buildMetric('Error Rate', '0.01%', Colors.green)),
              ],
            ),
            const SizedBox(height: 48),
            const Text('Latest Cloud Deployments', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.cloud_done, color: Colors.green),
                title: Text('v2.4.1 - PrimeCare Clinic Patch'),
                subtitle: Text('Deployed automatically via Cloudflare Pages.'),
                trailing: Text('Success', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ),
            )
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
      decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade900)),
        ],
      ),
    );
  }
}
