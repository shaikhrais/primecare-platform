import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final bdAccountsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/bd/accounts'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['accounts'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BdAccountsScreen extends ConsumerWidget {
  const BdAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(bdAccountsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Key Accounts (CRM)'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Enterprise Franchise CRM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('New Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Key Prospect Bookings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No accounts mapped.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Network Base', 'Primary Contact', 'Current Stage', 'Potential Val.', 'Win Prob (%)'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Row(children: [const Icon(Icons.business, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['accountName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                       DataCell(Text(data['contactName'])),
                                       DataCell(_buildStatusPill(data['stage'])),
                                       DataCell(Text('\$\${((data["potentialValue"] as num) / 1000000).toStringAsFixed(1)}M', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))),
                                       DataCell(Row(children: [Container(width: 40, height: 6, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(3)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: (data['probability'] as num) / 100, child: Container(decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(3))))), const SizedBox(width: 8), Text('\${data["probability"]}%')])),
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
     if (status == 'Success') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'Evaluation') { bg = Colors.orange.shade50; tx = Colors.deepOrange.shade800; }
     if (status == 'Discovery') { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 9, fontWeight: FontWeight.bold))
     );
  }
}
