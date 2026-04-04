import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final hrInterviewsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientHrInterviews']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['interviews'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class HrInterviewsScheduleScreen extends ConsumerWidget {
  const HrInterviewsScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(hrInterviewsProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Interview Timetables'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Daily Scheduling Route', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Book Internal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
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
                        const Text('Scheduled Calls Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (items) {
                                 if (items.isEmpty) return const PrimeCareCard(child: Center(child: Text('No daily schedules.')));
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
                        const Text('Manager Calendar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: PrimeCareCard(child: const Center(child: Text('Calendar Graphic Interface Mode', style: TextStyle(color: Colors.grey))))
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
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                 decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
                 child: Column(
                    children: [
                       const Icon(Icons.groups, color: Colors.amber),
                       const SizedBox(height: 4),
                       Text(t['scheduledTime'], style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold)),
                    ]
                 )
              ),
              const SizedBox(width: 16),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(t['candidateName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                       Text('Hiring Manager: ${t["managerName"]} (${t["roleTarget"]})', style: const TextStyle(color: Colors.black54, fontSize: 11)),
                    ]
                 )
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(16)),
                 child: const Text('Join Video', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
              )
           ]
        )
     );
  }
}
