import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final bdDealsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientBdDeals']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['deals'] as List<dynamic>;
    } else {
      throw Exception('Failed to load deals');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class BdDealsScreen extends ConsumerStatefulWidget {
  const BdDealsScreen({super.key});

  @override
  ConsumerState<BdDealsScreen> createState() => _BdDealsScreenState();
}

class _BdDealsScreenState extends ConsumerState<BdDealsScreen> {
  Future<void> _updateDealStage(String id, String newStage) async {
     try {
        final res = await http.put(
           Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientBdDeals']}/\$id'),
           headers: {'Content-Type': 'application/json'},
           body: jsonEncode({'stage': newStage})
        );
        if (res.statusCode == 200) {
           ref.invalidate(bdDealsProvider);
        }
     } catch (e) {
        debugPrint('Drag update failed: \$e');
     }
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(bdDealsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Sales Deal Pipeline'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Enterprise Franchise Acquisitions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Lead', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            Expanded(
               child: asyncData.when(
                  data: (items) {
                     final discovery = items.where((i) => i['stage'] == 'Discovery').toList();
                     final eval = items.where((i) => i['stage'] == 'Evaluation').toList();
                     final proposal = items.where((i) => i['stage'] == 'Proposal').toList();
                     final closed = items.where((i) => i['stage'] == 'Closed Won').toList();
                     
                     return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           Expanded(child: _KanBanColumn('Discovery', discovery, (id) => _updateDealStage(id, 'Discovery'))),
                           const SizedBox(width: 16),
                           Expanded(child: _KanBanColumn('Evaluation', eval, (id) => _updateDealStage(id, 'Evaluation'))),
                           const SizedBox(width: 16),
                           Expanded(child: _KanBanColumn('Proposal', proposal, (id) => _updateDealStage(id, 'Proposal'))),
                           const SizedBox(width: 16),
                           Expanded(child: _KanBanColumn('Closed Won', closed, (id) => _updateDealStage(id, 'Closed Won'))),
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
      double totalVal = items.fold(0.0, (sum, i) => sum + (i['amount'] as num).toDouble());
      String formattedVal = '\${(totalVal / 1000000).toStringAsFixed(1)}M';

      return DragTarget<String>(
         onAcceptWithDetails: (details) => onDrop(details.data),
         builder: (context, candidateData, rejectedData) {
            return Container(
               decoration: BoxDecoration(
                  color: candidateData.isNotEmpty ? Colors.teal.shade50.withOpacity(0.5) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200)
               ),
               padding: const EdgeInsets.all(16),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Text(items.length.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))
                        ]
                     ),
                     const SizedBox(height: 8),
                     Text('\$\$formattedVal', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF0F4C81))),
                     const SizedBox(height: 16),
                     Expanded(
                        child: ListView.separated(
                           itemCount: items.length,
                           separatorBuilder: (_, __) => const SizedBox(height: 12),
                           itemBuilder: (context, index) {
                              final it = items[index];
                              return LongPressDraggable<String>(
                                 data: it['id'],
                                 feedback: Material(elevation: 4, child: SizedBox(width: 280, child: _KanBanCard(it))),
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
      String formattedVal = '\${((item["amount"] as num) / 1000000).toStringAsFixed(2)}M';

      return Container(
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade100),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
         ),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(item['facilityTarget'], style: const TextStyle(color: Colors.black54, fontSize: 11)),
                     const Icon(Icons.more_horiz, size: 14, color: Colors.grey)
                  ]
               ),
               const SizedBox(height: 8),
               Text(item['dealName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
               const SizedBox(height: 12),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text('\$\$formattedVal', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 14)),
                     Row(children: [const Icon(Icons.person_outline, size: 12, color: Colors.grey), const SizedBox(width: 4), Text(item['repName'], style: const TextStyle(fontSize: 10, color: Colors.black54))])
                  ]
               )
            ]
         )
      );
   }
}
