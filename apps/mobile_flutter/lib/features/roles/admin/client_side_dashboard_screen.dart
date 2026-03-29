import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientSideDashboardScreen extends StatelessWidget {
  const ClientSideDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'MedLink Franchise Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        const Text('Franchise name', style: TextStyle(color: Colors.black54, fontSize: 11)),
                        const SizedBox(height: 4),
                        PrimeCareResponsiveKpiGrid(
 children: const [
                              Text('Sacramento Central Clinic - Jane Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(width: 8),
                              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
                           ]
                        )
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade50, border: Border.all(color: Colors.grey.shade300), shape: BoxShape.circle), child: const Icon(Icons.notifications_none, color: Colors.black87, size: 20)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle), child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                              const SizedBox(width: 12),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Jane Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    Text('(Owner)', style: TextStyle(color: Colors.black54, fontSize: 10)),
                                 ]
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            const Text('Key metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 140,
               desktopCrossAxisCount: 4,
               children: [
                  _buildMetricGraphCard('Total Revenue', '\$645,820', '+8.5%', const Color(0xFF0F4C81), const [0.6, 0.4, 0.5, 0.3, 0.4, 0.2]),
                  _buildMetricGraphCardWithIcon('Total Patients', '12,345', '+4.2%', Colors.teal, Icons.people_outline, const [0.7, 0.6, 0.5, 0.4, 0.3, 0.4]),
                  _buildPatientSatisfactionCard(),
                  _buildActiveAppointmentsCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 360,
               desktopCrossAxisCount: 3,
               children: [
                  _buildRevenueAppointmentTrendsCard(),
                  _buildTopPerformingClinicsCard(),
                  _buildPatientDemographicsCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 360,
               desktopCrossAxisCount: 1,
               children: [
                  _buildRecentAppointmentsTable(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildMetricGraphCard(String title, String val, String sub, Color col, List<double> pts) {
     return Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                    Text(sub, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 11)),
                 ]
              ),
              const SizedBox(height: 4),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: CustomPaint(painter: _MiniSparklinePainter(col, pts))
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildMetricGraphCardWithIcon(String title, String val, String sub, Color col, IconData ic, List<double> pts) {
     return Container(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: Colors.white, size: 20)),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                          Text(title, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                          const SizedBox(height: 4),
                          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                       ]
                    )
                 ]
              ),
              Padding(padding: const EdgeInsets.only(left: 4), child: Text(sub, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 11))),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: CustomPaint(painter: _MiniSparklinePainter(col, pts))
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildPatientSatisfactionCard() {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              PrimeCareResponsiveKpiGrid(
 children: [
                    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.star_border, color: const Color(0xFF0F4C81), size: 20)),
                    const SizedBox(width: 12),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('Patient Satisfaction', style: TextStyle(fontSize: 11, color: Colors.black87)),
                          SizedBox(height: 4),
                          Text('94.1%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                       ]
                    )
                 ]
              ),
              PrimeCareResponsiveKpiGrid(
 children: [
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.add, color: Color(0xFF0F4C81), size: 16)),
                    const SizedBox(width: 8),
                    const Text('12K', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildActiveAppointmentsCard() {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              const Text('Active Appointments', style: TextStyle(fontSize: 11, color: Colors.black87)),
              const SizedBox(height: 4),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                    const Text('1,890', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(width: 48, height: 48, child: CustomPaint(painter: _MiniDonutPainter()))
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildRevenueAppointmentTrendsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Revenue & Appointment Trends', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.bar_chart, color: Colors.grey, size: 12), SizedBox(width: 4), Text('Montfn', style: TextStyle(color: Colors.black87, fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal typo
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('\$250'), _ChartLineEmpty('\$200'), _ChartLineEmpty('\$150'), _ChartLineEmpty('\$100'), _ChartLineEmpty('\$50'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _TrendsOverlayPainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 10)), Text('Feb', style: TextStyle(fontSize: 10)), Text('Mar', style: TextStyle(fontSize: 10)), Text('Apr', style: TextStyle(fontSize: 10)), Text('May', style: TextStyle(fontSize: 10)), Text('Jun', style: TextStyle(fontSize: 10)), Text('Aug', style: TextStyle(fontSize: 10)), Text('Aug', style: TextStyle(fontSize: 10))])) // Literal typo repeated Aug
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildTopPerformingClinicsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Top Performing Clinics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildClinicRow('1', 'Clinic...', '\$645,820', 5, true), // Typo string match
                       _buildClinicRow('2', 'Clinics A...', '\$12,345', 4, false), // Typo
                       _buildClinicRow('3', 'Sacrame...', '\$13,385', 3, false),
                       _buildClinicRow('4', 'Clinics A...', '\$13,390', 4, false), // Typo
                       _buildClinicRow('5', 'Sacrame...', '\$12,450', 2, false),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildClinicRow(String r, String n, String v, int stars, bool active) {
     return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: active ? const Color(0xFF0F4C81) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              PrimeCareResponsiveKpiGrid(
 children: [
                    Text(r, style: TextStyle(fontWeight: FontWeight.bold, color: active ? Colors.white : Colors.black87, fontSize: 12)),
                    const SizedBox(width: 12),
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: active ? Colors.white.withOpacity(0.2) : Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: Icon(Icons.local_hospital, size: 12, color: active ? Colors.white : const Color(0xFF0F4C81))),
                    const SizedBox(width: 8),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(n, style: TextStyle(fontWeight: FontWeight.bold, color: active ? Colors.white : Colors.black87, fontSize: 11)),
                          PrimeCareResponsiveKpiGrid(
 children: List.generate(5, (index) => Icon(Icons.star, size: 8, color: index < stars ? Colors.amber : Colors.grey.shade400))
                          )
                       ]
                    )
                 ]
              ),
              Text(v, style: TextStyle(fontWeight: FontWeight.bold, color: active ? Colors.white : Colors.black87, fontSize: 11)),
           ]
        )
     );
  }

  Widget _buildPatientDemographicsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Patient Demographics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                          width: 180, height: 180,
                          child: CustomPaint(painter: _DemographicPiePainter())
                       ),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildRecentAppointmentsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Appointments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.sort, size: 14), SizedBox(width: 4), Text('Sorting v', style: TextStyle(fontSize: 11))])),
                          const SizedBox(width: 12),
                          Container(width: 160, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 14), SizedBox(width: 4), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 11))])),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Patient Name', 'Date', 'Clinic', 'Doctor', 'Status'],
                    data: const [
                       {'n': 'Sarah J.', 'd': '10/26', 'c': 'Sacramento Central Clinic', 'dr': 'Dr. Adams', 'img': '9'},
                       {'n': 'Sarah J.', 'd': '10/27', 'c': 'Sacramento Clinic', 'dr': 'Dr. Adams', 'img': '11'},
                       {'n': 'Lova A.', 'd': '10/28', 'c': 'Sacramento Central Clinic', 'dr': 'Dr. Mars', 'img': '12'}, // Typo Lova
                       {'n': 'Liava A.', 'd': '10/23', 'c': 'Bamson Clinic', 'dr': 'Dr. Adams', 'img': '13'}, // Typo Bamson
                       {'n': 'Sarah J.', 'd': '10/29', 'c': 'Sacramento Clinic', 'dr': 'Dr. Renth', 'img': '10'}, // Typo Renth
                    ],
                    rowBuilder: (data) => [
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${data['img']}')), const SizedBox(width: 8), Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))])),
                       DataCell(Text(data['d']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['c']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['dr']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildStatusPill('Confirmed'), const Icon(Icons.more_horiz, size: 16, color: Colors.grey)])),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildStatusPill(String s) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)), // Mint pill
        child: Text(s, style: TextStyle(color: Colors.green.shade700, fontSize: 10, fontWeight: FontWeight.bold))
     );
  }
}

class _MiniSparklinePainter extends CustomPainter {
   final Color cLine;
   final List<double> pts;
   const _MiniSparklinePainter(this.cLine, this.pts);

   @override
   void paint(Canvas canvas, Size size) {
      final linePaint = Paint()..color = cLine..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [cLine.withOpacity(0.3), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final path = Path();
      
      final w = size.width / (pts.length - 1);
      path.moveTo(0, size.height * pts[0]);
      
      for(int i=1; i<pts.length; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * pts[i-1], w * i, size.height * pts[i]);
      }
      
      final areaPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, linePaint);
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniDonutPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      
      final pB = Paint()..color = Colors.grey.shade200..style = PaintingStyle.stroke..strokeWidth = 8;
      final pT = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 8..strokeCap = StrokeCap.round;
      
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawCircle(center, radius, pB);
      canvas.drawArc(rect, -3.14159 / 2, 3.14159 * 1.6, false, pT); // ~80%
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrendsOverlayPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 2..style = PaintingStyle.stroke;
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 2..style = PaintingStyle.stroke;
      
      final fillDB = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [const Color(0xFF0F4C81).withOpacity(0.6), const Color(0xFF0F4C81).withOpacity(0.1)]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      final fillT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade400.withOpacity(0.6), Colors.teal.shade200.withOpacity(0.1)]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final ptsDB = [0.85, 0.65, 0.7, 0.5, 0.55, 0.5, 0.2, 0.1]; // Jan - Aug
      final ptsT = [0.95, 0.8, 0.8, 0.65, 0.65, 0.35, 0.6, 0.5];
      
      final w = size.width / 7; // 8 points = 7 gaps
      
      final pDB = Path(); pDB.moveTo(0, size.height * ptsDB[0]);
      for(int i=1; i<8; i++) pDB.lineTo(w * i, size.height * ptsDB[i]);
      
      final pT = Path(); pT.moveTo(0, size.height * ptsT[0]);
      for(int i=1; i<8; i++) pT.lineTo(w * i, size.height * ptsT[i]);

      final aDB = Path.from(pDB)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      final aT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();

      canvas.drawPath(aDB, fillDB);
      canvas.drawPath(aT, fillT);
      canvas.drawPath(pDB, paintDB);
      canvas.drawPath(pT, paintT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DemographicPiePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 36;
      final paintT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 36;
      final paintG = Paint()..color = Colors.green.shade600..style = PaintingStyle.stroke..strokeWidth = 36;
      
      final rect = Rect.fromCircle(center: center, radius: radius - 18);
      
      final gap = 0.03;
      final pi2 = 3.14159 * 2;
      
      final startDB = -3.14159 / 2;
      final sweepDB = pi2 * 0.55;
      
      final startT = startDB + sweepDB;
      final sweepT = pi2 * 0.30;
      
      final startG = startT + sweepT;
      final sweepG = pi2 * 0.15;
      
      canvas.drawArc(rect, startDB + gap, sweepDB - gap, false, paintDB);
      canvas.drawArc(rect, startT + gap, sweepT - gap, false, paintT);
      canvas.drawArc(rect, startG + gap, sweepG - gap, false, paintG);
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
            SizedBox(width: 32, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            SizedBox(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

