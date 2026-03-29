import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CommunityOutreachDashboardScreen extends StatelessWidget {
  const CommunityOutreachDashboardScreen({super.key});

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
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                        Text('Community Outreach Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        SizedBox(height: 4),
                        Text('eleanor.reed@careconnect.com', style: TextStyle(color: Colors.black54, fontSize: 13)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        const Icon(Icons.notifications_active_outlined, color: Colors.black87, size: 20),
                        const SizedBox(width: 8),
                        const Text('Notifications', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 24),
                        Container(width: 200, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(24)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.add, color: Colors.white, size: 16), SizedBox(width: 8), Text('New Program', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildLeftColumn()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRightColumn()),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           PrimeResponsiveGrid(
              desktopCrossAxisCount: 4,
              desktopMainAxisExtent: 160,
              children: [
                 _buildTotalEventsCard(),
                 _buildParticipantsReachedCard(),
                 _buildVolunteerHoursCard(),
                 _buildOutreachBudgetCard(),
              ]
           ),
           const SizedBox(height: 24),
           _buildOutreachEngagementCard().withHeight(360),
           const SizedBox(height: 24),
           PrimeResponsiveGrid(
              desktopCrossAxisCount: 2,
              desktopMainAxisExtent: 340,
              children: [
                 _buildActiveProgramsTable(),
                 _buildUpcomingEventsCalendar(),
              ]
           ),
        ]
     );
  }

  Widget _buildRightColumn() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           _buildTopPartnersCard(),
           const SizedBox(height: 24),
           _buildRecentActivityFeedCard().withHeight(640), // fill remaining vertical pipeline
        ]
     );
  }

  Widget _buildTopCardBase(String title, Widget content) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
              SizedBox(child: Padding(padding: const EdgeInsets.only(top: 12), child: content)),
           ]
        ),
     );
  }

  Widget _buildTotalEventsCard() {
     return _buildTopCardBase(
        '1. Total Events',
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    const Text('245', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('+12%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10))),
                 ]
              ),
              SizedBox(child: CustomPaint(painter: _ZigZagLinePainter(Colors.teal.shade500, Colors.teal.shade50), size: const Size(double.infinity, 40))),
           ]
        )
     );
  }

  Widget _buildParticipantsReachedCard() {
     return _buildTopCardBase(
        '2. Participants Reached',
        Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space it
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    const Text('14,892', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('+18%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10))),
                 ]
              ),
              Padding(
                 padding: const EdgeInsets.only(top: 8, bottom: 4),
                 child: Container(width: double.infinity, height: 6, color: Colors.blueGrey.shade50, alignment: Alignment.centerLeft, child: FractionallySizedBox(widthFactor: 0.8, child: Container(color: Colors.teal.shade500))),
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Progress', style: TextStyle(color: Colors.black54, fontSize: 10)),
                    Text('14,892', style: TextStyle(color: Colors.black87, fontSize: 10)),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildVolunteerHoursCard() {
     return _buildTopCardBase(
        '3. Volunteer Hours',
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('9,650', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    const Text('Donut chart', style: TextStyle(color: Colors.black54, fontSize: 10)),
                 ]
              ),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('+7.5%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10))),
                    const SizedBox(height: 8),
                    SizedBox(
                       width: 36, height: 36,
                       child: Stack(
                          children: [
                             Positioned.fill(child: CircularProgressIndicator(value: 0.7, strokeWidth: 8, color: const Color(0xFF0F4C81), backgroundColor: Colors.teal.shade500)),
                          ]
                       )
                    )
                 ]
              )
           ]
        )
     );
  }

  Widget _buildOutreachBudgetCard() {
     return _buildTopCardBase(
        '4. Outreach Budget',
        Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: const [
                    Text('48,320', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(' / \$60k', style: TextStyle(color: Colors.black54, fontSize: 12)),
                 ]
              ),
              SizedBox(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       _buildSimpleColumn(0.4, true), _buildSimpleColumn(0.3, true), _buildSimpleColumn(0.5, true), _buildSimpleColumn(0.6, true), _buildSimpleColumn(0.8, true), _buildSimpleColumn(0.5, true), _buildSimpleColumn(0.3, true), _buildSimpleColumn(0.2, true), _buildSimpleColumn(0.6, false), _buildSimpleColumn(0.4, false),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildSimpleColumn(double h, bool isFilled) {
     return Container(width: 8, height: 40 * h, decoration: BoxDecoration(color: isFilled ? const Color(0xFF0F4C81) : Colors.blueGrey.shade100, borderRadius: BorderRadius.circular(2)));
  }

  Widget _buildOutreachEngagementCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          const Text('Outreach Engagement & Impact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [
                                PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Participants', style: TextStyle(fontSize: 11))]),
                                const SizedBox(width: 16),
                                PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Programs', style: TextStyle(fontSize: 11))]),
                             ]
                          )
                       ]
                    ),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('12 months', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                          const SizedBox(width: 12),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('12 months', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('200'), _ChartLineEmpty('150'), _ChartLineEmpty('100'), _ChartLineEmpty('50'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _MassiveWaveDoublePainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 10)), Text('Feb', style: TextStyle(fontSize: 10)), Text('Mar', style: TextStyle(fontSize: 10)), Text('Apr', style: TextStyle(fontSize: 10)), Text('May', style: TextStyle(fontSize: 10)), Text('Jun', style: TextStyle(fontSize: 10)), Text('Jul', style: TextStyle(fontSize: 10)), Text('Sep', style: TextStyle(fontSize: 10)), Text('Nov', style: TextStyle(fontSize: 10)), Text('Dec', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTopPartnersCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Top Partners', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    Column(
                       children: [
                          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), child: const Icon(Icons.business_center, color: Color(0xFF0F4C81), size: 32)),
                          const SizedBox(height: 8),
                          const Text('City Health\nDept', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                       ]
                    ),
                    Column(
                       children: [
                          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), child: const Icon(Icons.apple, color: Color(0xFF0F4C81), size: 32)),
                          const SizedBox(height: 8),
                          const Text('Regional\nFood Bank', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                       ]
                    ),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildActiveProgramsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Active Outreach Programs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Program Name', 'Status', 'Leads', 'Participants'],
                    data: const [
                       {'n': 'Health Fair', 's': 'Active', 'l': '245', 'p': '1,650'},
                       {'n': 'Vaccination Drive', 's': 'Upcoming', 'l': '103', 'p': '1,176'},
                       {'n': 'Health Screening', 's': 'Upcoming', 'l': '29', 'p': '355'},
                       {'n': 'Local Clinic Support', 's': 'Upcoming', 'l': '32', 'p': '438'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(_buildStatusPill(data['s']!)),
                       DataCell(Text(data['l']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['p']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildStatusPill(String s) {
     final bool isActive = s == 'Active';
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: isActive ? Colors.teal.shade50 : Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Text(s, style: TextStyle(color: isActive ? Colors.teal.shade700 : const Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 11))
     );
  }

  Widget _buildUpcomingEventsCalendar() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Upcoming Events Calendar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Sun', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Mon', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Tue', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Wed', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Thu', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Fri', style: TextStyle(color: Colors.black54, fontSize: 10)), Text('Sat', style: TextStyle(color: Colors.black54, fontSize: 10)),
                 ]
              ),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('1', style: TextStyle(fontSize: 11)), const Text('2', style: TextStyle(fontSize: 11)), const Text('3', style: TextStyle(fontSize: 11)),
                    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)), child: const Text('4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    const Text('5', style: TextStyle(fontSize: 11)), const Text('6', style: TextStyle(fontSize: 11)), const Text('7', style: TextStyle(fontSize: 11)),
                 ]
              ),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('18', style: TextStyle(fontSize: 11)), const Text('19', style: TextStyle(fontSize: 11)), const Text('10', style: TextStyle(fontSize: 11)), const Text('21', style: TextStyle(fontSize: 11)), const Text('22', style: TextStyle(fontSize: 11)),
                    Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle), child: const Text('23', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    const Text('24', style: TextStyle(fontSize: 11)),
                 ]
              ),
              const SizedBox(height: 24),
              PrimeCareResponsiveKpiGrid(
 children: [const Text('Aug 15', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(width: 8), Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Wellness Workshop', style: TextStyle(fontSize: 11))]),
              const SizedBox(height: 12),
              PrimeCareResponsiveKpiGrid(
 children: [const Text('Aug 22', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(width: 8), Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Community Health Fair', style: TextStyle(fontSize: 11))]),
           ]
        ),
     );
  }

  Widget _buildRecentActivityFeedCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Recent Activity Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildActivityRow(Icons.event_note, 'Community Health\nFair\'s Fair', '7 hours sgo', Colors.blue.shade50, const Color(0xFF0F4C81)), // Literal typos from mockup
                       _buildActivityRow(Icons.medical_services_outlined, 'City Eoily\nVaccination Dre...', '3 hours sgo', Colors.orange.shade50, Colors.orange.shade700),
                       _buildActivityRow(Icons.text_snippet_outlined, 'Community Health\nHealth Screening...', '7 houx ago', Colors.teal.shade50, Colors.teal.shade700),
                       _buildActivityRow(Icons.health_and_safety_outlined, 'Local Clinic For:\nHealth Clinic Ino...', '1 month ago', Colors.blue.shade50, const Color(0xFF0F4C81)),
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildActivityRow(IconData ic, String title, String sub, Color bg, Color ti) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: bg, shape: BoxShape.circle), child: Icon(ic, color: ti, size: 16)),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                 ]
              )
           )
        ]
     );
  }
}

class _ZigZagLinePainter extends CustomPainter {
   final Color cLine;
   final Color cArea;
   const _ZigZagLinePainter(this.cLine, this.cArea);

   @override
   void paint(Canvas canvas, Size size) {
      final linePaint = Paint()..color = cLine..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = cArea..style = PaintingStyle.fill;
      
      final pts = [0.9, 0.7, 0.85, 0.4, 0.5, 0.1];
      final path = Path();
      
      final w = size.width / (pts.length - 1);
      path.moveTo(0, size.height * pts[0]);
      
      for(int i=1; i<pts.length; i++) {
         path.lineTo(w * i, size.height * pts[i]); // literal zig zag, no bezier
      }
      
      final areaPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, linePaint);
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MassiveWaveDoublePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      
      final fillT = Paint()..color = Colors.teal.shade500.withOpacity(0.15)..style = PaintingStyle.fill;
      
      final ptsB = [0.8, 0.7, 0.9, 0.8, 0.35, 0.6, 0.35, 0.5, 0.2, 0.1];
      final ptsT = [0.95, 0.85, 0.7, 0.85, 0.6, 0.7, 0.85, 0.4, 0.7, 0.5];
      
      final pB = Path();
      final pT = Path();
      
      final w = size.width / 9;
      
      pB.moveTo(0, size.height * ptsB[0]);
      pT.moveTo(0, size.height * ptsT[0]);

      for(int i=1; i<10; i++) {
         pB.quadraticBezierTo(w * (i - 0.5), size.height * ptsB[i-1], w * i, size.height * ptsB[i]);
         pT.quadraticBezierTo(w * (i - 0.5), size.height * ptsT[i-1], w * i, size.height * ptsT[i]);
      }

      canvas.drawPath(pB, paintB);
      
      final aT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aT, fillT);
      canvas.drawPath(pT, paintT);

      // Add May tooltip line (index 4)
      final mayNodeX = w * 4;
      final mayNodeY = size.height * ptsT[4];
      
      canvas.drawLine(Offset(mayNodeX, 0), Offset(mayNodeX, size.height), Paint()..color = Colors.grey.withOpacity(0.5)..strokeWidth = 1..style = PaintingStyle.stroke); // vertical dash simulation
      
      canvas.drawCircle(Offset(mayNodeX, size.height * ptsB[4]), 6, Paint()..color = const Color(0xFF0F4C81));
      canvas.drawCircle(Offset(mayNodeX, size.height * ptsT[4]), 6, Paint()..color = Colors.teal.shade500);

      // Tooltip 1 (May)
      M_drawTooltip(canvas, Offset(mayNodeX, size.height * ptsB[4] - 25), '12 months\n', 'Rrograms: 37', const Color(0xFF4A5568));

      // Tooltip 2 (Sep - index 7)
      final sepNodeX = w * 7;
      final sepNodeY = size.height * ptsT[7];
      canvas.drawCircle(Offset(sepNodeX, sepNodeY), 6, Paint()..color = Colors.teal.shade500);
      M_drawTooltip(canvas, Offset(sepNodeX, sepNodeY - 15), 'Progrern: 125', '', Colors.grey.shade600);
   }

   void M_drawTooltip(Canvas canvas, Offset pos, String t1, String t2, Color bg) {
      final r = RRect.fromRectAndRadius(Rect.fromCenter(center: pos, width: 70, height: 32), const Radius.circular(6));
      canvas.drawRRect(r, Paint()..color = bg);
      
      final span = TextSpan(children: [TextSpan(text: t1, style: const TextStyle(color: Colors.white, fontSize: 8)), TextSpan(text: t2, style: const TextStyle(color: Colors.tealAccent, fontSize: 8, fontWeight: FontWeight.bold))]);
      final tp = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, pos.translate(-30, -12));
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 32, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            SizedBox(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
