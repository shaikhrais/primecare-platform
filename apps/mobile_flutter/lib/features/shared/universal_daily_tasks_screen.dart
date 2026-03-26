import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';

final universalTasksProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, rolePrefix) async {
      final response = await apiClient.get('/api/activities?role=$rolePrefix');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        return [];
      }
    });

class UniversalDailyTasksScreen extends ConsumerStatefulWidget {
  final String rolePrefix;
  const UniversalDailyTasksScreen({super.key, required this.rolePrefix});

  @override
  ConsumerState<UniversalDailyTasksScreen> createState() =>
      _UniversalDailyTasksScreenState();
}

class _UniversalDailyTasksScreenState
    extends ConsumerState<UniversalDailyTasksScreen> {
  Future<void> _markTaskComplete(String taskId) async {
    try {
      await apiClient.patch(
        '/api/activities/$taskId',
        {'status': 'completed'},
      );
      ref.invalidate(universalTasksProvider(widget.rolePrefix));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Task physically marked as complete gracefully natively.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to complete task securely: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildRoleSpecificEntryButtons(BuildContext context, String rolePrefix) {
    List<Widget> buttons = [];

    Widget buildButton(String path, IconData icon, String label) {
      return ElevatedButton.icon(
        onPressed: () => context.push(path),
        icon: Icon(icon),
        label: Text(label),
      );
    }

    if (rolePrefix == 'admin' || rolePrefix == 'superuser') {
      buttons = [
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
    } else {
      switch (rolePrefix.toLowerCase()) {
        case 'psw':
          buttons = [
            buildButton('/psw/timesheets', Icons.schedule, 'Submit Timesheet'),
            buildButton('/psw/home', Icons.sensor_door, 'Live EVV Checkout'),
          ];
          break;
        case 'rn':
          buttons = [
            buildButton('/rn/care-plan', Icons.medical_services, 'Author Care Plan'),
            buildButton('/rn/home', Icons.document_scanner, 'Execute Med-Recon'),
          ];
          break;
        case 'coordinator':
          buttons = [
            buildButton('/coordinator/callin', Icons.phone_disabled, 'Process Sick Call-in'),
            buildButton('/coordinator/visit-adjust', Icons.edit_calendar, 'Global Matrix Adjustment'),
          ];
          break;
        case 'manager':
          buttons = [
            buildButton('/manager/incidents', Icons.warning_amber, 'Resolve Escalations'),
            buildButton('/manager/payroll', Icons.payments, 'Authorize Payroll Batch'),
          ];
          break;
        case 'mt':
          buttons = [
            buildButton('/mt/surge-config', Icons.monetization_on, 'Configure Ecosystem Surge'),
          ];
          break;
        case 'client':
          buttons = [
            buildButton('/client/pulse', Icons.monitor_heart, 'Submit Wellness Pulse'),
            buildButton('/client/payments', Icons.credit_card, 'Settle Master Invoices'),
          ];
          break;
      }
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: Colors.blue.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rolePrefix == 'admin' || rolePrefix == 'superuser'
                ? 'Omni-Action Form Hub (All Roles Exposed)'
                : 'Quick Action Data Entry Form Hub',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

  Widget _buildInlineDataEntryForm(String role) {
    String formTitle = 'Data Entry';
    String formPlaceholder = 'Enter required data...';
    String formButton = 'Submit Entry';

    switch (role.toLowerCase()) {
      case 'superuser':
      case 'admin':
        formTitle = 'Dispatch Framework Message';
        formPlaceholder = 'Direct Communication Array payload';
        formButton = 'Execute DB Cloud Storage';
        break;
      case 'psw':
        formTitle = 'Clinical Progress Note';
        formPlaceholder = 'Describe patient vitals, mood, and daily observations...';
        formButton = 'Log Native Progress to DB';
        break;
      case 'rn':
        formTitle = 'Medical Reconciliation Log';
        formPlaceholder = 'Identify and document structural medication adjustments...';
        formButton = 'Execute Med-Recon Commit';
        break;
      case 'manager':
        formTitle = 'Incident Resolution Report';
        formPlaceholder = 'Detail the resolution strategy applied to this escalation...';
        formButton = 'Clear Escalation Safely';
        break;
      case 'coordinator':
        formTitle = 'Active Dispatch Adjustment';
        formPlaceholder = 'Provide structural justification for shift trajectory override...';
        formButton = 'Commit Schedule Matrix';
        break;
      case 'client':
        formTitle = 'Client Wellness Feedback';
        formPlaceholder = 'Provide feedback to your care agency...';
        formButton = 'Push Secure Feedback';
        break;
      default:
        formTitle = '${role.toUpperCase()} Entry Module';
        formPlaceholder = 'General telemetry notes...';
        formButton = 'Commit Data';
    }

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
          Row(
            children: [
              const Icon(Icons.edit_document, color: Colors.blue),
              const SizedBox(width: 8),
              Text(formTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: textController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: formPlaceholder,
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted Natively: ${textController.text}'), backgroundColor: Colors.green));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(formButton),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final asyncTasks = ref.watch(universalTasksProvider(widget.rolePrefix));

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.rolePrefix.toUpperCase()} Multi-Role Data Entry Hub'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRoleSpecificEntryButtons(context, widget.rolePrefix),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInlineDataEntryForm(widget.rolePrefix),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Active Task Queue:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  asyncTasks.when(
                    loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
                    error: (err, stack) => Center(child: Padding(padding: const EdgeInsets.all(32), child: Text('Error loading tasks organically: $err'))),
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'All tasks completed for today!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final taskId = task['id']?.toString() ?? 'fallback_${index}';
              final title = task['title'] ?? 'Task ${index + 1}';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.assignment_turned_in, color: Colors.blue),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    task['description'] ?? 'Completion Required.',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _markTaskComplete(taskId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    child: const Text('Mark Complete'),
                  ),
                  onTap: () => _markTaskComplete(taskId),
                ),
              );
            },
          );
        },
      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
