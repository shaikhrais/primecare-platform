import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final trainingProgramsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientTrainingPrograms']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['programs'] as List<dynamic>;
    } else {
      throw Exception('Failed to load programs');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class TrainingProgramsScreen extends ConsumerWidget {
  const TrainingProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(trainingProgramsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Clinical Curriculum Management'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Enterprise Training Programs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('New Module', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Active Educational Pipelines', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No active programs.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Curriculum Name', 'Department Target', 'Completion Metric', 'Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.school, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['programName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text(data['department'])),
                                          DataCell(Text('\${data["completionPct"]}% Completion', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.indigo))),
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
     if (status == 'Completed') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'Active') { bg = Colors.blue.shade50; tx = Colors.blue.shade800; }
     if (status == 'Scheduled') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
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
