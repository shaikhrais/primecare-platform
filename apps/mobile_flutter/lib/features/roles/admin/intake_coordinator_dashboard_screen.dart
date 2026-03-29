import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IntakeCoordinatorDashboardScreen extends StatelessWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Franchise Intake'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                  PrimeCareResponsiveKpiGrid(
 children: const [
                        Text('Franchise Intake', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        SizedBox(width: 8),
                        Text('|', style: TextStyle(color: Colors.black26, fontSize: 24)),
                        SizedBox(width: 8),
                        Text('Welcome, Sarah J.', style: TextStyle(color: Colors.black87, fontSize: 20)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 200, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(8)), child: const Text('New Intake', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 700,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              const Text('Daily Snapshot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.calendar_today, size: 14), SizedBox(width: 8), Text('Main Intake', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                           ]
                        ),
                        const SizedBox(height: 16),
                        PrimeResponsiveGrid(
                           desktopMainAxisExtent: 140,
                           desktopCrossAxisCount: 4,
                           children: [
                              _buildSnapshotCard('Total Intakes', '48', '+12%', const Color(0xFF0F4C81), Colors.green, const [0.3, 0.4, 0.3, 0.45, 0.5, 0.45, 0.7, 0.6, 0.8]),
                              _buildSnapshotCard('Pending', '16', '', const Color(0xFF0F4C81), Colors.transparent, const [0.2, 0.4, 0.35, 0.5, 0.55, 0.4, 0.6, 0.65, 0.75]),
                              _buildSnapshotCard('Scheduled', '24', '', Colors.teal.shade500, Colors.transparent, const [0.3, 0.4, 0.3, 0.45, 0.5, 0.8, 0.6, 0.5, 0.3]),
                              _buildSnapshotCard('Approved', '8', '', Colors.teal.shade500, Colors.transparent, const [0.2, 0.3, 0.2, 0.4, 0.5, 0.7, 0.6, 0.7, 0.75]),
                           ]
                        ),
                        const SizedBox(height: 24),
                        SizedBox(child: _buildPatientIntakeQueueTable()),
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        SizedBox(child: _buildReferralSourcesCard()),
                        const SizedBox(height: 16),
                        SizedBox(child: _buildUpcomingIntakesCard()),
                     ]
                  )
               ]
            ), // Enforce responsive array
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildSnapshotCard(String title, String val, String pre, Color lineCol, Color preCol, List<double> pts) {
     return Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
              const SizedBox(height: 8),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    if (pre.isNotEmpty) ...[
                       const SizedBox(width: 8),
                       Text('($pre)', style: TextStyle(color: preCol, fontWeight: FontWeight.bold, fontSize: 11)),
                    ]
                 ]
              ),
              SizedBox(child: CustomPaint(painter: _MiniAreaPainter(lineCol, pts), size: const Size(double.infinity, double.infinity))
              )
           ]
        ),
     );
  }

  Widget _buildReferralSourcesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Referral Sources', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                                _buildRefCol('25', 'Hospital\nA', 0.9, const Color(0xFF0F4C81)),
                                _buildRefCol('18', 'Clinic\nB', 0.65, Colors.blue.shade700),
                                _buildRefCol('14', 'Web', 0.5, Colors.teal.shade500),
                                _buildRefCol('9', 'Dr. Green', 0.35, Colors.teal.shade600),
                             ]
                          )
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildRefCol(String num, String base, double h, Color c) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Text(num, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
           const SizedBox(height: 4),
           Container(width: 24, height: 100 * h, color: c),
           const SizedBox(height: 8),
           Text(base, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: Colors.black87)),
        ]
     );
  }

  Widget _buildUpcomingIntakesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Upcoming Intakes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              const Text('Upcoming ad location', style: TextStyle(fontSize: 11, color: Colors.black54)), // Literal typo match
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildUpcomingRow('A. Chen', '10:30 AM', 'City Health\n'),
                       _buildUpcomingRow('J. Smith', '09:15 AM', 'Bayview\n'),
                       _buildUpcomingRow('M. Patel', '08:45 AM', 'City Health\n'),
                       _buildUpcomingRow('L. Garcia', '08:15 AM', 'City Health\n'),
                       _buildUpcomingRow('R. Lee', '03:30 AM', 'ValleyCare\n'),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildUpcomingRow(String n, String t, String loc) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=11')),
                 const SizedBox(width: 12),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                       Text(t, style: const TextStyle(color: Colors.black54, fontSize: 9)),
                    ]
                 )
              ]
           ),
           Text(loc.replaceAll('\n', ''), style: const TextStyle(fontSize: 11)), // Literal
        ]
     );
  }

  Widget _buildPatientIntakeQueueTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Patient Intake Queue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              const Text('Current cases to healthcare Intake Coordinator', style: TextStyle(fontSize: 11, color: Colors.black54)),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['', 'Patient Name', 'Status', 'Priority', 'Franchise Location', 'Date Submitted', 'Actions'], // Checkbox col
                    data: const [
                       {'c': '1', 'n': 'A. Chen', 's': 'Pending Review', 'p': 'High', 'f': 'City Health', 'd': '10:30 AM', 'a': '1'},
                       {'c': '0', 'n': 'J. Smith', 's': 'In Progress', 'p': 'Med', 'f': 'Bayview', 'd': '09:15 AM', 'a': '2'},
                       {'c': '0', 'n': 'M. Patel', 's': 'Scheduled', 'p': 'Med', 'f': 'City Health', 'd': '08:45 AM', 'a': '1'},
                       {'c': '0', 'n': 'L. Garcia', 's': 'Approved', 'p': 'Low', 'f': 'ValleyCare', 'd': '16/10/23', 'a': '2'},
                       {'c': '0', 'n': 'R. Lee', 's': 'Draft', 'p': 'Low', 'f': 'ValleyCare', 'd': '16/10/23', 'a': '2'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Container(width: 16, height: 16, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4), color: data['c'] == '1' ? Colors.grey.shade200 : Colors.white), child: data['c'] == '1' ? const Icon(Icons.check, size: 12, color: Colors.black87) : null)),
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=12')), const SizedBox(width: 8), Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))])),
                       DataCell(_buildStatusPill(data['s']!)),
                       DataCell(Text(data['p']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: data['p'] == 'High' ? Colors.red : data['p'] == 'Med' ? Colors.amber.shade800 : Colors.black87))),
                       DataCell(Text(data['f']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildActionRow(data['a']!)),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildStatusPill(String s) {
     Color bg = Colors.teal.shade500;
     if (s == 'In Progress' || s == 'Scheduled') { bg = const Color(0xFF0F4C81); }
     if (s == 'Draft') { bg = Colors.grey.shade500; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(s, style: const TextStyle(color: Colors.white, fontSize: 10))
     );
  }

  Widget _buildActionRow(String type) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           const Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.black54),
           const SizedBox(width: 8),
           const Icon(Icons.edit_outlined, size: 16, color: Colors.black54),
           const SizedBox(width: 8),
           Icon(type == '1' ? Icons.people_outline : Icons.delete_outline, size: 16, color: Colors.black54),
        ]
     );
  }
}

class _MiniAreaPainter extends CustomPainter {
   final Color cLine;
   final List<double> pts;
   const _MiniAreaPainter(this.cLine, this.pts);

   @override
   void paint(Canvas canvas, Size size) {
      final linePaint = Paint()..color = cLine..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [cLine.withOpacity(0.2), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final path = Path();
      
      final w = size.width / (pts.length - 1);
      path.moveTo(0, size.height * (1 - pts[0]));
      
      for(int i=1; i<pts.length; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * (1 - pts[i-1]), w * i, size.height * (1 - pts[i]));
      }
      
      final areaPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, linePaint);

      // Add prominent dot if it peaks in the middle (mimic design)
      if (pts.length > 5 && pts[5] > 0.6) {
         canvas.drawCircle(Offset(w * 5, size.height * (1 - pts[5])), 4, Paint()..color = Colors.white);
         canvas.drawCircle(Offset(w * 5, size.height * (1 - pts[5])), 2, Paint()..color = cLine);
      }
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
