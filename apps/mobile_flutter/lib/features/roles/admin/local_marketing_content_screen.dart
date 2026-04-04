import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final localContentProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientLocalmarketingContent']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['content'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class LocalMarketingContentScreen extends ConsumerWidget {
  const LocalMarketingContentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(localContentProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Digital Content Stream'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Local Asset Library', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('New Asset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Content Output Stream Logs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No Local Content found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Creative Vector Index', 'Component Format Layout', 'Audit Publish Epochs'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['assetTitle'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildStatusPill(data['assetType'])),
                                          DataCell(Text('\${data["deployedDate"]}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
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
     Color bg = Colors.blueGrey;
     if (status == 'Print') bg = Colors.blue.shade700;
     if (status == 'Digital') bg = Colors.amber.shade700;

     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
        child: Text(status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
