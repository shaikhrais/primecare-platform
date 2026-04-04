import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final clinicalScheduleProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientClinicalSchedule']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['schedule'] as List<dynamic>;
    } else {
      throw Exception('Failed to load schedule');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClinicalScheduleScreen extends ConsumerWidget {
  const ClinicalScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clinicalScheduleProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Medical Shift Dispatch'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Active Healthcare Shifts Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Publish Roster', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Registered Staff Allocations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No shifts tracked.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Assigned Provider', 'Credential Tag', 'Facility / Ward', 'Shift Commences', 'Shift Ends'],
                                    data: items,
                                    rowBuilder: (data) {
                                       final st = DateTime.parse(data['startTime']).toLocal();
                                       final et = DateTime.parse(data['endTime']).toLocal();
                                       final stF = '\${st.hour.toString().padLeft(2, "0")}:\${st.minute.toString().padLeft(2, "0")}';
                                       final etF = '\${et.hour.toString().padLeft(2, "0")}:\${et.minute.toString().padLeft(2, "0")}';
                                       
                                       return [
                                          DataCell(Text(data['providerName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildRolePill(data['role'])),
                                          DataCell(Row(children: [const Icon(Icons.location_city, size: 14, color: Colors.indigo), const SizedBox(width: 8), Text(data['facility'], style: const TextStyle(color: Colors.black87))])),
                                          DataCell(Text(stF, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))),
                                          DataCell(Text(etF, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54))),
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

  Widget _buildRolePill(String role) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4)),
        child: Text(role.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
