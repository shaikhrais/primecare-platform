import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final franchiseRevenueProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/franchise/revenue'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['revenue'] as List<dynamic>;
    } else {
      throw Exception('Failed to load revenue');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FranchiseRevenueScreen extends ConsumerWidget {
  const FranchiseRevenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(franchiseRevenueProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Franchise Monthly Revenue'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Enterprise P&L Ledgers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Fiscal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Live Cash Flow Targets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No revenue data.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Fiscal Timeline', 'Revenue Output', 'Facility Visits', 'Growth Vector', 'Forecast Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.monetization_on, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['monthYear'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text('\$\${data["revenueAmt"].toString()}')),
                                          DataCell(Text('\${data["patientVisits"]} log')),
                                          DataCell(Text('+\${data["growthPct"]}%', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.teal))),
                                          DataCell(_buildStatusPill(data['status'])),
                                       ];
                                    },
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
     if (status == 'On Track') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'At Risk') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Container(width: 8, height: 8, decoration: BoxDecoration(color: tx, shape: BoxShape.circle)),
           const SizedBox(width: 8),
           Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 11, fontWeight: FontWeight.bold))
        ]
     );
  }
}
