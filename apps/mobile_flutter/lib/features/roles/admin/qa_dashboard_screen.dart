import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QaDashboardScreen extends StatelessWidget {
  const QaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Quality Assurance'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Global Overview - Q3 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        const Icon(Icons.event_note, color: const Color(0xFF0F4C81)),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: const Color(0xFF0F4C81), size: 24)),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=1')),
                              const SizedBox(width: 12),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Dr. Eieanor Vance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), // Literal design typo (Eieanor)
                                    Text('(Administrator)', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                 ]
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.keyboard_arrow_down, size: 16),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Key Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All manaries', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])), // Literal typo
               ]
            ),
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 5,
               desktopMainAxisExtent: 120,
               children: [
                  _buildMetricCard('Avg. QA Score', '89.4%', '+2.1%', Colors.teal.shade50, Colors.black87, Colors.teal, false),
                  _buildMetricCard('Franchise Compliance', '92.1%', '+0.8%', Colors.blue.shade50, Colors.black87, Colors.teal, false),
                  _buildMetricCard('Active Audits', '34', 'Open', Colors.white, Colors.black87, const Color(0xFF0F4C81), false),
                  _buildMetricCard('Patient Satisfaction', '4.6/5', '', Colors.teal.shade700, Colors.white, Colors.transparent, false),
                  _buildMetricCard('Incident Reports', '18', 'Amber   -5%', Colors.amber.shade100, Colors.black87, Colors.orange.shade800, true),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 3,
               desktopMainAxisExtent: 360,
               children: [
                  _buildQualityPerformanceTrendsCard(),
                  _buildAuditStatusDistributionCard(),
                  _buildFranchisePerformanceLeaderboardTable(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildRecentComplianceIssuesTable(),
                  _buildUpcomingAuditsTable(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String val, String sub, Color bg, Color tx, Color subCol, bool isPill) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Text(title, style: TextStyle(fontSize: 12, color: tx)),
              const SizedBox(height: 8),
              Text(val, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: tx)),
              const SizedBox(height: 4),
              isPill 
                 ? PrimeCareResponsiveKpiGrid(
 children: [
                         Text(sub.split('   ')[0], style: TextStyle(color: subCol, fontSize: 11, fontWeight: FontWeight.bold)),
                         const SizedBox(width: 8),
                         Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.amber.shade200, borderRadius: BorderRadius.circular(4)), child: Text(sub.split('   ')[1], style: TextStyle(color: Colors.amber.shade900, fontSize: 10))),
                      ]
                   )
                 : Text(sub, style: TextStyle(color: subCol, fontWeight: sub.contains('%') ? FontWeight.bold : FontWeight.normal, fontSize: 11)),
           ]
        ),
     );
  }

  Widget _buildQualityPerformanceTrendsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Quality Performance Trends', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Scorts', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal
                 ]
              ),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 12, height: 2, color: const Color(0xFF0F4C81)), const SizedBox(width: 6), const Text('Avg. Score', style: TextStyle(fontSize: 11))]),
                    const SizedBox(width: 16),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 12, height: 2, color: Colors.teal.shade500), const SizedBox(width: 6), const Text('Compliance', style: TextStyle(fontSize: 11))]),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('100'), _ChartLineEmpty('90'), _ChartLineEmpty('80'), _ChartLineEmpty('70'), _ChartLineEmpty('60'), _ChartLineEmpty('50'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _QaTrendsPainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 10)), Text('Feb', style: TextStyle(fontSize: 10)), Text('Mar', style: TextStyle(fontSize: 10)), Text('Apr', style: TextStyle(fontSize: 10)), Text('May', style: TextStyle(fontSize: 10)), Text('6mn', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildAuditStatusDistributionCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Audit Status Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                          width: 160, height: 160,
                          child: CustomPaint(painter: _AuditPiePainter())
                       ),
                    ]
                 )
              ),
              const SizedBox(height: 16),
              Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Completed (62%)', style: TextStyle(fontSize: 11))]),
                    const SizedBox(height: 8),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('In Progress (23%)', style: TextStyle(fontSize: 11))]),
                    const SizedBox(height: 8),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade200, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Scheduled (15%)', style: TextStyle(fontSize: 11))]),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildFranchisePerformanceLeaderboardTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Franchise Performance Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Site Name', 'QA\nScore', 'Compliance\n%', 'Last Audit\nDate', 'Status'],
                    data: const [
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'm'}, // mint
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'm'},
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'm'},
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'y'}, // yellow typo
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'y'},
                       {'s': 'NY Clinic', 'q': '95%', 'c': '98%', 'd': 'Aug 12', 'st': 'High', 'bg': 'm'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['s']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['q']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['c']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildTableStatus(data['st']!, data['bg']!)),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildTableStatus(String txt, String bg) {
     final bool mint = bg == 'm';
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: mint ? Colors.teal.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(4)), // literal bounding box match
        child: Text(txt, style: TextStyle(color: mint ? Colors.teal.shade700 : Colors.orange.shade800, fontSize: 10))
     );
  }

  Widget _buildRecentComplianceIssuesTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Compliance Issues', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Setaits', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal typo
                 ]
              ),
              const SizedBox(height: 16),
             SizedBox(child: Stack(
                    children: [
                       PrimeCareDataTable<Map<String, String>>(
                          columns: const ['', 'Severity', 'Site', 'Type', 'Date', 'Action needed'], // First column empty for timeline
                          data: const [
                             {'sev': 'Severity', 's': 'NY Clinic', 't': 'Compliance', 'd': 'Aug 12', 'a': 'Action needed', 'c': 'r'},
                             {'sev': 'Severity', 's': 'NY Clinic', 't': 'Compliance', 'd': 'Aug 13', 'a': 'Action needed', 'c': 'r'},
                             {'sev': 'Severity', 's': 'Mealsinware', 't': 'Compliance', 'd': 'Aug 13', 'a': 'Action needed', 'c': 'o'}, // Typo literal
                             {'sev': 'Severity', 's': 'NY Clinic', 't': 'Compliance', 'd': 'Aug 13', 'a': 'Action needed', 'c': 'y'},
                             {'sev': 'Severity', 's': 'NY Clinic', 't': 'Type', 'd': 'Aug 12', 'a': 'Action needed', 'c': 'o'}, // Typo literal
                          ],
                          rowBuilder: (data) => [
                             const DataCell(SizedBox(width: 10)), // timeline spacer
                             DataCell(_buildSevPill(data['sev']!, data['c']!)),
                             DataCell(Text(data['s']!, style: const TextStyle(fontSize: 11))),
                             DataCell(Text(data['t']!, style: const TextStyle(fontSize: 11))),
                             DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                             DataCell(Text(data['a']!, style: const TextStyle(fontSize: 11))),
                          ],
                       ),
                       Positioned.fill(child: CustomPaint(painter: _TimelinePainter())),
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildSevPill(String t, String c) {
     Color bg = Colors.red.shade50;
     Color tx = Colors.red.shade800;
     if (c == 'o') { bg = Colors.orange.shade50; tx = Colors.orange.shade800; }
     if (c == 'y') { bg = Colors.amber.shade50; tx = Colors.amber.shade900; }
     
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(t, style: TextStyle(color: tx, fontSize: 10))
     );
  }

  Widget _buildUpcomingAuditsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Upcoming Audits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Staturs', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal typo
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Site', 'Date', 'Auditor', 'Status'],
                    data: const [
                       {'s': 'NY Clinic', 'd': 'Aug 12', 'a': 'Auditor', 'r': 'Status'},
                       {'s': 'NY Clinic', 'd': 'Aug 13', 'a': 'Auditor', 'r': 'Status'},
                       {'s': 'NY Clinic', 'd': 'Aug 12', 'a': 'Auditor', 'r': 'Status'},
                       {'s': 'NY Clinic', 'd': 'Aug 13', 'a': 'Auditor', 'r': 'Status'},
                       {'s': 'NY Clinic', 'd': 'Aug 14', 'a': 'Auditor', 'r': 'Status'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['s']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['a']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildAuditStatusPill(data['r']!)),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildAuditStatusPill(String s) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
        child: Text(s, style: const TextStyle(color: Color(0xFF0F4C81), fontSize: 10))
     );
  }
}

class _TimelinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final p = Paint()..color = Colors.teal.shade500..strokeWidth = 2..style = PaintingStyle.stroke;
      final pb = Paint()..color = Colors.white..style = PaintingStyle.fill;
      
      final cx = 15.0; // Alignment to the first column
      final rowCount = 5;
      final dy = size.height / (rowCount + 1); // Skip header approx

      final path = Path();
      path.moveTo(cx, dy * 1.5);
      path.lineTo(cx, dy * (rowCount + 0.5));
      
      canvas.drawPath(path, p);
      
      for(int i=1; i<=rowCount; i++) {
         canvas.drawCircle(Offset(cx, dy * (i + 0.5)), 4, pb); // white inner
         canvas.drawCircle(Offset(cx, dy * (i + 0.5)), 4, p); // border
      }
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QaTrendsPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 2..style = PaintingStyle.stroke;
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 2..style = PaintingStyle.stroke;
      
      final fillT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade100.withOpacity(0.4), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final ptsDB = [0.8, 0.9, 0.75, 0.95, 0.85, 0.98]; // Jan - 6mn
      final ptsT = [0.6, 0.8, 0.7, 0.85, 0.8, 0.9];
      
      final w = size.width / 5;
      
      // Draw bottom shaded area + nodes
      final pT = Path();
      pT.moveTo(0, size.height * (1 - ptsT[0]));
      
      for(int i=1; i<6; i++) {
         pT.lineTo(w * i, size.height * (1 - ptsT[i])); // sharp lines
      }
      
      final fT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(fT, fillT);
      canvas.drawPath(pT, paintT);
      
      final pDB = Path();
      pDB.moveTo(0, size.height * (1 - ptsDB[0]));
      for(int i=1; i<6; i++) {
         pDB.lineTo(w * i, size.height * (1 - ptsDB[i])); // sharp lines
      }
      canvas.drawPath(pDB, paintDB);
      
      // Draw nodes
      final pW = Paint()..color = Colors.white..style = PaintingStyle.fill;
      for(int i=0; i<6; i++) {
         canvas.drawCircle(Offset(w * i, size.height * (1 - ptsDB[i])), 4, pW);
         canvas.drawCircle(Offset(w * i, size.height * (1 - ptsDB[i])), 4, paintDB);
         
         canvas.drawCircle(Offset(w * i, size.height * (1 - ptsT[i])), 4, pW);
         canvas.drawCircle(Offset(w * i, size.height * (1 - ptsT[i])), 4, paintT);
      }
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AuditPiePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 32;
      final paintT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 32;
      final paintLT = Paint()..color = Colors.teal.shade200..style = PaintingStyle.stroke..strokeWidth = 32;
      
      final rect = Rect.fromCircle(center: center, radius: radius - 16);
      
      const double pi2 = 3.14159 * 2;
      
      final startDB = -3.14159 / 2;
      final sweepDB = pi2 * 0.62;
      
      final startT = startDB + sweepDB;
      final sweepT = pi2 * 0.23;
      
      final startLT = startT + sweepT;
      final sweepLT = pi2 * 0.15;
      
      // Spaced lines in pie logic require gap offsets
      final gap = 0.05;
      
      canvas.drawArc(rect, startDB + gap, sweepDB - gap, false, paintDB);
      canvas.drawArc(rect, startT + gap, sweepT - gap, false, paintT);
      canvas.drawArc(rect, startLT + gap, sweepLT - gap, false, paintLT);
   }
   
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 24, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            SizedBox(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
