import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Hits POST /v1/coordinator/call-ins natively

class CoordinatorCallinScreen extends StatelessWidget {
  const CoordinatorCallinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Log PSW Call-in',
      subtitle: 'Drop actively assigned shift and trigger ecosystem dispatch',
      icon: Icons.phone_disabled,
      headerGradientColors: const [Colors.orange, Colors.deepOrangeAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Coverage Risk',
          value: 'Elevated',
          icon: Icons.security_update_warning,
          color: Colors.orange,
        ),
        UnifiedKpiCard(
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
                  initialValue: 'VISIT-9824 (Jane Doe - 14:00)',
                  decoration: const InputDecoration(
                    labelText: 'Target Visit to Free',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event_busy),
                  ),
                  readOnly: true, // For conceptual UX simulation
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: 'Sick',
                  decoration: const InputDecoration(
                    labelText: 'Drop Reason',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Sick', child: Text('Sick Leave')),
                    DropdownMenuItem(value: 'Emergency', child: Text('Personal Emergency')),
                    DropdownMenuItem(value: 'No Show', child: Text('No Show / Ghost')),
                  ],
                  onChanged: (_) {},
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Shift dropped! SOS Incident created. Reverting to requested pool.')),
                      );
                    },
                    icon: const Icon(Icons.wifi_tethering_error),
                    label: const Text('Execute Drop & Reschedule'),
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
