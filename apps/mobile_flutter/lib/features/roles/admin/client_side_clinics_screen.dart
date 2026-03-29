import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final clientClinicsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/client-side/clinics'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['clinics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClientSideClinicsScreen extends ConsumerWidget {
  const ClientSideClinicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clientClinicsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Top Performing Clinics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Franchise Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Compare KPIs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Clinic Matrix Output', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No clinics found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Rank #', 'Clinic Entity', 'Star Rating', 'Gross Revenue'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text('#${data['rank']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                                          DataCell(Text('${data["clinicName"]}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
                                          DataCell(_buildStars(data['starRating'])),
                                          DataCell(Text('${data["revenueString"]}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
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
        ]
     );
  }
}
