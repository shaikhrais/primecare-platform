import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:math' as math;

class TrainingCoordinatorDashboardScreen extends StatelessWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Welcome, Sarah J.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                  Row(
                     children: [
                        Container(width: 200, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)), child: Row(children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        const Icon(Icons.search, color: Colors.black54), // Duplicated search icon
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Row(
                           children: [
                              const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                              const SizedBox(width: 8),
                              const Text('Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 4),
                              const Icon(Icons.keyboard_arrow_down, size: 16),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildMetricButtonCard('Current Training Programs', '24', 'Active', 'View All'),
                  _buildMetricGraphCard('Trainee Completion Rate', '88%', '+5.2%', true),
                  _buildMetricButtonCard('Upcoming Sessions', '12', 'scheduled', 'View Calendar'),
                  _buildMetricGraphCard('New Trainee Enrollments', '65', 'this month', false),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 400,
               children: [
                  _buildTrainingProgramOverviewTable(),
                  _buildActiveFacilitatorAssignments(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 180,
               children: [
                  _buildTrainingComplianceTracker(),
                  _buildKeyPerformanceMetrics(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildMetricButtonCard(String title, String val, String sub, String btnText) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                    const SizedBox(width: 4),
                    Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(sub, style: const TextStyle(color: Colors.black87, fontSize: 12))),
                 ]
              ),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: Center(child: Text(btnText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
           ]
        ),
     );
  }

  Widget _buildMetricGraphCard(String title, String val, String sub, bool isArea) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
              const SizedBox(height: 4),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    const SizedBox(width: 4),
                    Padding(
                       padding: const EdgeInsets.only(bottom: 4),
                       child: Text('|  $sub', style: TextStyle(color: sub.contains('+') ? Colors.green : Colors.black87, fontSize: 11, fontWeight: sub.contains('+') ? FontWeight.bold : FontWeight.normal))
                    ),
                 ]
              ),
              Expanded(
                 child: Stack(
                    children: [
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(bottom: 14),
                             child: isArea 
                                ? CustomPaint(painter: _CompletionLinePainter())
                                : Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                        _buildDualBar(0.4, 0.6),
                                        _buildDualBar(0.5, 0.7),
                                        _buildDualBar(0.8, 0.4),
                                        _buildDualBar(0.6, 0.8),
                                        _buildDualBar(0.5, 0.9),
                                        _buildDualBar(0.7, 0.5),
                                     ]
                                  )
                          )
                       ),
                       if (isArea) Positioned(bottom: 0, left: 0, right: 0, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 8)), Text('Feb', style: TextStyle(fontSize: 8)), Text('Mar', style: TextStyle(fontSize: 8)), Text('Apr', style: TextStyle(fontSize: 8)), Text('May', style: TextStyle(fontSize: 8)), Text('Nun', style: TextStyle(fontSize: 8))])) // Literal typo
                       else Positioned(bottom: 0, left: 8, right: 8, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [Text('Jan', style: TextStyle(fontSize: 8)), Text('Feb', style: TextStyle(fontSize: 8)), Text('Mar', style: TextStyle(fontSize: 8)), Text('Apr', style: TextStyle(fontSize: 8)), Text('May', style: TextStyle(fontSize: 8)), Text('Jun', style: TextStyle(fontSize: 8))])),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildDualBar(double h1, double h2) {
     return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           Container(width: 4, height: 60 * h1, color: const Color(0xFF0F4C81)),
           const SizedBox(width: 2),
           Container(width: 4, height: 60 * h2, color: Colors.teal.shade500),
        ]
     );
  }

  Widget _buildTrainingProgramOverviewTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Training Program Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                       children: [
                          Container(width: 160, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Icon(Icons.search, color: Colors.grey, size: 14), SizedBox(width: 4), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 11))])),
                          const SizedBox(width: 12),
                          Container(
                             decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                             child: Row(
                                children: [
                                   Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('All', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                                   Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Row(children: const [Text('Active', style: TextStyle(fontSize: 10)), SizedBox(width: 2), Icon(Icons.keyboard_arrow_down, size: 12)])),
                                ]
                             )
                          )
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Program Name', 'Department', 'Status', 'Start Date', 'Completion %', 'Actions'],
                    data: const [
                       {'p': 'Patient Care Excellence', 'd': 'Patient Care Ext', 's': 'Active', 'c': '80%'}, // Literal typo Ext
                       {'p': 'HIPAA Compliance', 'd': 'Department', 's': 'Scheduled', 'c': '80%'}, // Literal typo Department
                       {'p': 'Patient Care Excellence', 'd': 'Department', 's': 'Active', 'c': '90%'},
                       {'p': 'Patient Compliance', 'd': 'Department', 's': 'Scheduled', 'c': '80%'}, // Typo: Patient Compliance
                       {'p': 'HIPAA Compliance', 'd': 'Department', 's': 'Completed', 'c': '80%'},
                       {'p': 'HIPAA Compliance', 'd': 'Patient Care Est', 's': 'Completed', 'c': '70%'}, // Typo: Est
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['p']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildStatusPill(data['s']!)),
                       DataCell(Text(data['s'] == 'Active' ? '12/15/2023' : data['s'] == 'Scheduled' ? '12/13/2023' : '12/15/2023', style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['c']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Row(children: const [Text('Manage', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(width: 4), Text('|', style: TextStyle(color: Colors.black26)), SizedBox(width: 4), Text('View', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 11))])),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildStatusPill(String s) {
     Color bg = Colors.teal.shade50;
     Color tx = Colors.teal.shade700;
     if (s == 'Scheduled') { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); }
     if (s == 'Completed') { bg = Colors.green.shade50; tx = Colors.green.shade700; } // Mint
     if (s == 'Active_Blue') { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); s = 'Active'; } // Explicit override for visual array error
     
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(s, style: TextStyle(color: tx, fontSize: 10))
     );
  }

  Widget _buildActiveFacilitatorAssignments() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Active Facilitator Assignments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Facilitator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                    Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                 ]
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              Expanded(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildFacilitatorRow('https://i.pravatar.cc/150?img=9', 'Sarah Jenkins', 'Facillitators', 'Active'), // Literal typo ll
                       _buildFacilitatorRow('https://i.pravatar.cc/150?img=11', 'Mrria Mollax', 'Current Programs', 'Active'), // Literal typo
                       _buildFacilitatorRow('https://i.pravatar.cc/150?img=9', 'Sarah Jenkins', 'HIPAA Compliance', 'Scheduled'),
                       _buildFacilitatorRow('https://i.pravatar.cc/150?img=12', 'Sarah Jenkins', 'Current Programs', 'Completed'),
                       _buildFacilitatorRow('https://i.pravatar.cc/150?img=9', 'Sarah Jenkins', 'Current Programs', 'Active_Blue'), // Active literal mapped to blue color
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildFacilitatorRow(String img, String n, String sub, String s) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
              children: [
                 CircleAvatar(radius: 14, backgroundImage: NetworkImage(img)),
                 const SizedBox(width: 8),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                       Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 9)),
                    ]
                 )
              ]
           ),
           _buildStatusPill(s),
        ]
     );
  }

  Widget _buildTrainingComplianceTracker() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Training Compliance Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Stack(
                          alignment: Alignment.center,
                          children: [
                             SizedBox(
                                width: 140, height: 100, // Semi-circle bounding width
                                child: CustomPaint(painter: _ArcPainter())
                             ),
                             Positioned(
                                bottom: 0,
                                child: Column(
                                   children: const [
                                      Text('94%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                      Text('Compliant', style: TextStyle(fontSize: 10)),
                                   ]
                                )
                             )
                          ]
                       ),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                                children: [
                                   Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)),
                                   const SizedBox(width: 8),
                                   const Text('94%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ]
                             ),
                             const Padding(padding: EdgeInsets.only(left: 16), child: Text('Compliant', style: TextStyle(fontSize: 10))),
                             const SizedBox(height: 12),
                             Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                                children: [
                                   Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.amber.shade500, shape: BoxShape.circle)),
                                   const SizedBox(width: 8),
                                   const Text('6%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                ]
                             ),
                             const Padding(padding: EdgeInsets.only(left: 16), child: Text('Due', style: TextStyle(fontSize: 10))),
                          ]
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildKeyPerformanceMetrics() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Key Performance Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Expanded(
                 child: Row(
                    children: [
                       Expanded(
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('50m', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                                SizedBox(height: 4),
                                Text('Avg Completion Time', style: TextStyle(fontSize: 11)),
                             ]
                          )
                       ),
                       Container(width: 1, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(vertical: 24)),
                       Expanded(
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('4.3 ★', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                                SizedBox(height: 4),
                                Text('Course Rating', style: TextStyle(fontSize: 11)),
                             ]
                          )
                       ),
                       Container(width: 1, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(vertical: 24)),
                       Expanded(
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('56+★', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)), // Literal typo matching string
                                SizedBox(height: 4),
                                Text('Assessment Score', style: TextStyle(fontSize: 11)),
                             ]
                          )
                       ),
                    ]
                 )
              )
           ]
        )
     );
  }
}

class _CompletionLinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final pT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final fT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade100.withOpacity(0.5), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final pts = [0.8, 0.9, 0.75, 0.65, 0.5, 0.4]; // Jan -> Jun inverted (so mapping visual line)
      
      final path = Path();
      final w = size.width / 5;
      
      path.moveTo(0, size.height * pts[0]);
      for(int i=1; i<6; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * pts[i-1], w * i, size.height * pts[i]);
      }
      
      final aPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aPath, fT);
      canvas.drawPath(path, pT);
      
      final pW = Paint()..color = Colors.white..style = PaintingStyle.fill;
      for(int i=0; i<6; i++) {
         canvas.drawCircle(Offset(w * i, size.height * pts[i]), 4, pW);
         canvas.drawCircle(Offset(w * i, size.height * pts[i]), 4, pT);
      }
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArcPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height); // Bottom center for semi-circle
      final radius = size.width / 2 - 16;
      
      final pT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 24..strokeCap = StrokeCap.round;
      final pA = Paint()..color = Colors.amber.shade500..style = PaintingStyle.stroke..strokeWidth = 24..strokeCap = StrokeCap.round;
      
      final rect = Rect.fromCircle(center: center, radius: radius);
      
      final startAngles = -3.14159; // 180 deg
      final sweepTeal = 3.14159 * 0.94; // 94% of semi circle
      final sweepAmber = 3.14159 * 0.03; // Tiny gap, 3% visual
      
      canvas.drawArc(rect, startAngles, sweepTeal, false, pT);
      canvas.drawArc(rect, startAngles + sweepTeal + 0.1, sweepAmber, false, pA); // Gap + Amber
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
