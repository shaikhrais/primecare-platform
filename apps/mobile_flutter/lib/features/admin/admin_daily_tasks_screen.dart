import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminDailyTasksScreen extends ConsumerStatefulWidget {
  const AdminDailyTasksScreen({super.key});

  @override
  ConsumerState<AdminDailyTasksScreen> createState() =>
      _AdminDailyTasksScreenState();
}

class _AdminDailyTasksScreenState extends ConsumerState<AdminDailyTasksScreen> {
  Widget _buildOmniActionButtons(BuildContext context) {
    Widget buildButton(String path, IconData icon, String label) {
      return ElevatedButton.icon(
        onPressed: () => context.push(path),
        icon: Icon(icon),
        label: Text(label),
      );
    }

    final buttons = [
      buildButton('/psw/timesheets', Icons.schedule, 'Submit Timesheet'),
      buildButton('/psw/home', Icons.sensor_door, 'Live EVV Checkout'),
      buildButton('/rn/care-plan', Icons.medical_services, 'Author Care Plan'),
      buildButton('/rn/home', Icons.document_scanner, 'Execute Med-Recon'),
      buildButton('/coordinator/callin', Icons.phone_disabled, 'Process Sick Call-in'),
      buildButton('/coordinator/visit-adjust', Icons.edit_calendar, 'Global Matrix Adjustment'),
      buildButton('/manager/incidents', Icons.warning_amber, 'Resolve Escalations'),
      buildButton('/manager/payroll', Icons.payments, 'Authorize Payroll Batch'),
      buildButton('/superuser/territory', Icons.map, 'Provision Territories'),
      buildButton('/superuser/registry', Icons.sync, 'Execute Core Matrix Sync'),
      buildButton('/mt/surge-config', Icons.monetization_on, 'Configure Ecosystem Surge'),
      buildButton('/client/pulse', Icons.monitor_heart, 'Submit Wellness Pulse'),
      buildButton('/client/payments', Icons.credit_card, 'Settle Master Invoices'),
    ];

    return Container(
      width: double.infinity,
      color: Colors.blue.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Omni-Action Form Hub (All Roles Exposed)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: buttons,
          ),
        ],
      ),
    );
  }

  Widget _buildInlineDataEntryForm() {
    final TextEditingController textController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.edit_document, color: Colors.blue),
              SizedBox(width: 8),
              Text('Dispatch Framework Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: textController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Direct Communication Array payload',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted Natively: \${textController.text}'), backgroundColor: Colors.green));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Execute DB Cloud Storage'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN Native Data Entry Hub'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOmniActionButtons(context),
            _buildInlineDataEntryForm(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
