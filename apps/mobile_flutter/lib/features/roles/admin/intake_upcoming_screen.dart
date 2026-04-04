import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final intakeUpcomingProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientIntakeUpcoming']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['upcomings'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class IntakeUpcomingScreen extends ConsumerWidget {
  const IntakeUpcomingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(intakeUpcomingProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Upcoming Intakes Pipeline'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Scheduled RN Consults', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Consult', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 600,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Pipeline Block: Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No upcoming calls logged.')));
                                 return ListView.separated(
                                    itemCount: items.length,
                                    separatorBuilder: (c, i) => const SizedBox(height: 16),
                                    itemBuilder: (c, i) => _buildItem(items[i]),
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error DB: $e')),
                           )
                        )
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Coordinator RN Shift Roster', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: PrimeCareCard(child: const Center(child: Text('Calendar Visualization Mock UI', style: TextStyle(color: Colors.grey))))
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

  Widget _buildItem(dynamic t) {
     return PrimeCareCard(
        child: Row(
           children: [
              Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
                 child: Column(
                    children: [
                       const Icon(Icons.phone_callback, color: Colors.teal),
                       const SizedBox(height: 4),
                       Text(t['scheduledTime'], style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    ]
                 )
              ),
              const SizedBox(width: 16),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(t['patientName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                       Text('Location Base: ${t["franchiseCity"]}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
                    ]
                 )
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(16)),
                 child: const Text('Dial Out', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 11)),
              )
           ]
        )
     );
  }
}
