import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final clinicalFranchiseProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientClinicalFranchise']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['analytics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClinicalFranchiseScreen extends ConsumerWidget {
  const ClinicalFranchiseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clinicalFranchiseProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Franchise Medical Audit'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Multi-State Clinical Outcomes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Audit Log', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 500,
               desktopCrossAxisCount: 1,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Quality Assurance Thresholds (By Region)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No districts active.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Geographic Cluster', 'Patient Survival Rate', '30-Day Readmission', 'Average ER Wait Time'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.corporate_fare, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['regionCode'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text('\${data["survivalRate"]}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))),
                                          DataCell(Text('\${data["readmissionRate"]}%', style: TextStyle(fontWeight: FontWeight.bold, color: (data['readmissionRate'] as num) > 5 ? Colors.red : Colors.green))),
                                          DataCell(Text('\${data["averageWaitTime"]} Minutes', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54))),
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
