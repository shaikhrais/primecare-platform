import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';
import 'psw_video_training_screen.dart';

class PswTrainingScreen extends StatelessWidget {
  PswTrainingScreen({super.key});

  final List<Map<String, dynamic>> _catalog = [
    {'id': 'v_1', 'title': 'Advanced CPR Recertification', 'status': 'Expiring in 14 Days', 'urgent': true, 'progress': 0.1},
    {'id': 'v_2', 'title': 'Dementia De-escalation Protocol', 'status': 'Mandatory (New)', 'urgent': true, 'progress': 0.0},
    {'id': 'v_3', 'title': 'Workplace Ergonomics', 'status': 'Completed', 'urgent': false, 'progress': 1.0},
  ];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
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
          child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Macro Ring Visualization
            PrimeCareCard(
              padding: EdgeInsets.all(32),
              
              child: PrimeCareRow(
                children: [
                   SizedBox(
                     width: 120, height: 120,
                     child: PrimeCareStack(
                       fit: StackFit.expand,
                       children: [
                         CircularProgressIndicator(
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
                   SizedBox(width: 32),
                   PrimeCareExpanded(
                     child: PrimeCareColumn(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         PrimeCareText('Global Compliance', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.5)),
                         SizedBox(height: 8),
                         PrimeCareText('2 Modules Pending Verification', style: TextStyle(color: PrimeCareColors.radarDark, fontSize: 18, fontWeight: FontWeight.w900, height: 1.3)),
                       ],
                     ),
                   )
                ],
              ),
            ),
            
            SizedBox(height: 32),
            PrimeCareText('REQUIRED MICRO-LEARNING', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
            SizedBox(height: 16),

            ..._catalog.map((course) {
              return PrimeCarePadding(
                padding: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PswVideoTrainingScreen(videoId: course['id'], title: course['title']))
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: PrimeCareCard(
                    padding: EdgeInsets.all(24),
                    
                    child: PrimeCareRow(
                      children: [
                        PrimeCareCard(
                          padding: EdgeInsets.all(12),
                          
                          child: PrimeCareIcon(course['progress'] == 1.0 ? Icons.check : Icons.play_arrow_rounded, color: course['progress'] == 1.0 ? Colors.white : PrimeCareColors.radarDark),
                        ),
                        SizedBox(width: 20),
                        PrimeCareExpanded(
                          child: PrimeCareColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimeCareText(course['title'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
                              SizedBox(height: 6),
                              PrimeCareText(course['status'], style: TextStyle(color: course['urgent'] ? PrimeCareColors.rose : PrimeCareColors.slate500, fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      )
        ),
      ),
    );
  }
}
