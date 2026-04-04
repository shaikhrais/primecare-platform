import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final schedulerRosterProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientSchedulerRoster']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['roster'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SchedulerRosterScreen extends ConsumerWidget {
  const SchedulerRosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(schedulerRosterProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Clinician Daily Roster'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Active Shift Scheduling', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Override', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Clinician Availability Engine', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No roster found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Clinician Identity', 'Specialization', 'Allocated Shift (Local Time)', 'Real-time Matrix'],
                                    data: items,
                                    rowBuilder: (data) {
                                       bool isAvail = data['isAvailable'] == true;
                                       return [
                                          DataCell(Text('${data["providerName"]}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                                          DataCell(Text('${data["specialty"]}', style: const TextStyle(color: Colors.black54))),
                                          DataCell(Text('${data["shiftTime"]}', style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(
                                              Container(
                                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                 decoration: BoxDecoration(color: isAvail ? Colors.green.shade50 : Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                                                 child: Text(isAvail ? 'Available' : 'Busy', style: TextStyle(color: isAvail ? Colors.green.shade800 : Colors.red.shade800, fontWeight: FontWeight.bold, fontSize: 10))
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
