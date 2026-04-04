import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final opsStaffProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientOpsStaff']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['staffs'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class OpsStaffMetricsScreen extends ConsumerWidget {
  const OpsStaffMetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(opsStaffProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Staff Utilization'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Workforce Distribution Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                        const Text('Clinical Breakdown Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No staff tracked.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Staff Core', 'Role Title', 'Total Hours', 'Clinical Load', 'Admin Tasks', 'Optimization'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Row(children: [const Icon(Icons.badge, size: 14, color: Colors.indigo), const SizedBox(width: 8), Text(data['staffName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                       DataCell(Text(data['role'])),
                                       DataCell(Text('${data['totalHours']}h')),
                                       DataCell(Text('${data['clinicalHours']}h', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                       DataCell(Text('${data['adminHours']}h')),
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
     if (status == 'Optimized') { bg = Colors.green.shade50; tx = Colors.green.shade800; }
     if (status == 'Underutilized') { bg = Colors.yellow.shade100; tx = Colors.orange.shade900; }
     if (status == 'Overworked') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 9, fontWeight: FontWeight.bold))
     );
  }
}
