import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BillingDashboardScreen extends StatelessWidget {
  const BillingDashboardScreen({super.key});

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
                        Text('Healthcare Franchise Dashboard |', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        SizedBox(height: 4),
                        Text('Good Morning, Sarah!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.calendar_today_outlined, size: 16), SizedBox(width: 8), Text('Oct 26, 2023', style: TextStyle(fontSize: 12))])),
                        const SizedBox(width: 24),
                        const Icon(Icons.search, color: Colors.black54, size: 24),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black54, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 24),
                        const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildFranchiseRevenueCard(),
                  _buildOutstandingInvoicesCard(),
                  _buildPatientEncountersCard(),
                  _buildFranchisePerformanceCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildRevenueOverviewCard(),
                  _buildBillingDistributionCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildRecentInvoicesCard(),
                  _buildMonthlyGoalsCard(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCardBase(String title, String val, Widget sub, Widget vizGraphic) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              sub,
              SizedBox(child: Padding(padding: const EdgeInsets.only(top: 8), child: vizGraphic)),
           ]
        ),
     );
  }

  Widget _buildFranchiseRevenueCard() {
     return _buildTopCardBase(
        'Total Franchise Revenue', '\$3,245,670',
        PrimeCareResponsiveKpiGrid(
 children: const [Text('+8.2%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(width: 4), Text('vs last month', style: TextStyle(color: Colors.black54, fontSize: 11))]),
        SizedBox(height: 40, child: CustomPaint(painter: _UpwardWavePainter(Colors.teal.shade500, Colors.teal.shade50, true), size: const Size(double.infinity, 40)))
     );
  }

  Widget _buildOutstandingInvoicesCard() {
     return _buildTopCardBase(
        'Outstanding Invoices', '\$412,900',
        const Text('289 overdue', style: TextStyle(color: Colors.redAccent, fontSize: 11)),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
              _buildMiniCol('Mon', 0.2, 0.4), _buildMiniCol('Tue', 0.2, 0.5), _buildMiniCol('Wed', 0.4, 0.6), _buildMiniCol('Thu', 0.5, 0.65), _buildMiniCol('Fri', 0.6, 0.75), _buildMiniCol('Sat', 0.7, 0.8),
           ]
        )
     );
  }
  
  Widget _buildMiniCol(String lbl, double dH, double lH) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(width: 14, height: 50 * (lH-dH), decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
           Container(width: 14, height: 50 * dH, color: const Color(0xFF0F4C81)),
           const SizedBox(height: 4),
           Text(lbl, style: const TextStyle(fontSize: 9, color: Colors.black54)),
        ]
     );
  }

  Widget _buildPatientEncountersCard() {
     return _buildTopCardBase(
        'Patient Encounters', '1,150',
        const Text('This Month', style: TextStyle(color: Colors.black54, fontSize: 11)),
        SizedBox(height: 40, child: CustomPaint(painter: _UpwardWavePainter(const Color(0xFF0F4C81), Colors.blue.shade50, false), size: const Size(double.infinity, 40)))
     );
  }

  Widget _buildFranchisePerformanceCard() {
     return _buildTopCardBase(
        'Franchise Performance', '12 Clinics Active',
        const Text('95% efficiency', style: TextStyle(color: Colors.black54, fontSize: 11)),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.domain, color: Color(0xFF0F4C81), size: 16)),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.access_time, color: Colors.white, size: 16)),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.insert_chart, color: Color(0xFF0F4C81), size: 16)),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.pie_chart, color: Color(0xFF0F4C81), size: 16)),
           ]
        ),
     );
  }

  Widget _buildRevenueOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Revenue Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Area chart', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                          const SizedBox(width: 16),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Revenue', style: TextStyle(fontSize: 11))]),
                          const SizedBox(width: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Target', style: TextStyle(fontSize: 11))]),
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
                             _ChartLine('\$2,500'), _ChartLine('\$2,000'), _ChartLine('\$1,500'), _ChartLine('\$1,000'), _ChartLine('\$500'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned(
                                      bottom: 0, left: 0, right: 0,
                                      child: CustomPaint(
                                         size: const Size(double.infinity, 220),
                                         painter: _DualWavePainter(),
                                      )
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Oct 1', style: TextStyle(fontSize: 10)), Text('Oct 3', style: TextStyle(fontSize: 10)), Text('Oct 5', style: TextStyle(fontSize: 10)), Text('7', style: TextStyle(fontSize: 10)), Text('9ot 11', style: TextStyle(fontSize: 10)), Text('Oct 13', style: TextStyle(fontSize: 10)), Text('Oct 17', style: TextStyle(fontSize: 10)), Text('Oct 19', style: TextStyle(fontSize: 10)), Text('Oct 21', style: TextStyle(fontSize: 10)), Text('Oct 26', style: TextStyle(fontSize: 10)), Text('26', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildBillingDistributionCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Billing Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                          width: 180, height: 180,
                          child: CircularProgressIndicator(value: 1.0, strokeWidth: 40, color: Colors.blueGrey.shade100, backgroundColor: Colors.transparent)
                       ),
                       SizedBox(
                          width: 180, height: 180,
                          child: CircularProgressIndicator(value: 0.9, strokeWidth: 40, color: Colors.teal.shade500, backgroundColor: Colors.transparent)
                       ),
                       const SizedBox(
                          width: 180, height: 180,
                          child: CircularProgressIndicator(value: 0.72, strokeWidth: 40, color: Color(0xFF0F4C81), backgroundColor: Colors.transparent)
                       ),
                       Positioned(bottom: 30, right: 30, child: const Text('72%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                       Positioned(left: 10, child: const Text('18%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                       Positioned(top: 15, child: const Text('10%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    ]
                 )
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, color: const Color(0xFF0F4C81)), const SizedBox(width: 4), const Text('Paid', style: TextStyle(fontSize: 11))]), const Text('72%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, color: Colors.teal.shade500), const SizedBox(width: 4), const Text('Pending', style: TextStyle(fontSize: 11))]), const Text('18%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, color: Colors.blueGrey.shade100), const SizedBox(width: 4), const Text('Overdue', style: TextStyle(fontSize: 11))]), const Text('10%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                 ]
              ),
              const SizedBox(height: 8),
           ]
        ),
     );
  }

  Widget _buildRecentInvoicesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Invoices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All Chart', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Invoice ID', 'Patient', 'Clinic Location', 'Date', 'Amount', 'Status'],
                    data: const [
                       {'id': '10F4081', 'pn': 'Patient Chen', 'loc': 'Morth Lane', 'd': '07/27/2023', 's': 'Paid'},
                       {'id': '10F4002', 'pn': 'Esiiim Chen', 'loc': 'Clinic Lane', 'd': '03/27/2023', 's': 'Paid'},
                       {'id': '10F4003', 'pn': 'Sarah Chen', 'loc': 'Morth Lane', 'd': '03/27/2023', 's': 'Pending'},
                       {'id': '10F4004', 'pn': 'Patient Chen', 'loc': 'Morth Lane', 'd': '07/27/2023', 's': 'Paid'},
                       {'id': '10F4005', 'pn': 'Keliin Chen', 'loc': 'Clinic Lane', 'd': '03/29/2023', 's': 'Overdue'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['id']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['pn']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['loc']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['d']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(_buildSmallPill(data['s']!)),
                       DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('View', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 11)))),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildSmallPill(String s) {
     Color bg;
     if (s == 'Paid') bg = Colors.teal.shade500;
     else if (s == 'Pending') bg = Colors.orange;
     else bg = Colors.amber;
     return Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Text(s, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)));
  }

  Widget _buildMonthlyGoalsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Monthly Goals Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.rectangle)), const SizedBox(width: 4), const Text('Goal', style: TextStyle(fontSize: 10))]),
                          const SizedBox(width: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade400, shape: BoxShape.rectangle)), const SizedBox(width: 4), const Text('Actual', style: TextStyle(fontSize: 10))]),
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
                             _ChartLineEmpty('50k'), _ChartLineEmpty('40k'), _ChartLineEmpty('30k'), _ChartLineEmpty('20k'), _ChartLineEmpty('10k'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildGoalCol('1', 0.8, 0.5),
                                   _buildGoalCol('2', 0.45, 0.4),
                                   _buildGoalCol('4', 0.6, 0.55),
                                   _buildGoalCol('6', 0.8, 0.65),
                                   _buildGoalCol('7', 0.5, 0.7),
                                   _buildGoalCol('8', 0.45, 0.85),
                                   _buildGoalCol('10', 0.55, 0.45),
                                   _buildGoalCol('11', 0.5, 0.8),
                                   _buildGoalCol('12', 0.9, 0.7),
                                ]
                             )
                          )
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildGoalCol(String lbl, double hGoal, double hActual) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 Container(width: 6, height: 210 * hGoal, decoration: const BoxDecoration(color: Color(0xFF0F4C81))),
                 const SizedBox(width: 2),
                 Container(width: 6, height: 210 * hActual, decoration: BoxDecoration(color: Colors.teal.shade500)),
              ]
           ),
           const SizedBox(height: 4),
           Text(lbl, style: const TextStyle(fontSize: 9, color: Colors.black87)),
        ]
     );
  }
}

class _UpwardWavePainter extends CustomPainter {
   final Color strokeColor;
   final Color fillColor;
   final bool hasPoint;
   const _UpwardWavePainter(this.strokeColor, this.fillColor, this.hasPoint);

   @override
   void paint(Canvas canvas, Size size) {
      final paint = Paint()..color = strokeColor..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = fillColor..style = PaintingStyle.fill;
      final path = Path();
      
      path.moveTo(0, size.height * 0.8);
      path.quadraticBezierTo(size.width * 0.2, size.height * 0.2, size.width * 0.4, size.height * 0.6);
      path.quadraticBezierTo(size.width * 0.7, size.height, size.width * 0.8, size.height * 0.1);
      path.lineTo(size.width, size.height * 0.3);

      final areaPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, paint);
      
      if (hasPoint) {
         canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.1), 4, Paint()..color = strokeColor);
         canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.1), 2, Paint()..color = Colors.white);
      }
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DualWavePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      
      final fillT = Paint()..color = Colors.teal.shade500.withOpacity(0.1)..style = PaintingStyle.fill;
      final fillB = Paint()..color = Colors.blue.withOpacity(0.05)..style = PaintingStyle.fill;
      
      // Teal path
      final pT = Path();
      pT.moveTo(0, size.height * 0.9);
      pT.quadraticBezierTo(size.width * 0.2, size.height * 0.4, size.width * 0.4, size.height * 0.7);
      pT.quadraticBezierTo(size.width * 0.6, size.height * 0.1, size.width * 0.8, size.height * 0.6);
      pT.quadraticBezierTo(size.width * 0.9, size.height * 0.8, size.width, size.height * 0.3);
      
      final aT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aT, fillT);
      canvas.drawPath(pT, paintT);
      
      // Blue path
      final pB = Path();
      pB.moveTo(0, size.height * 0.95);
      pB.quadraticBezierTo(size.width * 0.2, size.height * 0.6, size.width * 0.4, size.height * 0.65);
      pB.quadraticBezierTo(size.width * 0.6, size.height * 0.65, size.width * 0.8, size.height * 0.5);
      pB.quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width, size.height * 0.45);
      
      final aB = Path.from(pB)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aB, fillB);
      canvas.drawPath(pB, paintB);
      
      // Base flat $1,500 line
      canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 2);

      // Tooltips
      canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.3), 6, Paint()..color = Colors.teal);
      canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.3), 3, Paint()..color = Colors.white);

      canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.55), 6, Paint()..color = const Color(0xFF0F4C81));
      canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.55), 3, Paint()..color = Colors.white);

      final r = RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.6, size.height * 0.15), width: 70, height: 24), const Radius.circular(4));
      canvas.drawRRect(r, Paint()..color = const Color(0xFF0F4C81));
      
      final span = TextSpan(text: '\$3,245,670', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold));
      final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(size.width * 0.6 - 30, size.height * 0.15 - 6));
      
      // Link line
      canvas.drawLine(Offset(size.width * 0.6, size.height * 0.3 - 6), Offset(size.width * 0.6, size.height * 0.15 + 12), Paint()..color = Colors.grey);
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartLine extends StatelessWidget {
   final String lbl;
   const _ChartLine(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 40, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            SizedBox(child: Divider(color: Colors.grey.shade300, height: 1)),
         ]
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
            SizedBox(width: 24, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            SizedBox(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
