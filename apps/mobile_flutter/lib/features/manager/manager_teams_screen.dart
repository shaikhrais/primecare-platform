import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide TeamMemberAvatarPile;
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/core/widgets/operational/team_member_avatar_pile.dart';

class ManagerTeamsScreen extends StatefulWidget {
  const ManagerTeamsScreen({super.key});

  @override
  State<ManagerTeamsScreen> createState() => _ManagerTeamsScreenState();
}

class _ManagerTeamsScreenState extends State<ManagerTeamsScreen> {
  bool _isExporting = false;
  bool _isLoading = true;
  List<dynamic> _teamMembers = [];
  Map<String, dynamic> _complianceMetrics = {};
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchTeams();
  }

  Future<void> _fetchTeams() async {
    try {
      final res = await apiClient.get('/v1/manager/teams');
      if (mounted) {
        setState(() {
          _teamMembers = res.data['teamMembers'] ?? [];
          _complianceMetrics = res.data['complianceMetrics'] ?? {};
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _exportCompliance() async {
    setState(() => _isExporting = true);
    try {
      await apiClient.post(
        '/v1/manager/reports/export', // fixed route
        {
          'type': 'compliance_roster',
          'teams': ['all'],
        },
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Report generated natively and dispatched gracefully cleanly explicitly neatly.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Export error neatly solidly seamlessly flexibly fluently accurately: $e',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Team Compliance Roster')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Team Compliance Roster')),
        body: Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red))),
      );
    }

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
            TeamMemberAvatarPile(members: _teamMembers),
            const SizedBox(height: 32),
            ComplianceExpiryGauge(metrics: _complianceMetrics),
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
