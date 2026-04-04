import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final trainingFacilitatorsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientTrainingFacilitators']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['facilitators'] as List<dynamic>;
    } else {
      throw Exception('Failed to load facilitators');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class TrainingFacilitatorsScreen extends ConsumerWidget {
  const TrainingFacilitatorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(trainingFacilitatorsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Clinical Instructors Directory'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Registered Training Roster', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Facilitator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Active Classroom Assignments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No instructors found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Facilitator Avatar', 'Instructor Identity', 'Assigned Module', 'Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=random'))),
                                          DataCell(Text(data['facilitatorName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text(data['assignedCourse'], style: const TextStyle(fontStyle: FontStyle.italic))),
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

  Widget _buildStatusPill(String status) {
     final active = status == 'Active';
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: active ? Colors.teal : Colors.grey.shade400, borderRadius: BorderRadius.circular(4)),
        child: Text(status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
