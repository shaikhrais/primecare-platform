import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/adapter_providers.dart';
import '../../domain/models/billing_summary_models.dart';
import '../../../../office/components/glass_surface.dart';

final billingSummaryFutureProvider = FutureProvider.family<BillingSummaryViewModel, String>((ref, accountId) async {
  final adapter = ref.watch(billingSummaryAdapterProvider);
  return adapter.getData(accountId);
});

class BillingSummaryScreen extends ConsumerWidget {
  final String accountId;
  const BillingSummaryScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(billingSummaryFutureProvider(accountId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Billing Summary'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
        data: (viewModel) => _buildBillingData(context, viewModel),
      ),
    );
  }

  Widget _buildBillingData(BuildContext context, BillingSummaryViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Account ${viewModel.accountId}', style: const TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              if (viewModel.isOverdue)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('OVERDUE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                )
            ],
          ),
          const SizedBox(height: 32),
          GlassSurface(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Text('Total Balance Due', style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 8),
                Text('\$${viewModel.totalDue.toStringAsFixed(2)}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.teal)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Amount Paid', style: TextStyle(color: Colors.grey)),
                        Text('\$${viewModel.amountPaid.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Next Deadline', style: TextStyle(color: Colors.grey)),
                        Text(viewModel.nextDueDate, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(key: const Key('data-status-id=shared-global-billing-action-1'), 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            ),
            onPressed: () {},
            child: const Text('Make a Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
