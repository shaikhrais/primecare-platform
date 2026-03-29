import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final marketingContentProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/marketing/content'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['assets'] as List<dynamic>;
    } else {
      throw Exception('Failed to load assets');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class MarketingContentScreen extends ConsumerWidget {
  const MarketingContentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(marketingContentProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Digital Content CRM'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Brand Asset Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Upload Target', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            asyncData.when(
               data: (items) {
                  if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No assets deployed.')));
                  return PrimeResponsiveGrid(
                     desktopCrossAxisCount: 4,
                     desktopMainAxisExtent: 260,
                     children: items.map((data) => _buildAssetGridCard(data)).toList(),
                  );
               },
               loading: () => const Center(child: CircularProgressIndicator()),
               error: (e, st) => Center(child: Text('Error DB: $e')),
            )
          ]
        ),
      ),
    );
  }

  Widget _buildAssetGridCard(dynamic data) {
     return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Expanded(
                 flex: 3,
                 child: Container(
                    decoration: BoxDecoration(color: Colors.grey.shade200, image: DecorationImage(image: NetworkImage(data['thumbnailUrl'] ?? 'https://i.pravatar.cc/100'), fit: BoxFit.cover)),
                 )
              ),
              Expanded(
                 flex: 2,
                 child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                          Text(data['assetName'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                Row(
                                   children: [
                                      const Icon(Icons.style_outlined, size: 12, color: Colors.blueGrey),
                                      const SizedBox(width: 4),
                                      Text(data['assetType'], style: const TextStyle(color: Colors.black54, fontSize: 10)),
                                   ]
                                ),
                                _buildStatusPill(data['status']),
                             ]
                          )
                       ]
                    )
                 )
              )
           ]
        ),
     );
  }

  Widget _buildStatusPill(String status) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;

     if (status == 'Live') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     if (status == 'Review') { bg = Colors.orange.shade50; tx = Colors.deepOrange.shade800; }
     if (status == 'Draft') { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); }

     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 9, fontWeight: FontWeight.bold))
     );
  }
}
