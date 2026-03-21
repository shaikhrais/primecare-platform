import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
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
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText(
          'Compliance & Training', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareScrollWrapper(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Macro Ring Visualization
            PrimeCareCard(
              padding: const EdgeInsets.all(32),
              
              child: PrimeCareRow(
                children: [
                   PrimeCareSizedBox(
                     width: 120, height: 120,
                     child: PrimeCareStack(
                       fit: StackFit.expand,
                       children: [
                         const CircularProgressIndicator(
                           value: 0.85,
                           strokeWidth: 14,
                           backgroundColor: PrimeCareColors.slate200,
                           color: PrimeCareColors.emerald,
                           strokeCap: StrokeCap.round,
                         ),
                         PrimeCareCenter(
                           child: PrimeCareText('85%', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                         )
                       ],
                     ),
                   ),
                   const PrimeCareSizedBox(width: 32),
                   PrimeCareExpanded(
                     child: PrimeCareColumn(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const PrimeCareText('Global Compliance', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.5)),
                         const PrimeCareSizedBox(height: 8),
                         const PrimeCareText('2 Modules Pending Verification', style: TextStyle(color: PrimeCareColors.radarDark, fontSize: 18, fontWeight: FontWeight.w900, height: 1.3)),
                       ],
                     ),
                   )
                ],
              ),
            ),
            
            const PrimeCareSizedBox(height: 32),
            const PrimeCareText('REQUIRED MICRO-LEARNING', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
            const PrimeCareSizedBox(height: 16),

            ..._catalog.map((course) {
              return PrimeCarePadding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PswVideoTrainingScreen(videoId: course['id'], title: course['title']))
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: PrimeCareCard(
                    padding: const EdgeInsets.all(24),
                    
                    child: PrimeCareRow(
                      children: [
                        PrimeCareCard(
                          padding: const EdgeInsets.all(12),
                          
                          child: PrimeCareIcon(course['progress'] == 1.0 ? Icons.check : Icons.play_arrow_rounded, color: course['progress'] == 1.0 ? Colors.white : PrimeCareColors.radarDark),
                        ),
                        const PrimeCareSizedBox(width: 20),
                        PrimeCareExpanded(
                          child: PrimeCareColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimeCareText(course['title'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
                              const PrimeCareSizedBox(height: 6),
                              PrimeCareText(course['status'], style: TextStyle(color: course['urgent'] ? PrimeCareColors.rose : PrimeCareColors.slate500, fontSize: 13, fontWeight: FontWeight.bold)),
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
      )
        ),
      ),
    );
  }
}
