import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final schedulerTrendsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientSchedulerTrends']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['trends'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SchedulerTrendsScreen extends ConsumerWidget {
  const SchedulerTrendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(schedulerTrendsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Appointment Frequency Trends'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Weekly Appointment Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Trends', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Volume vs Daily Baseline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No trends found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Day of Week', 'Total Volume', 'Utilization Density'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['dayLabel'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('${data["apptCount"]} Appointments', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold))),
                                          DataCell(
                                             Row(
                                                children: [
                                                   const Icon(Icons.analytics, color: Colors.teal, size: 14),
                                                   const SizedBox(width: 4),
                                                   Text('${(data["apptCount"] * 3.7).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))
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
