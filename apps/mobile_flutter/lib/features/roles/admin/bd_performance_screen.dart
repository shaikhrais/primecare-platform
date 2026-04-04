import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final bdPerformanceProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientBdPerformance']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['reps'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BdPerformanceScreen extends ConsumerWidget {
  const BdPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(bdPerformanceProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Rep Performance Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Quarterly Sales Analytics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export JSON', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Rep Quota Attainment Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No performers tracked.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Executive Rep', 'Target Quota', 'Attainment', 'Pacing %', 'Meetings', 'Live Pipeline'],
                                    data: items,
                                    rowBuilder: (data) {
                                       double quota = (data['quota'] as num).toDouble();
                                       double att = (data['attainment'] as num).toDouble();
                                       double pacing = (att / quota) * 100;
                                       return [
                                          DataCell(Text(data['repName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$\${(quota / 1000000).toStringAsFixed(1)}M', style: const TextStyle(color: Colors.black54))),
                                          DataCell(Text('\$\${(att / 1000000).toStringAsFixed(1)}M', style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildPacingPill(pacing)),
                                          DataCell(Text('\${data["meetings"]}')),
                                          DataCell(Text('\$\${((data["pipelineValue"] as num) / 1000000).toStringAsFixed(1)}M', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
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

  Widget _buildPacingPill(double pct) {
     Color bg = Colors.red.shade50;
     Color tx = Colors.red.shade800;

     if (pct >= 100) { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     else if (pct >= 75) { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); }
     else if (pct >= 50) { bg = Colors.orange.shade50; tx = Colors.orange.shade900; }

     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text('\${pct.toStringAsFixed(0)}% to Goal', style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
