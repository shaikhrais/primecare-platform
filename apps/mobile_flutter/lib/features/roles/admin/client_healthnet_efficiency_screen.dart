import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final healthnetEfficiencyProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/healthnet/efficiency'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['efficiencyMetrics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClientHealthnetEfficiencyScreen extends ConsumerWidget {
  const ClientHealthnetEfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(healthnetEfficiencyProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Clinical Efficiency Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Threshold Monitor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Sync Thresholds', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Clinic Efficiency Benchmarks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No thresholds found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Clinic Entity', 'System Efficiency', 'Patients Processed', 'Avg Wait (mins)'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text('${data["clinicName"]}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                                          DataCell(
                                              Row(
                                                 children: [
                                                     Text('${(data["efficiencyScore"] * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: data['efficiencyScore'] >= 0.9 ? Colors.green : Colors.amber)),
                                                     const SizedBox(width: 8),
                                                     Expanded(
                                                         child: LinearProgressIndicator(
                                                             value: data['efficiencyScore'], 
                                                             backgroundColor: Colors.grey.shade200, 
                                                             color: data['efficiencyScore'] >= 0.9 ? Colors.green : Colors.amber,
                                                             minHeight: 6,
                                                             borderRadius: BorderRadius.circular(3),
                                                         )
                                                     )
                                                 ]
                                              )
                                          ),
                                          DataCell(Text('${data["patientsSeen"]}', style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('${data["waitTimesAvg"]}m', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
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
