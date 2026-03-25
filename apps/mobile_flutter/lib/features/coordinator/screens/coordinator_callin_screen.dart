import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/env.dart';
import 'package:intl/intl.dart';

class CoordinatorCallinScreen extends StatefulWidget {
  const CoordinatorCallinScreen({Key? key}) : super(key: key);

  @override
  _CoordinatorCallinScreenState createState() => _CoordinatorCallinScreenState();
}

class _CoordinatorCallinScreenState extends State<CoordinatorCallinScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  String? _selectedWorkerId;
  String? _selectedVisitId;
  String _reason = '';
  
  // Dummy data for MVP dropdowns
  final List<Map<String, String>> _workers = [
    {'id': 'usr_worker1', 'name': 'Nurse Sarah'},
    {'id': 'usr_worker2', 'name': 'PSW John'},
  ];
  
  final List<Map<String, String>> _visits = [
    {'id': 'vis_001', 'details': 'Today 2:00 PM - Client A'},
    {'id': 'vis_002', 'details': 'Tomorrow 9:00 AM - Client B'},
  ];

  Future<void> _submitCallIn() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_selectedWorkerId == null || _selectedVisitId == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both a worker and a visit.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.post(
        Uri.parse('${Env.apiBaseUrl}/v1/coordinator/call-ins'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'workerId': _selectedWorkerId,
          'visitId': _selectedVisitId,
          'reason': _reason,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('Call-in processed. Visit status updated and coverage alert dispatched.'),
               backgroundColor: AppTheme.successColor,
             ),
          );
          Navigator.of(context).pop(); // Go back after success
        }
      } else {
        throw Exception('Server returned ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing call-in: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Call-in'),
        backgroundColor: AppTheme.secondaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Log worker absence/call-in. This will automatically open the visit and trigger coverage search.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Worker',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                value: _selectedWorkerId,
                items: _workers.map((w) {
                  return DropdownMenuItem<String>(
                    value: w['id'],
                    child: Text(w['name']!),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedWorkerId = val),
                 validator: (value) =>
                    value == null ? 'Please select a worker' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Impacted Visit',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                value: _selectedVisitId,
                items: _visits.map((v) {
                  return DropdownMenuItem<String>(
                    value: v['id'],
                    child: Text(v['details']!),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedVisitId = val),
                validator: (value) =>
                    value == null ? 'Please select a visit' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Reason for Call-in',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please provide a reason';
                  }
                  return null;
                },
                onSaved: (val) => _reason = val ?? '',
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitCallIn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppTheme.primaryColor,
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit & Trigger Coverage', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
