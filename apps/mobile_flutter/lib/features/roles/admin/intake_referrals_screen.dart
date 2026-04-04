import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final intakeReferralsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientIntakeReferrals']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['referrals'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class IntakeReferralsScreen extends ConsumerWidget {
  const IntakeReferralsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(intakeReferralsProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Referral Analytics Hub'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Lead Source Tracking Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Network Sources vs Real Conversions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: PrimeCareCard(
                              child: asyncData.when(
                                 data: (refs) {
                                    if (refs.isEmpty) return const Center(child: Text('Empty Referrals Database'));
                                    double maxVal = 1;
                                    for(var r in refs) {
                                       if(r['totalLeads'] > maxVal) maxVal = r['totalLeads'].toDouble();
                                    }
                                    return Row(
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: refs.map((r) => _buildBar(r, maxVal)).toList(),
                                    );
                                 },
                                 loading: () => const Center(child: CircularProgressIndicator()),
                                 error: (e, st) => Center(child: Text('Error DB: $e')),
                              )
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

  Widget _buildBar(dynamic r, double maxVal) {
     final cName = r['sourceName'];
     final leads = r['totalLeads'];
     final convs = r['conversionCount'];
     final h1 = (leads / maxVal);
     final h2 = (convs / leads);

     return Expanded(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
              Text('Leads: $leads', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              Flexible(
                 child: LayoutBuilder(
                    builder: (context, c) {
                       return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                             Container(
                                width: 60,
                                height: c.maxHeight * h1,
                                decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
                             ),
                             Container(
                                width: 60,
                                height: c.maxHeight * h1 * h2,
                                decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
                             ),
                          ]
                       );
                    }
                 )
              ),
              const SizedBox(height: 16),
              Text(cName, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
              Text('${(h2 * 100).toInt()}% Conv', style: const TextStyle(fontSize: 10, color: Colors.teal)),
              const SizedBox(height: 24),
           ]
        ),
     );
  }
}
