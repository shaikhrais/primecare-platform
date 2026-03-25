import 'package:flutter/material.dart';

class ClientPatientHubScreen extends StatelessWidget {
  const ClientPatientHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Hub'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHealthSummaryCard(),
          const SizedBox(height: 16),
          _buildUpcomingCareCard(),
          const SizedBox(height: 16),
          _buildRecentVitalsCard(),
        ],
      ),
    );
  }

  Widget _buildHealthSummaryCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Health Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusIndicator('Stable', Colors.green),
                const Text('Last Assessment: Today, 9:00 AM'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildUpcomingCareCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Upcoming Care Visits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.medical_services, color: Colors.blue),
              title: Text('RN Assessment'),
              subtitle: Text('Tomorrow, 10:00 AM - 11:00 AM'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.healing, color: Colors.blue),
              title: Text('Wound Care'),
              subtitle: Text('Wednesday, 2:00 PM - 3:00 PM'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentVitalsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Recent Vitals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Blood Pressure'),
              subtitle: Text('120/80 mmHg'),
              trailing: Text('Normal', style: TextStyle(color: Colors.green)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.thermostat, color: Colors.orange),
              title: Text('Temperature'),
              subtitle: Text('98.6 °F'),
              trailing: Text('Normal', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
