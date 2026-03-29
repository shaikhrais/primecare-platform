import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final patientsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/patients'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['patients'] as List<dynamic>;
    } else {
      throw Exception('Failed to load patients');
    }
  } catch (e) {
    debugPrint('API Error: \$e');
    return [];
  }
});

class ClientPatientsScreen extends ConsumerWidget {
  const ClientPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Patient Roster & Demographics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Active Patient Roster', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: Colors.teal.shade600, borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Roster', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 140,
               children: [
                  _buildStatCard('Total Patients', '1,248', '+12%', Colors.blue.shade600),
                  _buildStatCard('New Admissions', '84', '+5%', Colors.teal.shade600),
                  _buildStatCard('Critical Cases', '12', '-2%', Colors.orange.shade600),
               ]
            ),
            const SizedBox(height: 32),
            PrimeCareCard(
               child: patientsAsync.when(
                  data: (patients) => _buildPatientsTable(patients),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error loading DB Data: \$e')),
               )
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String val, String trend, Color c) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    Text(trend, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 14)),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildPatientsTable(List<dynamic> patients) {
      return PrimeCareDataTable<dynamic>(
          columns: const ['Patient', 'Age', 'Gender', 'Assigned Clinic', 'Status', 'Actions'],
          data: patients,
          rowBuilder: (pat) => [
              DataCell(
                  Row(
                      children: [
                          CircleAvatar(radius: 16, backgroundColor: Colors.teal.shade100, child: Text(pat['firstName'][0], style: TextStyle(color: Colors.teal.shade800, fontWeight: FontWeight.bold, fontSize: 12))),
                          const SizedBox(width: 12),
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                                Text('${pat["firstName"]} ${pat["lastName"]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('ID: ${pat["id"].toString().substring(0, 8)}', style: const TextStyle(fontSize: 10, color: Colors.black54)),
                             ]
                          )
                      ]
                  )
              ),
              DataCell(Text('${pat["age"]} yrs')),
              DataCell(Text(pat['gender'])),
              DataCell(Text(pat['clinic'] != null ? pat['clinic']['name'] : 'Unassigned', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500))),
              DataCell(
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: pat['status'] == 'ACTIVE' ? Colors.teal.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                      child: Text(pat['status'], style: TextStyle(color: pat['status'] == 'ACTIVE' ? Colors.teal.shade700 : Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold))
                  )
              ),
              DataCell(
                 Row(
                    children: [
                       Icon(Icons.visibility_outlined, size: 18, color: Colors.blue.shade600),
                       const SizedBox(width: 16),
                       Icon(Icons.edit_outlined, size: 18, color: Colors.grey.shade600),
                    ]
                 )
              )
          ]
      );
  }
}
