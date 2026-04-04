import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final qaIncidentsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientQaIncidents']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['incidents'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class QaIncidentsScreen extends ConsumerWidget {
  const QaIncidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(qaIncidentsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Medical Incidents Pipeline'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Severe Clinical Errors & Tracking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                        const Text('Incidents by Severity Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No active parameters tracked.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Severity', 'Date Logged', 'Type', 'Facility', 'Description', 'Status'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(_buildSeverityPill(data['severity'])),
                                       DataCell(Text(data['createdAt'].toString().substring(0, 10))),
                                       DataCell(Text(data['incidentType'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                       DataCell(Text(data['franchise'])),
                                       DataCell(ConstrainedBox(constraints: const BoxConstraints(maxWidth: 200), child: Text(data['description'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey)))),
                                       DataCell(Text(data['status'], style: TextStyle(color: data['status'] == 'Closed' ? Colors.green : Colors.orange.shade800, fontWeight: FontWeight.bold))),
                                    ],
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

  Widget _buildSeverityPill(String severity) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     if (severity == 'Critical') { bg = Colors.red.shade900; tx = Colors.white; }
     if (severity == 'High') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     if (severity == 'Low') { bg = Colors.yellow.shade50; tx = Colors.orange.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(severity.toUpperCase(), style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
