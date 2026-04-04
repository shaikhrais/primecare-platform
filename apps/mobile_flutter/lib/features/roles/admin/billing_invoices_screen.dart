import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final billingInvoicesProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientBillingInvoices']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['invoices'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BillingInvoicesScreen extends ConsumerWidget {
  const BillingInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(billingInvoicesProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Accounts Receivable'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Invoice Directory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export CSV', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('All Invoices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No invoices logged.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Invoice ID', 'Patient', 'Location', 'Amount', 'Issue Date', 'Status'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Text(data['invoiceId'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                       DataCell(Text(data['patientName'])),
                                       DataCell(Text(data['clinicLocation'])),
                                       DataCell(Text('\$${data['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))),
                                       DataCell(Text(data['issueDate'].toString().substring(0, 10))),
                                       DataCell(_buildStatusPill(data['status'])),
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
     if (status == 'Paid') { bg = Colors.green.shade50; tx = Colors.green.shade800; }
     if (status == 'Pending') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
     if (status == 'Overdue') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status, style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
