import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final hrOpeningsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/hr/openings'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['openings'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class HrJobOpeningsScreen extends ConsumerWidget {
  const HrJobOpeningsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(hrOpeningsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Active Requisitions'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Job Openings Directory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('+ New Requisition', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Requisition Database', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No job openings logged.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Job Title', 'Department', 'Location', 'Posted', 'Total Applicants', 'Status'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(Text(data['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                       DataCell(Text(data['department'])),
                                       DataCell(Text(data['location'])),
                                       DataCell(Text(data['postedDate'].toString().substring(0, 10))),
                                       DataCell(Text('${data['applicationCount']} hits', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal))),
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
     if (status == 'ACTIVE') { bg = Colors.green.shade50; tx = Colors.green.shade800; }
     if (status == 'CLOSED') { bg = Colors.red.shade50; tx = Colors.red.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(status, style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
