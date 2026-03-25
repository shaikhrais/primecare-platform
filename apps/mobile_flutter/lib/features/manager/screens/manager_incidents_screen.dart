import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/api_client.dart';

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
      final data = await apiClient.get('/v1/manager/incidents?status=OPEN');
      if (mounted) {
        setState(() {
          _incidents = List<dynamic>.from(data);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load real incidents: $e'), backgroundColor: Colors.red),
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
      final res = await apiClient.patch('/v1/manager/incidents/$incidentId', body: {
        'status': 'resolved',
        'resolutionNotes': notes,
      });

      if (mounted) {
        if (res['id'] != null || res['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Incident officially closed.'), backgroundColor: Colors.green),
          );
          setState(() {
            _incidents.removeWhere((i) => i['id'] == incidentId);
          });
        } else {
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed: ${res['error']}'), backgroundColor: Colors.red),
             );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server Error: $e'), backgroundColor: Colors.red),
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
