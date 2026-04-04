import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final hrCandidatesProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientHrCandidates']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['candidates'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class HrCandidatePipelineScreen extends ConsumerStatefulWidget {
  const HrCandidatePipelineScreen({super.key});

  @override ConsumerState<HrCandidatePipelineScreen> createState() => _State();
}

class _State extends ConsumerState<HrCandidatePipelineScreen> {
  final Map<String, String> _localStatus = {};

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(hrCandidatesProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Candidate Pipeline'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Talent KanBan Board', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Export Board', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            SizedBox(
               height: 700,
               child: asyncData.when(
                  data: (items) {
                     return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           Expanded(child: _buildColumn('Screening', items.where((c) => (_localStatus[c['id']] ?? c['status']) == 'SCREENING').toList())),
                           const SizedBox(width: 16),
                           Expanded(child: _buildColumn('Shortlisted', items.where((c) => (_localStatus[c['id']] ?? c['status']) == 'SHORTLISTED').toList())),
                           const SizedBox(width: 16),
                           Expanded(child: _buildColumn('Interview', items.where((c) => (_localStatus[c['id']] ?? c['status']) == 'INTERVIEW').toList())),
                           const SizedBox(width: 16),
                           Expanded(child: _buildColumn('Offer', items.where((c) => (_localStatus[c['id']] ?? c['status']) == 'OFFER').toList())),
                        ]
                     );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error DB: $e')),
               )
            )
          ]
        ),
      ),
    );
  }

  Widget _buildColumn(String title, List<dynamic> items) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('${items.length}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))]),
              const SizedBox(height: 16),
              Expanded(
                 child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (c, i) => const SizedBox(height: 12),
                    itemBuilder: (c, i) => _buildCard(items[i]),
                 )
              )
           ]
        )
     );
  }

  Widget _buildCard(dynamic item) {
     final id = item['id'];
     final currentStat = _localStatus[id] ?? item['status'];
     
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.blueGrey.shade50.withOpacity(0.5), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(children: [const Icon(Icons.person, size: 16, color: Colors.grey), const SizedBox(width: 8), Text(item['candidateName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                    Row(children: List.generate(5, (index) => Icon(Icons.star, size: 12, color: index < item['rating'] ? Colors.amber : Colors.grey.shade300)))
                 ]
              ),
              const SizedBox(height: 8),
              Text(item['appliedRole'], style: const TextStyle(fontSize: 11, color: Color(0xFF0F4C81), fontWeight: FontWeight.bold)),
              Text(item['source'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 12),
              if (currentStat != 'OFFER')
                 InkWell(
                    onTap: () {
                       String next = 'SCREENING';
                       if (currentStat == 'SCREENING') next = 'SHORTLISTED';
                       else if (currentStat == 'SHORTLISTED') next = 'INTERVIEW';
                       else if (currentStat == 'INTERVIEW') next = 'OFFER';
                       setState(() { _localStatus[id] = next; });
                    },
                    child: Container(
                       width: double.infinity,
                       padding: const EdgeInsets.symmetric(vertical: 6),
                       decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(6)),
                       child: const Text('Advance Pipeline', textAlign: TextAlign.center, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 10)),
                    )
                 )
           ]
        )
     );
  }
}
