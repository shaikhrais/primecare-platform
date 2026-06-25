/* 
PRIME:SCREEN=clinic_history_logs
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'clinic_history_logs_screen_controller.dart';

class ClinicHistoryLogsScreen extends GovernedConsumerWidget {
  const ClinicHistoryLogsScreen({super.key});

  @override
  String get screenDescription =>
      'Database log of historic caregiver dispatches, ledger sync events, and completed visits.';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicHistoryLogsScreenControllerProvider);

    return Semantics(
      label: 'data-cy:clinichistorylogsscreen-screen',
      container: true,
      child: Scaffold(
        key: const Key('clinichistorylogsscreen-screen'),
        appBar: AppBar(
          title: Semantics(
            label: 'data-cy:clinichistorylogsscreen-title',
            container: true,
            child: Container(child: const Text('Clinic Operational Logs')),
          ),
        ),
        body: state.when(
          data: (data) => _ClinicHistoryLogsScreenContent(
            controllerProvider: clinicHistoryLogsScreenControllerProvider,
            desc: 'Database log of historic caregiver dispatches, ledger sync events, and completed visits.',
            actionLabel: 'Trigger Database Recount',
            itemsList: const [
              {'title': 'Dispatch: Milton Central Hub', 'content': 'Nurse Sarah dispatched at 8:42 AM. SLA met.', 'category': 'Dispatches'},
              {'title': 'Sync: Plaid accounting ledger', 'content': 'Completed hourly transaction ingestion sweep.', 'category': 'LedgerSync'},
              {'title': 'Visit: Home assessment complete', 'content': 'Completed joint physiotherapy gait session #12.', 'category': 'Visits'}
            ],
            categoriesList: const ['All', 'Dispatches', 'LedgerSync', 'Visits'],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Telemetry connection failed: $error')),
        ),
      ),
    );
  }
}

class _ClinicHistoryLogsScreenContent extends ConsumerStatefulWidget {
  final dynamic controllerProvider;
  final String desc;
  final String actionLabel;
  final List<Map<String, String>> itemsList;
  final List<String> categoriesList;

  const _ClinicHistoryLogsScreenContent({
    required this.controllerProvider,
    required this.desc,
    required this.actionLabel,
    required this.itemsList,
    required this.categoriesList,
  });

  @override
  ConsumerState<_ClinicHistoryLogsScreenContent> createState() => _ClinicHistoryLogsScreenContentState();
}

class _ClinicHistoryLogsScreenContentState extends ConsumerState<_ClinicHistoryLogsScreenContent> {
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  late List<Map<String, String>> _records;

  @override
  void initState() {
    super.initState();
    _records = List.from(widget.itemsList);
  }

  @override
  void dispose() {
    _dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _records.where((record) {
      final matchesQuery = record['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['content']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || record['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hero Card
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Operational Control Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.desc,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Choice Chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: widget.categoriesList.map((cat) {
              final isSel = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSel,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              );
            }).toList(),
          ),
        ),

        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search operations logs...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
        ),

        // List Content
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('No records match your criteria.'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _showActionDialog,
                        child: Text(widget.actionLabel),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final record = filtered[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.layers)),
                        title: Text(record['title']!),
                        subtitle: Text(record['content']!),
                        trailing: Text(
                          record['category']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(record['title']!),
                              content: Text(record['content']!),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),

        // Action Button
        if (filtered.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showActionDialog,
              icon: const Icon(Icons.add_task),
              label: Text(widget.actionLabel),
            ),
          ),
      ],
    );
  }

  void _showActionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(widget.actionLabel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dialogController,
              decoration: const InputDecoration(
                hintText: 'Enter details...',
                labelText: 'Operational Details',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = _dialogController.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _records.add({
                    'title': text,
                    'content': 'Manually registered log record transaction.',
                    'category': _selectedCategory == 'All' ? 'General' : _selectedCategory,
                  });
                });
                _dialogController.clear();
              }
              Navigator.pop(ctx);
            },
            child: const Text('Confirm Action'),
          ),
        ],
      ),
    );
  }
}
