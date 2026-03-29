import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final supportSatisfactionProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/support/satisfaction'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['feedbacks'] as List<dynamic>;
    } else {
      throw Exception('Failed to load satisfaction');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SupportSatisfactionScreen extends ConsumerWidget {
  const SupportSatisfactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(supportSatisfactionProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Patient Feedback Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Live CRM Satisfaction Matrices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Feedback', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Recent Survey Responses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No feedback found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Assigned Facility', 'Survey Target', 'Feedback / Comments', 'NPS Star Rating', 'Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['franchiseName'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                          DataCell(Row(children: [const Icon(Icons.person, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['patientName'])])),
                                          DataCell(Text(data['comments'], style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54), overflow: TextOverflow.ellipsis)),
                                          DataCell(_buildStars(data['rating'])),
                                          DataCell(_buildStatusPill(data['status'])),
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

  Widget _buildStars(int rating) {
     return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
           return Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 16);
        }),
     );
  }

  Widget _buildStatusPill(String status) {
     final reviewed = status == 'Reviewed';
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: reviewed ? Colors.teal : Colors.grey.shade400, borderRadius: BorderRadius.circular(4)),
        child: Text(status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
