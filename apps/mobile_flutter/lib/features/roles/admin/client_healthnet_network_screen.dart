import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final healthnetNetworkProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/healthnet/network'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['networkStats'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClientHealthnetNetworkScreen extends ConsumerWidget {
  const ClientHealthnetNetworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(healthnetNetworkProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Geographic Network Overview'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Clinic Cluster Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Refresh Ping', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Regional Connectivity Layers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No nodes found.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Geographic Region Axis', 'Node Clusters (Clinics)', 'Density Baseline'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['regionName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(
                                             Row(
                                                children: [
                                                   const Icon(Icons.share_location, color: Colors.blueGrey, size: 14),
                                                   const SizedBox(width: 8),
                                                   Text('${data["clinicCount"]} Active Nodes', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                                                ]
                                             )
                                          ),
                                          DataCell(Text('${data["demographicCat"]}', style: const TextStyle(color: Colors.black54))),
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
}
