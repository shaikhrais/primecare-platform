import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final qaSatisfactionProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/qa/satisfaction'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['satisfactions'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class QaSatisfactionScreen extends ConsumerWidget {
  const QaSatisfactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(qaSatisfactionProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Patient Satisfaction Hub'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Global Intake Feedback Aggregator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Complaints & Commendations DB', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No patient forms active.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Record Type', 'Date Subbed', 'Facility', 'Score', 'Report Detail'],
                                    data: items,
                                    rowBuilder: (data) => [
                                       DataCell(_buildTypeAction(data['type'])),
                                       DataCell(Text(data['createdAt'].toString().substring(0, 10))),
                                       DataCell(Text(data['franchise'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                       DataCell(Text('\${data["score"]}/5.0', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                                       DataCell(SizedBox(width: 300, child: Text(data['comments'] ?? 'No text notes.', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54)))),
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

  Widget _buildTypeAction(String t) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     IconData ic = Icons.info_outline;

     if (t == 'Commendation') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; ic = Icons.thumb_up_alt_outlined; }
     if (t == 'Neutral') { bg = Colors.grey.shade50; tx = Colors.grey.shade800; ic = Icons.remove; }
     if (t == 'Complaint') { bg = Colors.red.shade50; tx = Colors.red.shade800; ic = Icons.thumb_down_alt_outlined; }

     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
              Icon(ic, size: 12, color: tx),
              const SizedBox(width: 6),
              Text(t.toUpperCase(), style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
           ]
        ),
     );
  }
}
