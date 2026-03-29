import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final intakeQueueProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/intake/queue'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['intakes'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class IntakeQueueScreen extends ConsumerStatefulWidget {
  const IntakeQueueScreen({super.key});
  @override ConsumerState<IntakeQueueScreen> createState() => _State();
}

class _State extends ConsumerState<IntakeQueueScreen> {
  final Map<String, bool> _localApproved = {};

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(intakeQueueProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Patient Intake Queue'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Pending Intake Appraisals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Queue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Live KanBan Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (tasks) {
                                 if (tasks.isEmpty) return const PrimeCareCard(child: Center(child: Text('No daily intakes')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Patient', 'Location', 'Priority', 'Status', 'Date Logged', 'Action'],
                                    data: tasks,
                                    rowBuilder: (data) => _buildDataRow(data),
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

  List<DataCell> _buildDataRow(dynamic t) {
     final id = t['id'];
     final name = t['patientName'];
     final time = DateTime.parse(t['createdAt'].toString());
     final loc = t['franchiseCity'];
     final p = t['priority'];
     final isA = _localApproved[id] ?? (t['status'] == 'Approved');
     
     Color pC = Colors.black87;
     if (p == 'High') pC = Colors.red;
     if (p == 'Med') pC = Colors.amber.shade800;

     return [
        DataCell(Row(children: [const Icon(Icons.person, color: Colors.grey, size: 16), const SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, decoration: isA ? TextDecoration.lineThrough : null, color: isA ? Colors.grey : Colors.black87))])),
        DataCell(Text(loc)),
        DataCell(Text(p, style: TextStyle(color: pC, fontWeight: FontWeight.bold))),
        DataCell(Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: isA ? Colors.grey.shade400 : Colors.teal.shade500, borderRadius: BorderRadius.circular(12)),
            child: Text(isA ? 'Archived' : t['status'], style: const TextStyle(color: Colors.white, fontSize: 10))
        )),
        DataCell(Text('${time.month}/${time.day} ${time.hour}:${time.minute}')),
        DataCell(
           InkWell(
              onTap: () {
                 setState(() { _localApproved[id] = !isA; });
              },
              child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(border: Border.all(color: isA ? Colors.grey : const Color(0xFF0F4C81)), borderRadius: BorderRadius.circular(8)),
                 child: Text(isA ? 'Undo' : 'Approve', style: TextStyle(color: isA ? Colors.grey : const Color(0xFF0F4C81), fontSize: 11, fontWeight: FontWeight.bold)),
              )
           )
        )
     ];
  }
}
