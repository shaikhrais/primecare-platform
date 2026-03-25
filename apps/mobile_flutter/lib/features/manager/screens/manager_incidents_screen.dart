import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/env.dart';

class ManagerIncidentsScreen extends StatefulWidget {
  const ManagerIncidentsScreen({Key? key}) : super(key: key);

  @override
  _ManagerIncidentsScreenState createState() => _ManagerIncidentsScreenState();
}

class _ManagerIncidentsScreenState extends State<ManagerIncidentsScreen> {
  bool _isLoading = false;
  List<dynamic> _incidents = [];

  @override
  void initState() {
    super.initState();
    _fetchIncidents();
  }

  Future<void> _fetchIncidents() async {
    setState(() => _isLoading = true);
    try {
      // Mocked endpoint until GET endpoint is fully implemented for this view
      // This view assumes a listing mechanism exists or focuses purely on the resolution action
      // For MVP, we will display dummy unresolved incidents to demonstrate the PATCH action
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _incidents = [
          {
            'id': 'inc_001',
            'type': 'no_show',
            'severity': 'HIGH',
            'status': 'OPEN',
            'description': 'Caregiver failed to arrive at scheduled time.',
            'reportedAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
          },
          {
            'id': 'inc_002',
            'type': 'client_complaint',
            'severity': 'MEDIUM',
            'status': 'OPEN',
            'description': 'Client requested change in care plan schedule.',
            'reportedAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          }
        ];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load incidents: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resolveIncident(String incidentId, String notes) async {
    if (notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resolution notes are required.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.patch(
        Uri.parse('${Env.apiBaseUrl}/v1/manager/incidents/$incidentId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'status': 'RESOLVED',
          'resolutionNotes': notes,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Incident resolved successfully.')),
          );
          // Remove from local list for demo
          setState(() {
            _incidents.removeWhere((i) => i['id'] == incidentId);
          });
        }
      } else {
        throw Exception('Server returned ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resolving incident: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showResolveDialog(Map<String, dynamic> incident) {
    final TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve Incident'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${incident['type']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Details: ${incident['description']}'),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Resolution Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resolveIncident(incident['id'], notesController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successColor),
            child: const Text('Mark Resolved'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Management'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _incidents.isEmpty
          ? const Center(child: Text('No active incidents.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _incidents.length,
              itemBuilder: (context, index) {
                final incident = _incidents[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.warning_amber_rounded,
                      color: incident['severity'] == 'HIGH' ? Colors.red : Colors.orange,
                      size: 32,
                    ),
                    title: Text('Incident: ${incident['type']}'),
                    subtitle: Text(
                      'Reported: ${DateTime.parse(incident['reportedAt']).toLocal().toString().split('.')[0]}\nStatus: ${incident['status']}',
                    ),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      onPressed: () => _showResolveDialog(incident),
                      child: const Text('Resolve'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
