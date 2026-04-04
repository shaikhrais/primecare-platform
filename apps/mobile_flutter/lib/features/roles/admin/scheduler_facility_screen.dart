import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final schedulerFacilityProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientSchedulerFacility']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['facilities'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SchedulerFacilityScreen extends ConsumerWidget {
  const SchedulerFacilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(schedulerFacilityProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Geographic Facility Monitor'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Clinic Occupancy Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Force Sync Node', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Regional Connectivity Layers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No nodes found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Geographic Base', 'Live Occupancy Gauge', 'System Status Indicator'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['facilityName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(
                                             Row(
                                                children: [
                                                   Expanded(
                                                       child: LinearProgressIndicator(
                                                          value: data['occupancyRate'],
                                                          backgroundColor: Colors.grey.shade200,
                                                          color: data['occupancyRate'] > 0.9 ? Colors.red : (data['occupancyRate'] > 0.6 ? Colors.orange : Colors.teal),
                                                       )
                                                   ),
                                                   const SizedBox(width: 8),
                                                   Text('${(data["occupancyRate"] * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                ]
                                             )
                                          ),
                                          DataCell(Text('${data["status"]}', style: const TextStyle(color: Colors.black))),
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
