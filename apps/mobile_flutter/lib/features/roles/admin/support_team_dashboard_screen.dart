import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SupportTeamDashboardScreen extends StatelessWidget {
  const SupportTeamDashboardScreen({super.key});

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
                        Text('Support Team Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        SizedBox(height: 4),
                        Text('Good Morning, Sarah Jenkins', style: TextStyle(color: Colors.black87, fontSize: 16)),
                        SizedBox(height: 2),
                        Text('Support Lead', style: TextStyle(color: Colors.black54, fontSize: 11)),
                     ]
                  ),
                  Row(
                     children: [
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle), child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 100,
               children: [
                  _buildMetricCard('Active Franchise Locations', '312'),
                  _buildMetricCard('Open Tickets', '58'),
                  _buildMetricCard('Total Patients Managed', '1.2M'),
                  _buildMetricCard('Patient Satisfaction', '96.7%'),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 400,
               children: [
                  _buildSupportTicketTrendCard(),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        Expanded(child: _buildOpenTicketsByTypeCard()),
                        const SizedBox(height: 16),
                        Expanded(child: _buildPatientVolumeCard()),
                     ]
                  ),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildRecentSupportTicketsTable(),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        _buildSystemStatusCard().withHeight(120),
                        const SizedBox(height: 16),
                        Expanded(child: _buildPendingUrgentCasesCard()),
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

  Widget _buildMetricCard(String title, String val) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(12),
           border: Border.all(color: Colors.grey.shade300),
           gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Colors.blueGrey.shade50.withOpacity(0.5)]),
           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
        ),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
              const SizedBox(height: 8),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
           ]
        ),
     );
  }

  Widget _buildSupportTicketTrendCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Support Ticket Trend (Last 30 Days)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                       decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                       child: Row(
                          children: [
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black12))), child: const Text('Week', style: TextStyle(fontSize: 11))),
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, border: const Border(right: BorderSide(color: Colors.black12))), child: const Text('Month', style: TextStyle(fontSize: 11))),
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: const Text('Year', style: TextStyle(fontSize: 11))),
                          ]
                       )
                    )
                 ]
              ),
              const SizedBox(height: 12),
              Row(
                 children: [
                    Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Tickets opened', style: TextStyle(fontSize: 11))]),
                    const SizedBox(width: 16),
                    Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Resolved', style: TextStyle(fontSize: 11))]),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('70'), _ChartLineEmpty('60'), _ChartLineEmpty('50'), _ChartLineEmpty('40'), _ChartLineEmpty('30'), _ChartLineEmpty('20'), _ChartLineEmpty('10'), _ChartLineEmpty('0'),
                          ]
                       ),
                       const Positioned(left: -20, top: 120, child: RotatedBox(quarterTurns: 3, child: Text('Tickets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))), // Rotated label
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _TicketTrendLinePainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Dct 3', style: TextStyle(fontSize: 10)), Text('Dct 6', style: TextStyle(fontSize: 10)), Text('Det 12', style: TextStyle(fontSize: 10)), Text('Dct 14', style: TextStyle(fontSize: 10)), Text('Dct 24', style: TextStyle(fontSize: 10)), Text('Dct 30', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              ),
              const Center(child: Text('Dates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
           ]
        ),
     );
  }

  Widget _buildOpenTicketsByTypeCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Open Tickets by Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('80'), _ChartLineEmpty('60'), _ChartLineEmpty('40'), _ChartLineEmpty('20'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildSingleColBar('Appointments', 0.85),
                                   _buildSingleColBar('Billing', 0.65),
                                   _buildSingleColBar('Clinical', 0.8),
                                   _buildSingleColBar('Tech Support', 0.4),
                                ]
                             )
                          )
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildSingleColBar(String lbl, double h) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(width: 32, height: 110 * h, color: const Color(0xFF0F4C81)),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 9, color: Colors.black87)),
        ]
     );
  }

  Widget _buildPatientVolumeCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Patient Volume & Franchise Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('10M'), _ChartLineEmpty('15M'), _ChartLineEmpty('100'), _ChartLineEmpty('5M'), _ChartLineEmpty('0'), // Literal typos (y-axis jumping)
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildDualVolumeCol('Jan', 0.4, 0.6),
                                   _buildDualVolumeCol('Feb', 0.5, 0.7),
                                   _buildDualVolumeCol('Mar', 0.8, 0.5),
                                   _buildDualVolumeCol('Apr', 0.55, 0.8),
                                   _buildDualVolumeCol('May', 0.7, 0.95),
                                   _buildDualVolumeCol('Jun', 0.65, 0.95),
                                ]
                             )
                          )
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildDualVolumeCol(String lbl, double h1, double h2) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Container(width: 10, height: 110 * h1, color: const Color(0xFF0F4C81)),
                 const SizedBox(width: 4),
                 Container(width: 10, height: 110 * h2, color: Colors.teal.shade500),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 9, color: Colors.black87)),
        ]
     );
  }

  Widget _buildRecentSupportTicketsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Support Tickets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                       children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)), child: const Text('View All Tickets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                          const SizedBox(width: 12),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(4)), child: const Text('Export Data', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['ID', 'Franchise', 'Patient', 'Issue', 'Status', 'Assigned To', 'Last Updated'],
                    data: const [
                       {'id': '#12405', 'f': 'GreenValley Health', 'p': 'John D.', 'i': 'Appointment Scheduling', 's': 'In Progress', 'a': 'Alex R.', 'l': 'Feb 17, 2021 AM'},
                       {'id': '#12404', 'f': 'Oakwood Clinic', 'p': 'Maria L.', 'i': 'Billing Dispute', 's': 'Pending', 'a': 'Sarah J.', 'l': 'Jan 17, 2021 AM'},
                       {'id': '#12403', 'f': 'Oakwood Clinic', 'p': 'Maria L.', 'i': 'Billing Dispute', 's': 'Pending', 'a': 'Sarah J.', 'l': 'Feb 17, 2021 AM'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['id']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['f']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['p']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['i']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildTablePill(data['s']!)),
                       DataCell(Text(data['a']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['l']!, style: const TextStyle(fontSize: 11))),
                    ],
                 )
              ),
              const Divider(),
              Center(child: Container(width: 200, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)))),
           ]
        ),
     );
  }

  Widget _buildTablePill(String s) {
     final bool inProgress = s == 'In Progress';
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: inProgress ? Colors.teal.shade500 : const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(16)),
        child: Text(s, style: const TextStyle(color: Colors.white, fontSize: 10))
     );
  }

  Widget _buildSystemStatusCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('System Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Network', style: TextStyle(fontSize: 12)),
                    Text('Online', style: TextStyle(color: Colors.teal, fontSize: 12)),
                 ]
              ),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Services', style: TextStyle(fontSize: 12)),
                    Text('Operational', style: TextStyle(color: Colors.teal, fontSize: 12)),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildPendingUrgentCasesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Pending Urgent Cases', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Column(
                    children: [
                       _buildUrgentRow('Pending Urgent Cases 0', 'List 7 minutes ago', Colors.teal.shade500),
                       const SizedBox(height: 16),
                       _buildUrgentRow('Pending Urgent Cases 2', 'Last 3 minrtes ago', const Color(0xFF0F4C81)), // Literal typo
                       const SizedBox(height: 16),
                       _buildUrgentRow('Pending Urgent Cases 5', 'List 5 minutes ago', Colors.grey.shade400),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildUrgentRow(String title, String sub, Color c) {
     return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(margin: const EdgeInsets.only(top: 4), width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
           const SizedBox(width: 8),
           Expanded(
              child: Column(
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

class _TicketTrendLinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      
      final fillMix = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade100.withOpacity(0.3), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final ptsB = [0.95, 0.4, 0.7, 0.35, 0.65, 0.4, 0.2, 0.6, 0.45, 0.65, 0.4];
      final ptsT = [0.9, 0.6, 0.75, 0.45, 0.55, 0.45, 0.55, 0.5, 0.6, 0.65, 0.6];
      
      final pB = Path();
      final pT = Path();
      
      final w = size.width / 10;
      
      pB.moveTo(0, size.height * ptsB[0]);
      pT.moveTo(0, size.height * ptsT[0]);

      for(int i=1; i<11; i++) {
         pB.quadraticBezierTo(w * (i - 0.5), size.height * ptsB[i-1], w * i, size.height * ptsB[i]);
         pT.quadraticBezierTo(w * (i - 0.5), size.height * ptsT[i-1], w * i, size.height * ptsT[i]);
      }
      
      // Bottom path gradient trace
      final aB = Path.from(pB)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aB, fillMix);

      canvas.drawPath(pB, paintB);
      canvas.drawPath(pT, paintT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 24, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            Expanded(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
