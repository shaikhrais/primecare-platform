import 'package:flutter/material.dart';

class ClientFamilyPortalScreen extends StatelessWidget {
  const ClientFamilyPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Care Portal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFamilyMembersCard(),
          const SizedBox(height: 16),
          _buildSharedUpdatesCard(),
          const SizedBox(height: 16),
          _buildCommunicationCard(),
        ],
      ),
    );
  }

  Widget _buildFamilyMembersCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Authorized Family Members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListTile(
              leading: CircleAvatar(child: Text('JS')),
              title: Text('John Smith'),
              subtitle: Text('Primary Contact (Son)'),
              trailing: Icon(Icons.edit, size: 20),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('MS')),
              title: Text('Mary Smith'),
              subtitle: Text('Secondary Contact (Daughter)'),
              trailing: Icon(Icons.edit, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharedUpdatesCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Care Updates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildUpdateItem('RN Visit Completed', 'Today, 10:30 AM', 'Vital signs normal. Patient is resting comfortably.'),
            const Divider(),
            _buildUpdateItem('Medication Refilled', 'Yesterday, 3:00 PM', 'Prescription refilled by Dr. Adams.'),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String title, String time, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildCommunicationCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Care Team Communication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message),
              label: const Text('Message Care Coordinator'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 44)),
            ),
          ],
        ),
      ),
    );
  }
}
