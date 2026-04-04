import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final franchiseNetworkProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientFranchisemanNetwork']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['network'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FranchiseNetworkScreen extends ConsumerWidget {
  const FranchiseNetworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(franchiseNetworkProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Franchise Network Analytics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Geographic Clinic Operations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Topography', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Network Location Uplink Matrices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No network nodes active.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Location Mapping', 'Occupancy Flux', 'Staff Anchor', 'Server Load Telemetry', 'Endpoint Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       return [
                                          DataCell(Text(data['locationName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\${data["occupancyRate"]}%', style: const TextStyle(fontWeight: FontWeight.w800))),
                                          DataCell(Row(children: [const Icon(Icons.people, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text('\${data["staffActive"]}')])),
                                          DataCell(
                                             Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                   Container(width: 50 * (data['serverLoadScore']/100) as double, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.horizontal(left: Radius.circular(3)))),
                                                   Container(width: 50 * (1 - (data['serverLoadScore']/100)) as double, height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: const BorderRadius.horizontal(right: Radius.circular(3)))),
                                                ]
                                             )
                                          ),
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
     Color bg = Colors.green;
     if (status == 'Active') bg = Colors.blue.shade600;

     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
        child: Text(status.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
