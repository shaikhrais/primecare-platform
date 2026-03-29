import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';



// Hits GET /v1/client/bookings/:id/status natively

class ClientDispatchTrackerScreen extends StatelessWidget {
  const ClientDispatchTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Dispatch Tracker',
      subtitle: 'Live ETA & Transparent Assignment (Non-PII)',
      icon: Icons.map,
      headerGradientColors: const [Colors.lightBlue, Colors.blue],
      kpiCards: const [
        PrimeCareKpiCard(
          title: 'Current Status',
          value: 'En Route',
          icon: Icons.directions_car,
          color: Colors.blue,
        ),
        PrimeCareKpiCard(
          title: 'Estimated Arrival',
          value: '14:15 PM',
          icon: Icons.timer,
          color: Colors.green,
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
                const Text('Visit VST-8199 Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const ListTile(
                  leading: CircleAvatar(child: Text('JS')),
                  title: Text('Your Caregiver: Jane'),
                  subtitle: Text('Identity verified. Security matched.'),
                  trailing: Icon(Icons.verified, color: Colors.blue),
                ),
                const Divider(),
                _buildTimelineStep('Requested', '12:00 PM', true),
                _buildTimelineStep('Assigned & Confirmed', '13:14 PM', true),
                _buildTimelineStep('En Route (ETA 10m)', 'Live...', true, isActive: true),
                _buildTimelineStep('Arrived & Started', 'Pending', false),
                _buildTimelineStep('Completed', 'Pending', false, isLast: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep(String title, String time, bool isDone, {bool isActive = false, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Icon(
                  isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isActive ? Colors.blue : (isDone ? Colors.green : Colors.grey),
                  size: 20,
                ),
                if (!isLast) Expanded(child: Container(width: 2, color: isDone ? Colors.green : Colors.grey.shade300)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? Colors.blue : (isDone ? Colors.black : Colors.grey))),
                  Text(time, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
