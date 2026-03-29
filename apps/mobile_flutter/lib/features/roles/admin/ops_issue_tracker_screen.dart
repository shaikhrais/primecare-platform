import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final opsIssuesProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/ops/issues'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['issues'] as List<dynamic>;
    } else {
      throw Exception('Failed to load issues');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class OpsIssueTrackerScreen extends ConsumerStatefulWidget {
  const OpsIssueTrackerScreen({super.key});

  @override
  ConsumerState<OpsIssueTrackerScreen> createState() => _OpsIssueTrackerScreenState();
}

class _OpsIssueTrackerScreenState extends ConsumerState<OpsIssueTrackerScreen> {
  Future<void> _updateIssueStatus(String id, String newStatus) async {
     try {
        final res = await http.put(
           Uri.parse('http://127.0.0.1:8787/v1/client/ops/issues/\$id'),
           headers: {'Content-Type': 'application/json'},
           body: jsonEncode({'status': newStatus})
        );
        if (res.statusCode == 200) {
           ref.invalidate(opsIssuesProvider);
        }
     } catch (e) {
        debugPrint('Drag update failed: \$e');
     }
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(opsIssuesProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Issues Triage KanBan'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Operations Ticketing Triage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Ticket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            Expanded(
               child: asyncData.when(
                  data: (items) {
                     final reported = items.where((i) => i['status'] == 'Reported').toList();
                     final dispatched = items.where((i) => i['status'] == 'Dispatched').toList();
                     final resolved = items.where((i) => i['status'] == 'Resolved').toList();
                     
                     return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           Expanded(child: _KanBanColumn('Reported', reported, (id) => _updateIssueStatus(id, 'Reported'))),
                           const SizedBox(width: 16),
                           Expanded(child: _KanBanColumn('Dispatched', dispatched, (id) => _updateIssueStatus(id, 'Dispatched'))),
                           const SizedBox(width: 16),
                           Expanded(child: _KanBanColumn('Resolved', resolved, (id) => _updateIssueStatus(id, 'Resolved'))),
                        ]
                     );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: \$e')),
               )
            ),
          ]
        ),
      ),
    );
  }
}

class _KanBanColumn extends StatelessWidget {
   final String title;
   final List<dynamic> items;
   final Function(String) onDrop;
   const _KanBanColumn(this.title, this.items, this.onDrop);

   @override
   Widget build(BuildContext context) {
      return DragTarget<String>(
         onAcceptWithDetails: (details) => onDrop(details.data),
         builder: (context, candidateData, rejectedData) {
            return Container(
               decoration: BoxDecoration(
                  color: candidateData.isNotEmpty ? Colors.blue.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200)
               ),
               padding: const EdgeInsets.all(16),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Text('\$title (\${items.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                     const SizedBox(height: 16),
                     Expanded(
                        child: ListView.separated(
                           itemCount: items.length,
                           separatorBuilder: (_, __) => const SizedBox(height: 12),
                           itemBuilder: (context, index) {
                              final it = items[index];
                              return LongPressDraggable<String>(
                                 data: it['id'],
                                 feedback: Material(elevation: 4, child: SizedBox(width: 300, child: _KanBanCard(it))),
                                 childWhenDragging: Opacity(opacity: 0.3, child: _KanBanCard(it)),
                                 child: _KanBanCard(it),
                              );
                           }
                        )
                     )
                  ]
               )
            );
         }
      );
   }
}

class _KanBanCard extends StatelessWidget {
   final dynamic item;
   const _KanBanCard(this.item);

   @override
   Widget build(BuildContext context) {
      Color bg = Colors.grey.shade100;
      Color tx = Colors.black;
      if (item['severity'] == 'Critical') { bg = Colors.red.shade50; tx = Colors.red.shade900; }
      else if (item['severity'] == 'High') { bg = Colors.orange.shade50; tx = Colors.orange.shade900; }
      
      return Container(
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
         ),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
                  child: Text(item['severity'].toUpperCase(), style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
               ),
               const SizedBox(height: 8),
               Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
               const SizedBox(height: 4),
               Text(item['facilityName'], style: const TextStyle(color: Colors.black54, fontSize: 12)),
               const SizedBox(height: 8),
               Text(item['createdAt'].toString().substring(0, 10), style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ]
         )
      );
   }
}
