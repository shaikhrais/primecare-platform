import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final billingReportsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/billing/reports'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['goals'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BillingReportsScreen extends ConsumerWidget {
  const BillingReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(billingReportsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Revenue Forecasting'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Financial Projections', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Refresh KPI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 400,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Monthly Goals Bar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No goals tracked.')));
                                 return PrimeCareCard(
                                    child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: items.map((t) => _buildGoalCol(t['label'], t['targetRevenue']/100000.0, t['actualRevenue']/100000.0)).toList(),
                                    )
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error DB: $e')),
                           )
                        )
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Variance Table', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No data.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Month', 'Target Rev', 'Actual Rev', 'Variance'],
                                    data: items,
                                    rowBuilder: (data) {
                                       double diff = (data['actualRevenue'] - data['targetRevenue']);
                                       bool isPos = diff >= 0;
                                       return [
                                          DataCell(Text(data['label'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$${data['targetRevenue']}')),
                                          DataCell(Text('\$${data['actualRevenue']}')),
                                          DataCell(Text('${isPos ? '+' : ''}\$$diff', style: TextStyle(fontWeight: FontWeight.bold, color: isPos ? Colors.teal : Colors.red))),
                                       ];
                                    }
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

  Widget _buildGoalCol(String lbl, double hGoal, double hActual) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Container(width: 14, height: 300 * hGoal, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(top: Radius.circular(4)))),
                 const SizedBox(width: 2),
                 Container(width: 14, height: 300 * hActual, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        ]
     );
  }
}
