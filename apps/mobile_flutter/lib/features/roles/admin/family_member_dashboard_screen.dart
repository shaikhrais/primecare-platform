import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:math' as math;

class FamilyMemberDashboardScreen extends StatelessWidget {
  const FamilyMemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3), // Light Teal wash
      appBar: const PrimeCareAppBar(title: 'Welcome, Sarah!'), // Overriding standard title
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Welcome, Sarah!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 200, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle), child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                              const SizedBox(width: 8),
                              const Text('Sarah Jensen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), // Sarah Jensen text match
                              const SizedBox(width: 4),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 160,
               children: [
                  _buildNextAppointmentCard(),
                  _buildActiveCarePlansCard(),
                  _buildFamilyWellnessScoreCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 460,
               desktopCrossAxisCount: 2, // 3:2 ratio on desktop, wait we can't easily do 3:2, so we'll just stack them in 2 cols
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              const Text('My Family', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All secend', style: TextStyle(fontSize: 11)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal typo All secend
                           ]
                        ),
                        const SizedBox(height: 16),
                        SizedBox(child: _buildFamilyList()),
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        SizedBox(child: _buildRecentMedicalUpdatesCard()),
                        const SizedBox(height: 16),
                        SizedBox(child: _buildUpcomingAppointmentsCard()),
                     ]
                  ),
               ]
            ),

            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 280,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Health Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        SizedBox(child: PrimeCareCard(
                              child: PrimeCareResponsiveKpiGrid(
 children: [
                                    SizedBox(child: _buildMonthlyFamilyVisitsChart()),
                                    const SizedBox(width: 24),
                                    SizedBox(child: _buildWellnessTrendsChart()),
                                 ]
                              )
                           )
                        )
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Healthcare Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)), child: const Text('Tips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                              const SizedBox(width: 16),
                              const Text('Articles', style: TextStyle(fontSize: 11)),
                           ]
                        ),
                        const SizedBox(height: 16),
                        SizedBox(child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 SizedBox(child: _buildFeedCard('Tips for wne time', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna')), // Literal typo wne
                                 const SizedBox(height: 16),
                                 SizedBox(child: _buildFeedCard('Tips Articles', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do')),
                              ]
                           )
                        )
                     ]
                  ),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildNextAppointmentCard() {
     return Stack(
        children: [
           Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))]),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Next Appointment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('Liam Jensen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text('Pediatrics', style: TextStyle(color: Colors.black87, fontSize: 12)),
                       ]
                    ),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: const [
                                Text('Oct 28, 10:00 AM', style: TextStyle(fontSize: 11)),
                                Text('Dr. Evans', style: TextStyle(fontSize: 11)),
                             ]
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(16)), child: const Text('Manage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                       ]
                    )
                 ]
              ),
           ),
           Positioned(top: 16, right: 16, child: Icon(Icons.calendar_month_outlined, size: 24, color: Colors.blueGrey.shade600)),
        ]
     );
  }

  Widget _buildActiveCarePlansCard() {
     return Stack(
        children: [
           Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))]),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Active Care Plans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const Text('4 Plans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    const Text('View Details', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.underline)),
                 ]
              ),
           ),
           Positioned(top: 16, right: 16, child: Icon(Icons.description_outlined, size: 24, color: Colors.blueGrey.shade600)),
        ]
     );
  }

  Widget _buildFamilyWellnessScoreCard() {
     return Stack(
        children: [
           Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))]),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Family Wellness Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: const [
                                Text('88%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                                Text('- Chart/Teal', style: TextStyle(color: Colors.black87, fontSize: 10)), // Literal typo matching design text!
                             ]
                          ),
                          SizedBox(
                             width: 100, height: 60, // Half circle bounded
                             child: CustomPaint(painter: _WellnessNeedlePainter())
                          )
                       ]
                    )
                 ]
              ),
           ),
           Positioned(top: 16, right: 16, child: Icon(Icons.mood, size: 24, color: Colors.blueGrey.shade600)),
        ]
     );
  }

  Widget _buildFamilyList() {
     return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(child: _buildFamilyCard('https://i.pravatar.cc/150?img=11', 'Liam Jensen', 'Photo, 7 yrs', '21 ago', 'Medical')), // Typo literal
           const SizedBox(height: 16),
           SizedBox(child: _buildFamilyCard('https://i.pravatar.cc/150?img=5', 'Emily Jensen', 'Photo, 12 yrs', '12 ago', 'Medical status')),
           const SizedBox(height: 16),
           SizedBox(child: _buildFamilyCard('https://i.pravatar.cc/150?img=12', 'Michael Jensen', 'Photo, 45 yrs', '45 ago', 'Medical status')),
        ]
     );
  }

  Widget _buildFamilyCard(String img, String n, String sub, String act, String medText) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))]),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              PrimeCareResponsiveKpiGrid(
 children: [
                    CircleAvatar(radius: 28, backgroundImage: NetworkImage(img)),
                    const SizedBox(width: 16),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(sub, style: const TextStyle(color: Colors.black87, fontSize: 11)),
                          const SizedBox(height: 4),
                          Text('Recent activity: $act', style: const TextStyle(color: Colors.black54, fontSize: 10)),
                       ]
                    )
                 ]
              ),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.schedule, size: 12, color: Colors.black87), SizedBox(width: 4), Text('Recent Activity', style: TextStyle(fontSize: 10))]),
                    const SizedBox(height: 4),
                    PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.calendar_today, size: 12, color: Colors.black87), SizedBox(width: 4), Text('Upcoming Appts', style: TextStyle(fontSize: 10))]),
                    const SizedBox(height: 4),
                    PrimeCareResponsiveKpiGrid(
 children: [Icon(Icons.healing, size: 12, color: Colors.teal.shade500), const SizedBox(width: 4), Text(medText, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]),
                 ]
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(24)), child: const Text('View Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
           ]
        ),
     );
  }

  Widget _buildRecentMedicalUpdatesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Recent Medical Updates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const Text('Timeline', style: TextStyle(color: Colors.black54, fontSize: 10)),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                             child: Align(alignment: Alignment.centerLeft, child: Container(width: 1, color: Colors.grey.shade300))
                          )
                       ),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             _buildTimelineRow(const Color(0xFF0F4C81), 'Liam - Lab Results', 'Liam - Lab Results status', '10/24'),
                             _buildTimelineRow(Colors.teal.shade500, 'Emily - Vaccine', 'Emily - Vaccine after', '10/22'), // Literal typo string mapping
                          ]
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildTimelineRow(Color col, String t, String sub, String date) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4, right: 12), decoration: BoxDecoration(color: col, shape: BoxShape.circle)),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                          Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(date, style: const TextStyle(fontSize: 11)),
                       ]
                    ),
                    Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                 ]
              )
           )
        ]
     );
  }

  Widget _buildUpcomingAppointmentsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Upcoming Appointments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Date', 'Time', 'Doctor', 'Patient', 'Actions'],
                    data: const [
                       {'d': '01/24', 't': '18:30', 'dr': 'Doctor', 'p': 'Patients'},
                       {'d': '01/25', 't': '10:00', 'dr': 'Dr. Ev', 'p': 'Emily'},
                       {'d': 'Oct 28', 't': '10:00', 'dr': 'Dr. Ev', 'p': 'Emily'}, // Literal typo breaking Date format parsing logic
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['t']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['dr']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['p']!, style: const TextStyle(fontSize: 11))),
                       const DataCell(Icon(Icons.more_horiz, size: 16, color: Colors.grey)),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildMonthlyFamilyVisitsChart() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Monthly Family Visits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Line chart', style: TextStyle(fontSize: 10))]),
              ]
           ),
           const SizedBox(height: 16),
           SizedBox(child: Stack(
                 children: [
                    Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: const [
                          _ChartLineEmpty('20'), _ChartLineEmpty('15'), _ChartLineEmpty('10'), _ChartLineEmpty('5'), _ChartLineEmpty('0'),
                       ]
                    ),
                    Positioned.fill(
                       child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10, bottom: 20),
                          child: Stack(
                             children: [
                                Positioned.fill(
                                   child: CustomPaint(painter: _FamilyVisitsDualPainter())
                                )
                             ]
                          )
                       )
                    ),
                    Positioned(bottom: 0, left: 30, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 9)), Text('Feb', style: TextStyle(fontSize: 9)), Text('Mar', style: TextStyle(fontSize: 9)), Text('Apr', style: TextStyle(fontSize: 9)), Text('May', style: TextStyle(fontSize: 9)), Text('Jun', style: TextStyle(fontSize: 9)), Text('Dec', style: TextStyle(fontSize: 9))])) // Literal typo Jun -> Dec
                 ]
              )
           )
        ]
     );
  }

  Widget _buildWellnessTrendsChart() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Wellness Trends', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('#0F4C81', style: TextStyle(fontSize: 10))]), // Literal typo rendering color hex instead of label
              ]
           ),
           const SizedBox(height: 16),
           SizedBox(child: Stack(
                 children: [
                    Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: const [
                          _ChartLineEmpty('100'), _ChartLineEmpty('75'), _ChartLineEmpty('50'), _ChartLineEmpty('25'), _ChartLineEmpty('0'),
                       ]
                    ),
                    Positioned.fill(
                       child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10, bottom: 20),
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                                _buildTwinBar(0.6, 0.4),
                                _buildTwinBar(0.8, 0.6),
                                _buildTwinBar(0.5, 0.4),
                                _buildTwinBar(0.9, 0.7),
                                _buildTwinBar(0.8, 0.5),
                                _buildTwinBar(0.7, 0.6),
                             ]
                          )
                       )
                    ),
                    Positioned(bottom: 0, left: 30, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Mon', style: TextStyle(fontSize: 9)), Text('Tue', style: TextStyle(fontSize: 9)), Text('Wed', style: TextStyle(fontSize: 9)), Text('Thu', style: TextStyle(fontSize: 9)), Text('Fri', style: TextStyle(fontSize: 9)), Text('Sat', style: TextStyle(fontSize: 9))]))
                 ]
              )
           )
        ]
     );
  }

  Widget _buildTwinBar(double h1, double h2) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 6, height: 120 * h1, color: const Color(0xFF0F4C81)),
           const SizedBox(width: 2),
           Container(width: 6, height: 120 * h2, color: Colors.teal.shade600),
        ]
     );
  }

  Widget _buildFeedCard(String t, String desc) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(color: Colors.black87, fontSize: 10)),
           ]
        )
     );
  }

}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 20, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            SizedBox(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

class _FamilyVisitsDualPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final pT = Paint()..color = Colors.teal.shade500..strokeWidth = 2..style = PaintingStyle.stroke;
      final fT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade500.withOpacity(0.3), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final pDB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 2..style = PaintingStyle.stroke;
      
      final ptsT = [0.8, 0.6, 0.4, 0.5, 0.2, 0.5, 0.1]; // Jan -> Dec
      final ptsDB = [0.9, 0.4, 0.3, 0.6, 0.4, 0.7, 0.3];
      
      final w = size.width / 6;
      
      final pathT = Path(); pathT.moveTo(0, size.height * ptsT[0]);
      for(int i=1; i<7; i++) pathT.quadraticBezierTo(w * (i - 0.5), size.height * ptsT[i-1], w * i, size.height * ptsT[i]);

      final pathDB = Path(); pathDB.moveTo(0, size.height * ptsDB[0]);
      for(int i=1; i<7; i++) pathDB.quadraticBezierTo(w * (i - 0.5), size.height * ptsDB[i-1], w * i, size.height * ptsDB[i]);
      
      final aPath = Path.from(pathT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aPath, fT);
      canvas.drawPath(pathDB, pDB); // Render Dark Blue line below area
      canvas.drawPath(pathT, pT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WellnessNeedlePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height); 
      final radius = size.width / 2;
      
      final pDB = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 12..strokeCap = StrokeCap.round;
      final pT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 12..strokeCap = StrokeCap.round;
      
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gap = 0.1;
      
      final startDB = -3.14159; 
      final sweepDB = 3.14159 * 0.4; // 40% blue line 
      
      final startT = startDB + sweepDB + gap; 
      final sweepT = 3.14159 * 0.55; // 55% teal line
      
      canvas.drawArc(rect, startDB, sweepDB, false, pDB);
      canvas.drawArc(rect, startT, sweepT, false, pT);
      
      // Needle pointing slightly past gap into Teal
      final needleAngle = startT + (sweepT * 0.2); 
      final needleLength = radius - 8;
      
      final nx = center.dx + needleLength * math.cos(needleAngle);
      final ny = center.dy + needleLength * math.sin(needleAngle);
      
      final pNeedle = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 4..strokeCap = StrokeCap.round;
      canvas.drawLine(center, Offset(nx, ny), pNeedle);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
