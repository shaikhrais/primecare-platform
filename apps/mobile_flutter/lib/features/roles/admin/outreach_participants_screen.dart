import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final outreachParticipantsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientOutreachParticipants']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['metrics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load participants');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class OutreachParticipantsScreen extends ConsumerWidget {
  const OutreachParticipantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(outreachParticipantsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Participant Engagement Tracking'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Community Density Output', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Demographics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Monthly Screening Conversions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No participant data.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Time Window', 'Population Reached', 'Gross Engagement Score', 'Vitals Screened (Successful)'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['metricDate'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                          DataCell(Row(children: [const Icon(Icons.people, size: 14, color: Colors.grey), const SizedBox(width: 8), Text('\${data["totalReached"]}')])),
                                          DataCell(Text('\${data["engagementScore"]} / 100', style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildStatusPill(data['healthScreened'].toString() + ' Captures')),
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

  Widget _buildStatusPill(String txt) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)),
        child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
