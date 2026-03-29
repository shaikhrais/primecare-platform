import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final billingClaimsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/billing/claims'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['claims'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BillingClaimsScreen extends ConsumerWidget {
  const BillingClaimsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(billingClaimsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Claims Processing'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Insurance Claims Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export API', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 600,
               desktopCrossAxisCount: 1,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Submission Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No claims logged.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Claim Code', 'Provider', 'Patient', 'Submission Date', 'Amount', 'Status', 'Denial Info'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Text(data['claimCode'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                       DataCell(Row(children: [const Icon(Icons.corporate_fare, size: 14, color: Colors.indigo), const SizedBox(width: 8), Text(data['provider'])])),
                                       DataCell(Text(data['patientName'])),
                                       DataCell(Text(data['submissionDate'].toString().substring(0, 10))),
                                       DataCell(Text('\$${data['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                       DataCell(_buildStatusPill(data['status'])),
                                       DataCell(Text(data['denialReason'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 12))),
                                    ],
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error DB: $e')),
                           )
                        )
                     ]
                  ),
               ]
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     if (status == 'Reimbursed') { bg = Colors.green.shade50; tx = Colors.green.shade800; }
     if (status == 'Submission') { bg = Colors.blue.shade50; tx = Colors.blue.shade800; }
     if (status == 'Review') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
     if (status == 'Denied') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 9, fontWeight: FontWeight.bold))
     );
  }
}
