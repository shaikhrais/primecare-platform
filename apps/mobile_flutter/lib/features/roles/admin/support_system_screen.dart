import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final supportSystemProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/support/system'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['telemetry'] as List<dynamic>;
    } else {
      throw Exception('Failed to load DB');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class SupportSystemScreen extends ConsumerWidget {
  const SupportSystemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(supportSystemProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark Mode Theme
      appBar: AppBar(
         title: const Text('Network Ops Telemetry', style: TextStyle(color: Colors.white)),
         backgroundColor: Colors.black87,
         iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Theme(
          data: ThemeData.dark(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Enterprise Node Health (NOC)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                    Container(
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                       decoration: BoxDecoration(color: Colors.cyan.shade900, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.cyan)), 
                       child: const Text('Diagnostic Trace', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 13))
                    )
                 ]
              ),
              const SizedBox(height: 32),
              PrimeResponsiveGrid(
                 desktopMainAxisExtent: 500,
                 desktopCrossAxisCount: 1,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                          const Text('Live Connection Uptime Log', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
                          const SizedBox(height: 16),
                          Expanded(
                             child: asyncData.when(
                                data: (items) {
                                   if (items.isEmpty) return const Center(child: Text('No telemetry tracked.'));
                                   return ListView.separated(
                                      itemCount: items.length,
                                      separatorBuilder: (_, __) => const Divider(color: Colors.white12),
                                      itemBuilder: (ctx, index) {
                                         final data = items[index];
                                         return Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(color: Colors.black26, border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)),
                                            child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                  Row(
                                                     children: [
                                                        Icon(Icons.hub, color: data['status'] == 'Operational' ? Colors.cyanAccent : Colors.orangeAccent),
                                                        const SizedBox(width: 16),
                                                        Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                              Text(data['serviceName'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                                                              const SizedBox(height: 4),
                                                              Text('Ping Latency: \${data["latencyMs"]} ms', style: const TextStyle(color: Colors.grey))
                                                           ]
                                                        )
                                                     ]
                                                  ),
                                                  Column(
                                                     crossAxisAlignment: CrossAxisAlignment.end,
                                                     children: [
                                                        Text('\${data["uptimePercent"]}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: data['uptimePercent'] > 99 ? Colors.greenAccent : Colors.orangeAccent)),
                                                        const SizedBox(height: 4),
                                                        Text(data['status'].toUpperCase(), style: TextStyle(color: data['status'] == 'Operational' ? Colors.cyan : Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold))
                                                     ]
                                                  )
                                               ]
                                            ),
                                         );
                                      }
                                   );
                                },
                                loading: () => const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
                                error: (e, st) => Center(child: Text('Error NOC DB: $e', style: const TextStyle(color: Colors.redAccent))),
                             )
                          )
                       ]
                    ),
                 ]
              ),
            ]
          ),
        ),
      ),
    );
  }
}
