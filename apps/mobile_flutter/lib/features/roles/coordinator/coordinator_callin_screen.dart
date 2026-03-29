import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';


import 'package:primecare_mobile/core/api_client.dart';

// Hits POST /v1/coordinator/call-ins natively

class CoordinatorCallinScreen extends StatefulWidget {
  const CoordinatorCallinScreen({super.key});

  @override
  State<CoordinatorCallinScreen> createState() => _CoordinatorCallinScreenState();
}

class _CoordinatorCallinScreenState extends State<CoordinatorCallinScreen> {
  String _dropReason = 'Sick';
  bool _isLoading = false;

  Future<void> _executeDrop() async {
    setState(() => _isLoading = true);
    try {
      final res = await apiClient.post('/v1/coordinator/call-ins', {
        'visitId': 'VST-9981',
        'reason': _dropReason,
      });

      if (!mounted) return;

      if (res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shift dropped! SOS Incident created. Reverting to requested pool.'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: ${res['error']}'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Log PSW Call-in',
      subtitle: 'Drop actively assigned shift and trigger ecosystem dispatch',
      icon: Icons.phone_disabled,
      headerGradientColors: const [Colors.orange, Colors.deepOrangeAccent],
      kpiCards: const [
        PrimeCareKpiCard(
          title: 'Coverage Risk',
          value: 'Elevated',
          icon: Icons.security_update_warning,
          color: Colors.orange,
        ),
        PrimeCareKpiCard(
          title: 'Standby Pool',
          value: '4 PSWs',
          icon: Icons.groups,
          color: Colors.blue,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rapid Shift Dropout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: 'VST-9981 (Jane Doe - 14:00)',
                  decoration: const InputDecoration(
                    labelText: 'Target Visit to Free',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event_busy),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _dropReason,
                  decoration: const InputDecoration(
                    labelText: 'Drop Reason',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Sick', child: Text('Sick Leave')),
                    DropdownMenuItem(value: 'Emergency', child: Text('Personal Emergency')),
                    DropdownMenuItem(value: 'No Show', child: Text('No Show / Ghost')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _dropReason = val);
                    }
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _executeDrop,
                    icon: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.wifi_tethering_error),
                    label: Text(_isLoading ? 'Processing...' : 'Execute Drop & Reschedule'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
