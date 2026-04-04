import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final outreachEventsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientOutreachEvents']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['events'] as List<dynamic>;
    } else {
      throw Exception('Failed to load events');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class OutreachEventsScreen extends ConsumerWidget {
  const OutreachEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(outreachEventsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Regional Events Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Deployed Health Fairs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Schedule Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Operational Health Campaigns', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No events data.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Campaign Initiative', 'Location Topology', 'Schedule Date', 'Target Capacity', 'Mission Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.festival, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['eventName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text(data['location'])),
                                          DataCell(Text(data['scheduledDate'].split('T')[0])),
                                          DataCell(Text('\${data["participantGoal"]} Pax', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.teal))),
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
     if (status == 'Active') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'Upcoming') { bg = Colors.blue.shade50; tx = Colors.blue.shade800; }
     if (status == 'Completed') { bg = Colors.purple.shade50; tx = Colors.purple.shade800; }
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
