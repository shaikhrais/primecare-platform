import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final supportTicketsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/support/tickets'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['tickets'] as List<dynamic>;
    } else {
      throw Exception('Failed to load tickets');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SupportTicketsScreen extends ConsumerWidget {
  const SupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(supportTicketsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Global IT Helpdesk Hub'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Active Franchise & Clinical Tickets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('New Support Ticket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Live Triage Queue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No active tickets.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Franchise Origin', 'Patient Ref', 'Issue Classification', 'Resolution SLA', 'Assigned Tech'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.corporate_fare, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['franchiseName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text(data['patientRef'])),
                                          DataCell(Text(data['issueType'], style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.indigo))),
                                          DataCell(_buildStatusPill(data['status'])),
                                          DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(data['assignedTo']))),
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
     if (status == 'Resolved') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'In Progress') { bg = Colors.blue.shade50; tx = Colors.blue.shade800; }
     if (status == 'Pending') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
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
