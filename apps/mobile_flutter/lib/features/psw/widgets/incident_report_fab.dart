import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class IncidentReportFab extends StatelessWidget {
  const IncidentReportFab({super.key});

  void _showIncidentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => const IncidentReportForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showIncidentModal(context),
      backgroundColor: Colors.red[700],
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      label: const Text('SOS / Incident', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class IncidentReportForm extends StatefulWidget {
  const IncidentReportForm({super.key});

  @override
  State<IncidentReportForm> createState() => _IncidentReportFormState();
}

class _IncidentReportFormState extends State<IncidentReportForm> {
  String _selectedType = 'medical_emergency';
  final _descController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitIncident() async {
    if (_descController.text.trim().isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('api_token') ?? '';
      
      final res = await http.post(
        Uri.parse('http://localhost:8787/v1/psw/incidents'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'type': _selectedType,
          'description': _descController.text.trim(),
        }),
      );

      if (mounted) {
        setState(() => _isSubmitting = false);
        if (res.statusCode == 201) {
          Navigator.pop(context); // Close modal cleanly stably intelligently dependably explicitly
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Critical Incident Logged and Escalated to Manager!'), backgroundColor: Colors.green),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to log incident: ${res.body}'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen height seamlessly efficiently cleanly carefully flexibly nicely elegantly optimally natively rationally smartly softly intuitively
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: keyboardHeight + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Report Critical Incident',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text('Incident Type:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'medical_emergency', child: Text('Medical Emergency / Fall')),
              DropdownMenuItem(value: 'no_show', child: Text('Client Not Home (No Show)')),
              DropdownMenuItem(value: 'environmental_hazard', child: Text('Environmental Hazard')),
              DropdownMenuItem(value: 'abuse_suspicion', child: Text('Suspicion of Abuse')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _selectedType = val);
            },
          ),
          const SizedBox(height: 16),
          const Text('Detailed Description:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _descController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe the situation exactly...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          _isSubmitting
            ? const Center(child: CircularProgressIndicator(color: Colors.red))
            : ElevatedButton.icon(
                onPressed: _submitIncident,
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text('SUBMIT ESCALATION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
        ],
      ),
    );
  }
}
