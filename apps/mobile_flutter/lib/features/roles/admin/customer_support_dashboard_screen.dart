import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomerSupportDashboardScreen extends StatelessWidget {
  const CustomerSupportDashboardScreen({super.key});

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
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                  const Text('Support Operations Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Row(
                     children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Icon(Icons.calendar_today, size: 14, color: Colors.black87), SizedBox(width: 8), Text('Dec 21 - 18, 2023', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.date_range, size: 14, color: Colors.grey)])),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), child: Row(children: const [Icon(Icons.filter_list, color: Colors.white, size: 16), SizedBox(width: 8), Text('Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16)])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 120,
               children: [
                  _buildMetricCard(Icons.library_books, Colors.blue.shade50, const Color(0xFF0F4C81), 'Total Tickets', '64', '+8.1%', Colors.green, _buildMiniColArray(const Color(0xFF0F4C81), const [0.3, 0.4, 0.3, 0.7, 0.8, 0.9, 0.6, 0.7, 0.8, 0.5])),
                  _buildMetricCard(Icons.drafts, Colors.orange.shade50, Colors.deepOrange, 'Open Tickets', '23', 'Active', Colors.black87, _buildMiniColArray(const Color(0xFF0F4C81), const [0.4, 0.5, 0.3, 0.4, 0.8, 0.6, 0.2, 0.4, 0.8, 0.6])),
                  _buildMetricCard(Icons.schedule, Colors.teal.shade50, Colors.teal.shade500, 'Avg. Resolution Time', '3h 45m', '-12%', Colors.teal, _buildMiniColArray(Colors.teal.shade500, const [0.2, 0.3, 0.2, 0.3, 0.8, 0.9, 0.7, 0.8, 0.85, 0.9])),
                  _buildMetricCard(Icons.thumb_up_alt_outlined, Colors.teal.shade50, Colors.teal.shade500, 'Patient Satisfaction', '4.9/5', '98% Positive', Colors.black87, _buildMiniColArray(Colors.teal.shade500, const [0.7, 0.8, 0.75, 0.8, 0.85, 0.8, 0.9, 0.8, 0.9, 0.85])),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildDualVolumeDistributionCard(),
                  _buildFranchisePerformanceCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildRecentSupportTicketsTable(),
                  _buildAgentActivityCard(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildMiniColArray(Color col, List<double> heights) {
     return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: heights.map((h) => Padding(padding: const EdgeInsets.only(right: 3), child: Container(width: 4, height: 40 * h, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(2))))).toList(),
     );
  }

  Widget _buildMetricCard(IconData ic, Color icBg, Color icCol, String title, String val, String sub, Color subCol, Widget chart) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(
                       children: [
                          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: icBg, borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: icCol, size: 16)),
                          const SizedBox(width: 8),
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
                       ]
                    ),
                    const Icon(Icons.more_vert, color: Colors.grey, size: 16),
                 ]
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          Text(sub, style: TextStyle(color: subCol, fontSize: 11)),
                       ]
                    ),
                    chart,
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildDualVolumeDistributionCard() {
     return PrimeCareCard(
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Expanded(
                 flex: 2,
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                   Text('Ticket Volume & Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                   SizedBox(height: 4),
                                   Text('Line Chart', style: TextStyle(color: Colors.black87, fontSize: 11)),
                                ]
                             ),
                             Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(24)),
                                child: Row(
                                   children: [
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black12))), child: const Text('Daily', style: TextStyle(fontSize: 10))),
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black12))), child: const Text('Weekly', style: TextStyle(fontSize: 10))),
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.horizontal(right: Radius.circular(24))), child: Row(children: const [Text('7 days', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 14)])),
                                   ]
                                )
                             )
                          ]
                       ),
                       const SizedBox(height: 16),
                       Expanded(
                          child: Stack(
                             children: [
                                Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: const [
                                      _ChartLineEmpty('100'), _ChartLineEmpty('75'), _ChartLineEmpty('50'), _ChartLineEmpty('25'), _ChartLineEmpty('0'),
                                   ]
                                ),
                                Positioned.fill(
                                   child: Padding(
                                      padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                                      child: Stack(
                                         children: [
                                            Positioned.fill(
                                               child: CustomPaint(painter: _TicketVolumeLinePainter())
                                            )
                                         ]
                                      )
                                   )
                                ),
                                Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Sun', style: TextStyle(fontSize: 10)), Text('Mon', style: TextStyle(fontSize: 10)), Text('Tue', style: TextStyle(fontSize: 10)), Text('Wed', style: TextStyle(fontSize: 10)), Text('Thu', style: TextStyle(fontSize: 10)), Text('Fri', style: TextStyle(fontSize: 10)), Text('Sat', style: TextStyle(fontSize: 10))]))
                             ]
                          )
                       )
                    ]
                 )
              ),
              Container(width: 1, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 24)),
              Expanded(
                 flex: 1,
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       const Text('Ticket Status Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                       const SizedBox(height: 24),
                       Expanded(
                          child: Stack(
                             alignment: Alignment.center,
                             children: [
                                SizedBox(
                                   width: 160, height: 160,
                                   child: CustomPaint(painter: _TicketStatusPiePainter())
                                ),
                             ]
                          )
                       ),
                       const SizedBox(height: 16),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Resolved', style: TextStyle(fontSize: 10))]),
                             const SizedBox(width: 16),
                             Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.blue.shade600, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Open', style: TextStyle(fontSize: 10))]),
                             const SizedBox(width: 16),
                             Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('In Progress', style: TextStyle(fontSize: 10))]),
                          ]
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildFranchisePerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Franchise Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              const Text('Bar Chart', style: TextStyle(color: Colors.black87, fontSize: 11)),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('100'), _ChartLineEmpty('75'), _ChartLineEmpty('50'), _ChartLineEmpty('25'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, bottom: 20),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildPerfCol(0.65, const Color(0xFF0F4C81)),
                                   _buildPerfCol(0.45, Colors.teal.shade500),
                                   _buildPerfCol(0.9, const Color(0xFF0F4C81)),
                                   _buildPerfCol(0.6, const Color(0xFF0F4C81)),
                                   _buildPerfCol(0.7, Colors.teal.shade500),
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [Text('Dallas', style: TextStyle(fontSize: 9)), Text('Miami', style: TextStyle(fontSize: 9)), Text('NYC', style: TextStyle(fontSize: 9)), Text('Chicago', style: TextStyle(fontSize: 9)), Text('Atlanta', style: TextStyle(fontSize: 9))]))
                    ]
                 )
              ),
              const SizedBox(height: 8),
              const Center(child: Text('Tickets Resolved', style: TextStyle(fontSize: 10))),
           ]
        )
     );
  }

  Widget _buildPerfCol(double h, Color c) {
     return Container(width: 16, height: 280 * h, color: c); // height relative approx
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
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('All Filter all', style: TextStyle(fontSize: 11))),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Ticket ID', 'Patient Name', 'Franchise', 'Subject', 'Status', 'Priority', 'Assigned Agent', 'Last Updated'],
                    data: const [
                       {'id': '1074020', 'n': 'Aarah Matth', 'f': 'Franchise', 'sub': 'Censrsmentinent ...', 's': 'Closed', 'p': 'High', 'a': 'Dr. Sarah Chen', 'l': 'Jun 13, 2023'},
                       {'id': '10F4031', 'n': 'Hamp Mami', 'f': 'Franchise', 'sub': 'Paotent suppeet ...', 's': 'In Progress', 'p': 'Med', 'a': 'Assigned Agent', 'l': 'Jun 13, 2023'},
                       {'id': '10F4022', 'n': 'Hamy Mamii', 'f': 'Franchise', 'sub': 'Vrail respens|rela...', 's': 'Open', 'p': 'Low', 'a': 'Assigned Agent', 'l': 'Jun 13, 2023'},
                       {'id': '10F4023', 'n': 'Maroi Miam', 'f': 'Franchise', 'sub': 'The askoransed k...', 's': 'Closed', 'p': 'Low', 'a': 'Assigned Agent', 'l': 'Jun 12, 2023'},
                       {'id': '10F4024', 'n': 'Bmen Month', 'f': 'Franchise', 'sub': 'The superent of f...', 's': 'Closed', 'p': 'High', 'a': 'Dr. Sarah Chen', 'l': 'Jun 12, 2023'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['id']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['f']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['sub']!, style: const TextStyle(fontSize: 11))),
                       DataCell(_buildStatusPill(data['s']!)),
                       DataCell(_buildPriorityPill(data['p']!)),
                       DataCell(Text(data['a']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['l']!, style: const TextStyle(fontSize: 11))),
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
     if (s == 'In Progress') { bg = Colors.orange.shade50; tx = Colors.deepOrange; }
     if (s == 'Open') { bg = Colors.blue.shade50; tx = const Color(0xFF0F4C81); }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(s, style: TextStyle(color: tx, fontSize: 10))
     );
  }

  Widget _buildPriorityPill(String p) {
     Color bg = Colors.red.shade50;
     Color tx = Colors.red.shade700;
     if (p == 'Med') { bg = Colors.amber.shade50; tx = Colors.amber.shade800; }
     if (p == 'Low') { bg = Colors.green.shade50; tx = Colors.green.shade700; }
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(p, style: TextStyle(color: tx, fontSize: 10))
     );
  }

  Widget _buildAgentActivityCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Agent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Expanded(flex: 3, child: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                    Expanded(flex: 2, child: Text('Tickets Handled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                    Expanded(flex: 1, child: Text('Avg T...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                 ]
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              Expanded(
                 child: Column(
                    children: [
                       _buildAgentRow('https://i.pravatar.cc/150?img=9', 'Dr. Sarah Chen', '64', '00:03:'),
                       _buildAgentRow('https://i.pravatar.cc/150?img=11', 'Marty Carker', '23', '00:03:'), // Typo in image
                       _buildAgentRow('https://i.pravatar.cc/150?img=12', 'Narho Bresen', '18', '00:01:'), // Typo
                       _buildAgentRow('https://i.pravatar.cc/150?img=13', 'Kada Rarnan', '10', '00:05:'), // Typo
                       _buildAgentRow('https://i.pravatar.cc/150?img=5', 'Jenriy Saorey', '9', '00:02:'), // Typo
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildAgentRow(String img, String n, String t, String avg) {
     return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Expanded(
                 flex: 3, 
                 child: Row(
                    children: [
                       CircleAvatar(radius: 12, backgroundImage: NetworkImage(img)),
                       const SizedBox(width: 8),
                       Text(n, style: const TextStyle(fontSize: 10)),
                    ]
                 )
              ),
              Expanded(flex: 2, child: Text(t, style: const TextStyle(fontSize: 10))),
              Expanded(flex: 1, child: Text(avg, style: const TextStyle(fontSize: 10))),
           ]
        )
     );
  }
}

class _TicketVolumeLinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      
      final fillT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade100.withOpacity(0.3), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final ptsB = [0.9, 0.6, 0.6, 0.45, 0.55, 0.55, 0.1]; // Sun - Sat (7 points)
      final ptsT = [0.85, 0.7, 0.8, 0.6, 0.75, 0.7, 0.8]; // Sun - Sat
      
      final pB = Path();
      final pT = Path();
      
      final w = size.width / 6;
      
      pB.moveTo(0, size.height * ptsB[0]);
      pT.moveTo(0, size.height * ptsT[0]);

      for(int i=1; i<7; i++) {
         pB.quadraticBezierTo(w * (i - 0.5), size.height * ptsB[i-1], w * i, size.height * ptsB[i]);
         pT.quadraticBezierTo(w * (i - 0.5), size.height * ptsT[i-1], w * i, size.height * ptsT[i]);
      }
      
      final aT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aT, fillT);

      canvas.drawPath(pB, paintB);
      canvas.drawPath(pT, paintT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TicketStatusPiePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 32;
      final paintMB = Paint()..color = Colors.blue.shade600..style = PaintingStyle.stroke..strokeWidth = 32;
      final paintT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 32;
      
      final rect = Rect.fromCircle(center: center, radius: radius - 16);
      
      // Arc logic drawing
      // 61% DB, 27% MB, 12% T
      // Total 100
      
      const double pi2 = 3.14159 * 2;
      
      final startDB = -3.14159 / 2;
      final sweepDB = pi2 * 0.61;
      
      final startMB = startDB + sweepDB;
      final sweepMB = pi2 * 0.27;
      
      final startT = startMB + sweepMB;
      final sweepT = pi2 * 0.12;
      
      canvas.drawArc(rect, startDB, sweepDB, false, paintDB);
      canvas.drawArc(rect, startMB, sweepMB, false, paintMB);
      canvas.drawArc(rect, startT, sweepT, false, paintT);
      
      // Calculate text positions manually passing offset
      _drawText(canvas, center.translate(50, 40), '61%'); // In DB
      _drawText(canvas, center.translate(-50, 0), '27%'); // In MB
      _drawText(canvas, center.translate(10, -50), '12%'); // In T
   }
   
   void _drawText(Canvas c, Offset at, String t) {
      final span = TextSpan(text: t, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold));
      final tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(c, at.translate(-tp.width/2, -tp.height/2));
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
