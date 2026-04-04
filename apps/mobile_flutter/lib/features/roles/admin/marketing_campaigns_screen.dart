import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final marketingCampaignsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientMarketingCampaigns']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['campaigns'] as List<dynamic>;
    } else {
      throw Exception('Failed to load campaigns');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class MarketingCampaignsScreen extends ConsumerWidget {
  const MarketingCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(marketingCampaignsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Return on Ad Spend Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Digital Campaigns Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export JSON', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Active Social & SEM Campaigns', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No campaigns tracked.')));
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Title', 'Platform', 'Budget Spend', 'Revenue Generated', 'ROAS', 'Leads', 'Status'],
                                    data: items,
                                    rowBuilder: (data) {
                                       double sp = (data['spend'] as num).toDouble();
                                       double rev = (data['revenue'] as num).toDouble();
                                       double roas = sp > 0 ? (rev / sp) : 0;
                                       return [
                                          DataCell(Text(data['campaignName'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(_buildPlatformPill(data['platform'])),
                                          DataCell(Text('\$\${(sp / 1000).toStringAsFixed(1)}K', style: const TextStyle(color: Colors.black54))),
                                          DataCell(Text('\$\${(rev / 1000).toStringAsFixed(1)}K', style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text('\${roas.toStringAsFixed(1)}x', style: TextStyle(fontWeight: FontWeight.bold, color: roas > 2 ? Colors.teal : Colors.deepOrange))),
                                          DataCell(Text('\${data["leads"]}')),
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

  Widget _buildPlatformPill(String plat) {
     return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           Icon(plat == 'Google Ads' ? Icons.search : plat == 'Email' ? Icons.email_outlined : Icons.thumb_up_alt_outlined, size: 14, color: Colors.blueGrey),
           const SizedBox(width: 8),
           Text(plat)
        ]
     );
  }

  Widget _buildStatusPill(String status) {
     Color bg = Colors.grey.shade200;
     Color tx = Colors.black54;
     if (status == 'Active') { bg = Colors.teal.shade50; tx = Colors.teal.shade800; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text(status.toUpperCase(), style: TextStyle(color: tx, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}
