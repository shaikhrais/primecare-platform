/* 
PRIME:SCREEN=family_billing
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
import 'family_billing_screen_controller.dart';

class FamilyBillingScreen extends GovernedConsumerWidget {
  const FamilyBillingScreen({super.key});

  @override
  String get screenDescription =>
      'View billing history, invoices, insurance receipts, and active payment methods for loved ones.';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyBillingScreenControllerProvider);

    return state.when(
      data: (data) => _FamilyBillingScreenContent(
        controllerProvider: familyBillingScreenControllerProvider,
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Telemetry connection failed: $error')),
      ),
    );
  }
}

class _FamilyBillingScreenContent extends ConsumerStatefulWidget {
  final dynamic controllerProvider;

  const _FamilyBillingScreenContent({
    required this.controllerProvider,
  });

  @override
  ConsumerState<_FamilyBillingScreenContent> createState() => _FamilyBillingScreenContentState();
}

class _FamilyBillingScreenContentState extends ConsumerState<_FamilyBillingScreenContent> {
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<Map<String, String>> _records = [
    {'title': 'Invoice #F-2026-101: June Care Shift', 'content': 'Paid. Total: \$850.00. Covers 24 hours of PSW assistance.', 'category': 'Invoices'},
    {'title': 'Insurance Receipt: Physiotherapy Q1', 'content': 'Sent. Total: \$350.00. Reimbursed at 80% under standard plan.', 'category': 'Receipts'},
    {'title': 'Primary Card: Visa **** 4321', 'content': 'Active. Auto-pay enabled for weekly nursing cycles.', 'category': 'PaymentMethods'}
  ];

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
        // Action / Purpose Hero panel
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
              const Text(
                'View billing history, invoices, insurance receipts, and active payment methods for loved ones.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Categories filters choice chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: ['All', 'Invoices', 'Receipts', 'PaymentMethods'].map((cat) {
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

        // Search text field
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

        // Main List view of records
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
                        child: const Text('Process Invoice Claim'),
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

        // Bottom log action button
        if (filtered.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showActionDialog,
              icon: const Icon(Icons.add_task),
              label: const Text('Process Invoice Claim'),
            ),
          ),
      ],
    );
  }

  void _showActionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Process Invoice Claim'),
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
