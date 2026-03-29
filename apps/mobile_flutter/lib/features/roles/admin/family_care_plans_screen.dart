import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final familyCarePlansProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/family-care-plans'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['tasks'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FamilyCarePlansScreen extends ConsumerStatefulWidget {
  const FamilyCarePlansScreen({super.key});
  @override ConsumerState<FamilyCarePlansScreen> createState() => _State();
}

class _State extends ConsumerState<FamilyCarePlansScreen> {
  final Map<String, bool> _localCompleted = {};

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(familyCarePlansProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Care Plan Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('James Oswald - Daily Checklist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Tracker', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 600,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Daily Checklist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (tasks) {
                                 if (tasks.isEmpty) return const PrimeCareCard(child: Center(child: Text('No daily tasks')));
                                 return ListView.separated(
                                    itemCount: tasks.length,
                                    separatorBuilder: (c, i) => const SizedBox(height: 16),
                                    itemBuilder: (c, i) => _buildTaskRow(tasks[i]),
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error DB: $e')),
                           )
                        )
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Vitals Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(child: PrimeCareCard(child: const Center(child: Text('Vitals Graph Mock UI', style: TextStyle(color: Colors.grey))))),
                     ]
                  ),
               ]
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildTaskRow(dynamic t) {
     final id = t['id'];
     final name = t['taskName'];
     final time = t['timeSlot'];
     final cat = t['category'];
     final isC = _localCompleted[id] ?? t['isCompleted'];

     IconData ic = Icons.medication;
     Color cc = Colors.teal.shade600;
     if (cat == 'VITALS') { ic = Icons.favorite; cc = Colors.orange.shade600; }
     if (cat == 'ACTIVITY') { ic = Icons.directions_walk; cc = Colors.indigo.shade600; }

     return PrimeCareCard(
        child: Row(
           children: [
              Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(color: cc.withOpacity(0.1), shape: BoxShape.circle),
                 child: Icon(ic, color: cc)
              ),
              const SizedBox(width: 16),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(name, style: TextStyle(fontWeight: FontWeight.bold, decoration: isC ? TextDecoration.lineThrough : null, color: isC ? Colors.grey : Colors.black87)),
                       const SizedBox(height: 4),
                       Row(
                          children: [
                             Icon(Icons.schedule, size: 12, color: Colors.grey.shade600),
                             const SizedBox(width: 4),
                             Text(time, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                          ]
                       )
                    ]
                 )
              ),
              InkWell(
                 onTap: () {
                    setState(() { _localCompleted[id] = !isC; });
                 },
                 child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: isC ? Colors.grey.shade200 : const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(16)),
                    child: Text(isC ? 'Undo' : 'Adhere / Verify', style: TextStyle(color: isC ? Colors.black54 : Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                 )
              )
           ]
        )
     );
  }
}
