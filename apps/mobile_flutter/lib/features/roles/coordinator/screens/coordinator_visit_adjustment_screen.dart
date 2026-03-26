import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/env.dart';
import 'package:intl/intl.dart';

class CoordinatorVisitAdjustmentScreen extends StatefulWidget {
  const CoordinatorVisitAdjustmentScreen({Key? key}) : super(key: key);

  @override
  _CoordinatorVisitAdjustmentScreenState createState() => _CoordinatorVisitAdjustmentScreenState();
}

class _CoordinatorVisitAdjustmentScreenState extends State<CoordinatorVisitAdjustmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  String? _selectedVisitId;
  DateTime? _newStartTime;
  DateTime? _newEndTime;
  String _notes = '';

  // Dummy visit data
  final List<Map<String, dynamic>> _visits = [
    {
      'id': 'vis_001', 
      'details': 'Today - Client A',
      'startTime': DateTime.now().add(const Duration(hours: 1)),
      'endTime': DateTime.now().add(const Duration(hours: 3)),
    },
     {
      'id': 'vis_002', 
      'details': 'Tomorrow - Client B',
      'startTime': DateTime.now().add(const Duration(days: 1, hours: 2)),
      'endTime': DateTime.now().add(const Duration(days: 1, hours: 5)),
    },
  ];

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final DateTime initialDate = isStart 
        ? (_newStartTime ?? DateTime.now())
        : (_newEndTime ?? (_newStartTime?.add(const Duration(hours: 1)) ?? DateTime.now().add(const Duration(hours: 1))));

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        setState(() {
          final dt = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
          if (isStart) {
            _newStartTime = dt;
            // auto-adjust end time if it's now before start time
            if (_newEndTime != null && _newEndTime!.isBefore(_newStartTime!)) {
              _newEndTime = _newStartTime!.add(const Duration(hours: 1));
            }
          } else {
            _newEndTime = dt;
          }
        });
      }
    }
  }

  void _onVisitSelected(String? visitId) {
    if (visitId == null) return;
    final visit = _visits.firstWhere((v) => v['id'] == visitId);
    setState(() {
      _selectedVisitId = visitId;
      _newStartTime = visit['startTime'];
      _newEndTime = visit['endTime'];
    });
  }

  Future<void> _submitAdjustment() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_selectedVisitId == null) return;

    if (_newStartTime == null || _newEndTime == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select valid start and end times.')),
      );
      return;
    }

    if (_newEndTime!.isBefore(_newStartTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time cannot be before start time.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      final response = await http.patch(
        Uri.parse('${Env.apiBaseUrl}/v1/coordinator/visits/$_selectedVisitId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'adjustedStartTime': _newStartTime!.toUtc().toIso8601String(),
          'adjustedEndTime': _newEndTime!.toUtc().toIso8601String(),
          'notes': _notes,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('Visit adjusted successfully. Client bill and worker pay recalculated.'),
               backgroundColor: AppTheme.successColor,
             ),
          );
          Navigator.of(context).pop();
        }
      } else {
        throw Exception('Server returned ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adjusting visit: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjust Visit'),
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
                'Modify visit times. Financial ledgers will be automatically reconciled.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Visit',
                  border: OutlineInputBorder(),
                ),
                value: _selectedVisitId,
                items: _visits.map((v) {
                  return DropdownMenuItem<String>(
                    value: v['id'],
                    child: Text(v['details']),
                  );
                }).toList(),
                onChanged: _onVisitSelected,
                 validator: (value) =>
                    value == null ? 'Please select a visit' : null,
              ),
              const SizedBox(height: 24),

              if (_selectedVisitId != null) ...[
                ListTile(
                  title: const Text('New Start Time'),
                  subtitle: Text(_newStartTime != null ? DateFormat('MMM d, yyyy - h:mm a').format(_newStartTime!) : 'Select Time'),
                  trailing: const Icon(Icons.edit),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  onTap: () => _selectDateTime(context, true),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('New End Time'),
                  subtitle: Text(_newEndTime != null ? DateFormat('MMM d, yyyy - h:mm a').format(_newEndTime!) : 'Select Time'),
                  trailing: const Icon(Icons.edit),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  onTap: () => _selectDateTime(context, false),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Adjustment Notes / Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide motivation for this change';
                    }
                    return null;
                  },
                  onSaved: (val) => _notes = val ?? '',
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isSaving ? null : _submitAdjustment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save & Reconcile Ledgers', style: TextStyle(fontSize: 16)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
