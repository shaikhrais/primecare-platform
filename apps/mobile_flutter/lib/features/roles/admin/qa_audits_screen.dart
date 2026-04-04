import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final qaAuditsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientQaAudits']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['audits'] as List<dynamic>;
    } else {
      throw Exception('Failed to load audits');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class QaAuditsScreen extends ConsumerWidget {
  const QaAuditsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(qaAuditsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Franchise Audit Master Ledger'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Regulatory Audit Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Refresh Cache', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Branch Performance Logs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No audits mapped.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Auditor', 'Facility', 'Audit Date', 'Final Score', 'Compliance Range', 'State Status'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Row(children: [const Icon(Icons.shield_outlined, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['auditorName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                       DataCell(Text(data['franchise'])),
                                       DataCell(Text(data['auditDate'].toString().substring(0, 10))),
                                       DataCell(Text('\${data["score"]}/100', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                       DataCell(Text('\${data["compliancePct"]}%')),
                                       DataCell(_buildStatusPill(data['status'])),
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

  Widget _buildStatusPill(String status) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     if (status == 'Passed') { bg = Colors.green.shade50; tx = Colors.green.shade800; }
     if (status == 'Warning') { bg = Colors.yellow.shade100; tx = Colors.orange.shade900; }
     if (status == 'Failed') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 9, fontWeight: FontWeight.bold))
     );
  }
}
