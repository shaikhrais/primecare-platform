import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final healthnetRevenueProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientHealthnetRevenue']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['revenueMetrics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClientHealthnetRevenueScreen extends ConsumerWidget {
  const ClientHealthnetRevenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(healthnetRevenueProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Revenue Pipeline Analysis'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Quarterly Growth Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export P&L', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Revenue Matrix Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No revenue found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Quarter Block', 'Total Capital', 'Gross Margin Yield'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['quarterLabel'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$${(data["revenueValue"] / 1000000).toStringAsFixed(2)}M', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold))),
                                          DataCell(
                                             Row(
                                                children: [
                                                   const Icon(Icons.arrow_upward, color: Colors.teal, size: 14),
                                                   const SizedBox(width: 4),
                                                   Text('${(data["grossMargin"] * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))
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
