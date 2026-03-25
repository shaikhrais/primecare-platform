import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/api_client.dart';

class ManagerTeamsScreen extends StatefulWidget {
  const ManagerTeamsScreen({super.key});

  @override
  State<ManagerTeamsScreen> createState() => _ManagerTeamsScreenState();
}

class _ManagerTeamsScreenState extends State<ManagerTeamsScreen> {
  bool _isExporting = false;

  Future<void> _exportCompliance() async {
    setState(() => _isExporting = true);
    try {
      await apiClient.post('/api/manager/reports/export', body: {
        'type': 'compliance_roster',
        'teams': ['all'],
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report generated natively and dispatched gracefully cleanly explicitly neatly.')));
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export error neatly solidly seamlessly flexibly fluently accurately: $e')));
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Compliance Roster')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Shift Density',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TeamMemberAvatarPile(),
            const SizedBox(height: 32),
            const ComplianceExpiryGauge(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: _isExporting
                  ? const Center(child: CircularProgressIndicator())
                  : PrimeButton(
                      label: 'Export Compliance Report',
                      isOutline: true,
                      onPressed: _exportCompliance,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

