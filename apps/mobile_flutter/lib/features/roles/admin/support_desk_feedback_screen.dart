import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final supportFeedbackProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/support-desk/feedback'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['feedback'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SupportDeskFeedbackScreen extends ConsumerWidget {
  const SupportDeskFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(supportFeedbackProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Quality Assurance CSAT'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Post-Resolution Analytics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export CSAT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Resolution Logging', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No Local Content found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Identifier Trace', 'Post-Op Sat Rating', 'Detailed Text Extract'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['patientName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildStars(data['csatScore'])),
                                          DataCell(Text('"\${data["feedbackText"]}"', style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey))),
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

  Widget _buildStars(num score) {
     return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Icon(Icons.star, color: score >= 1 ? Colors.amber : Colors.grey.shade300, size: 16),
           Icon(Icons.star, color: score >= 2 ? Colors.amber : Colors.grey.shade300, size: 16),
           Icon(Icons.star, color: score >= 3 ? Colors.amber : Colors.grey.shade300, size: 16),
           Icon(Icons.star, color: score >= 4 ? Colors.amber : Colors.grey.shade300, size: 16),
           Icon(Icons.star, color: score >= 5 ? Colors.amber : Colors.grey.shade300, size: 16),
           const SizedBox(width: 8),
           Text(score.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ]
     );
  }
}
