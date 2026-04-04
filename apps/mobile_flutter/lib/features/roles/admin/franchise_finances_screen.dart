import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final franchiseFinancesProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientFranchisemanFinances']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['finances'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FranchiseFinancesScreen extends ConsumerWidget {
  const FranchiseFinancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(franchiseFinancesProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Branch Fiscal Ledgers'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Monthly Local Finance Array', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: Colors.green.shade700, borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export CSV Matrix', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('P&L Profitability Groupings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No active ledgers.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Quarter Segment', 'Gross Enterprise Flow', 'Liquid Network Margin', 'Velocity YoY Growth'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['monthLabel'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$\${data["grossRevenue"]}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$\${data["netMargin"]}', style: const TextStyle(fontWeight: FontWeight.w800))),
                                          DataCell(
                                             Row(
                                                children: [
                                                   const Icon(Icons.show_chart, color: Colors.teal, size: 16),
                                                   const SizedBox(width: 4),
                                                   Text('+\${data["growthYoY"]}%', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))
                                                ]
                                             )
                                          ),
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
}
