import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final clinicalAdmissionsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientClinicalAdmissions']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['admissions'] as List<dynamic>;
    } else {
      throw Exception('Failed to load admissions');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClinicalAdmissionsScreen extends ConsumerWidget {
  const ClinicalAdmissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clinicalAdmissionsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Triage & Admissions Board'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Active Ward & ICU Transfers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                        const Text('Live Priority Patient Queue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No active patients.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Patient ID & Name', 'Triage Status', 'Medical Condition', 'Assigned Location', 'Attending Physician'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.person, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['patientName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(_buildPriorityPill(data['priority'])),
                                          DataCell(Text(data['condition'])),
                                          DataCell(Text(data['location'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                          DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(data['attendingPhys']))),
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

  Widget _buildPriorityPill(String status) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     if (status == 'Critical') { bg = Colors.red.shade50; tx = Colors.redAccent; }
     if (status == 'High') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
     if (status == 'Normal') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
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
