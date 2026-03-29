import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final marketingAnalyticsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/marketing/analytics'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['analytics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load analytics');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class MarketingAnalyticsScreen extends ConsumerWidget {
  const MarketingAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(marketingAnalyticsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Geographic Growth Analytics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Local Territory Heatmap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Refresh Cache', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Patient Acquisition Maps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No maps available.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Geographic Area', 'New Patients Logged', 'Cost Per Acquisition (CPA)', 'Gross Local Revenue'],
                                    data: items,
                                    rowBuilder: (data) {
                                       double cpa = (data['patientAcqCost'] as num).toDouble();
                                       double rev = (data['totalRevenue'] as num).toDouble();
                                       return [
                                          DataCell(Row(children: [const Icon(Icons.location_on_outlined, size: 14, color: Colors.blueGrey), const SizedBox(width: 8), Text(data['regionName'], style: const TextStyle(fontWeight: FontWeight.bold))])),
                                          DataCell(Text('\${data["newPatients"]}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                                          DataCell(Text('\$\${cpa.toStringAsFixed(2)}', style: TextStyle(color: cpa > 100 ? Colors.red : Colors.teal, fontWeight: FontWeight.bold))),
                                          DataCell(Text('\$\${(rev / 1000000).toStringAsFixed(1)}M', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87))),
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
