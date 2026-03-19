import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'psw_video_training_screen.dart';

class PswTrainingScreen extends StatelessWidget {
  const PswTrainingScreen({super.key});

  final List<Map<String, dynamic>> _catalog = const [
    {'id': 'v_1', 'title': 'Advanced CPR Recertification', 'status': 'Expiring in 14 Days', 'urgent': true, 'progress': 0.1},
    {'id': 'v_2', 'title': 'Dementia De-escalation Protocol', 'status': 'Mandatory (New)', 'urgent': true, 'progress': 0.0},
    {'id': 'v_3', 'title': 'Workplace Ergonomics', 'status': 'Completed', 'urgent': false, 'progress': 1.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Compliance & Training', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Macro Ring Visualization
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: Row(
                children: [
                   SizedBox(
                     width: 120, height: 120,
                     child: Stack(
                       fit: StackFit.expand,
                       children: [
                         const CircularProgressIndicator(
                           value: 0.85,
                           strokeWidth: 14,
                           backgroundColor: Color(0xFFE2E8F0),
                           color: Color(0xFF10B981),
                           strokeCap: StrokeCap.round,
                         ),
                         Center(
                           child: Text('85%', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                         )
                       ],
                     ),
                   ),
                   const SizedBox(width: 32),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text('Global Compliance', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.5)),
                         const SizedBox(height: 8),
                         const Text('2 Modules Pending Verification', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.w900, height: 1.3)),
                       ],
                     ),
                   )
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text('REQUIRED MICRO-LEARNING', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 16),

            ..._catalog.map((course) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PswVideoTrainingScreen(videoId: course['id'], title: course['title']))
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: course['urgent'] ? const Color(0xFFE11D48) : const Color(0xFFE2E8F0), width: course['urgent'] ? 2 : 1),
                      boxShadow: course['urgent'] ? const [BoxShadow(color: Color(0x11E11D48), blurRadius: 16, offset: Offset(0, 4))] : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: course['progress'] == 1.0 ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(course['progress'] == 1.0 ? Icons.check : Icons.play_arrow_rounded, color: course['progress'] == 1.0 ? Colors.white : const Color(0xFF0F172A)),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(course['title'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF0F172A))),
                              const SizedBox(height: 6),
                              Text(course['status'], style: TextStyle(color: course['urgent'] ? const Color(0xFFE11D48) : const Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
