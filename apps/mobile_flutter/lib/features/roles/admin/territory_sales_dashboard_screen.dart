import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritorySalesDashboardScreen extends StatelessWidget {
  const TerritorySalesDashboardScreen({super.key});

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
                  Row(
                     children: [
                        const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                        const SizedBox(width: 12),
                        const Text('Welcome,', style: TextStyle(color: Colors.black87, fontSize: 16)),
                        const SizedBox(width: 6),
                        const Text('Sarah J.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                     ]
                  ),
                  Row(
                     children: [
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 20)),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 32),
                        Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: Row(children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Row(
                     children: [
                        const Text('Date Range', style: TextStyle(color: Colors.black87, fontSize: 12)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('Last 90 Days', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                        const SizedBox(width: 16),
                        const Text('Filter', style: TextStyle(color: Colors.black87, fontSize: 12)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('Northeast', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 120,
               children: [
                  _buildMetricCard('TOTAL TERRITORY REVENUE', '\$4.82M', '+8.4%', 'vs Last Month', Colors.teal.shade50, Colors.teal),
                  _buildMetricCard('TOTAL ACTIVE FACILITIES', '124', '6 ', 'New', Colors.blue.shade50, Colors.black87),
                  _buildMetricCard('REVENUE GOAL ACHIEVEMENT', '87%', 'Proj. ', '\$5.54M', Colors.blueGrey.shade50, Colors.black87),
                  _buildMetricCard('SALES TEAM AVG. ATTAINMENT', '92%', '14 ', 'Reps', Colors.teal.shade50, Colors.black87),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 3,
               desktopMainAxisExtent: 360,
               children: [
                  _buildRegionalRevenueHeatmapCard(),
                  _buildTerritorySalesFunnelCard(),
                  _buildRegionalRevenueHeatmapCard(), // Blank filler to map grid correctly for BD
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildTopFacilitiesCard(),
                  _buildKeyAccountCard(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String val, String pre, String sub, Color gradientBase, Color highlight) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(12),
           border: Border.all(color: Colors.grey.shade200),
           gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, gradientBase]),
           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
        ),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black87)),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              Row(
                 children: [
                    Text(pre, style: TextStyle(color: highlight, fontWeight: highlight == Colors.teal ? FontWeight.bold : FontWeight.normal, fontSize: 11)),
                    Text(sub, style: TextStyle(color: highlight == Colors.teal ? Colors.black54 : Colors.black87, fontSize: 11)),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildRegionalRevenueHeatmapCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('REGIONAL REVENUE HEATMAP - Q3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 4),
                          Text('U.S. Northeast Territory', style: TextStyle(color: Colors.black87, fontSize: 12)),
                       ]
                    ),
                    Row(
                       children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: const Text('Facilitys', style: TextStyle(fontSize: 11))), // Literal typo match
                          const SizedBox(width: 8),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('All Density', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Positioned.fill(
                          child: Opacity(
                             opacity: 0.1,
                             child: Container(decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'), fit: BoxFit.cover, alignment: Alignment.topRight)))
                          )
                       ),
                       Positioned.fill(child: CustomPaint(painter: _FakeHeatmapPainter())),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTerritorySalesFunnelCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('TERRITORY SALES FUNNEL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              const Text('Prospecting -> Proposal -> Negotiation -> Closed Win/Loss', style: TextStyle(fontSize: 10, color: Colors.black87)),
              const SizedBox(height: 24),
              const Expanded(flex: 3, child: SizedBox(width: double.infinity, child: CustomPaint(painter: _FunnelPainter()))),
              const SizedBox(height: 24),
              Expanded(
                 flex: 4,
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text('Deal Stages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                       const SizedBox(height: 12),
                       _buildDealRow(const Color(0xFF0F4C81), 'Discovery', '45', '\$3.1M'),
                       const SizedBox(height: 10),
                       _buildDealRow(Colors.blue.shade700, 'Evaluation', '28', '\$2.6M'),
                       const SizedBox(height: 10),
                       _buildDealRow(Colors.teal.shade500, 'Proposal', '19', '\$1.9M'),
                       const SizedBox(height: 10),
                       _buildDealRow(Colors.teal.shade300, 'Closed Won', '11', '\$1.02M'),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildDealRow(Color c, String stage, String count, String val) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)), const SizedBox(width: 8), Text(stage, style: const TextStyle(fontSize: 11))]),
           Row(children: [SizedBox(width: 30, child: Text(count, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))), const SizedBox(width: 24), SizedBox(width: 50, child: Text(val, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))]),
        ]
     );
  }

  Widget _buildTopFacilitiesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('TOP PERFORMING FACILITIES (Q3)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Facility Name', 'Franchisee', 'Q3 Revenue', 'Growth %', 'Rank'],
                    data: const [
                       {'n': 'Facility Name 1', 'f': 'Franchisee', 'rev': '\$4.8M', 'grw': '8.4%', 'r': '1'},
                       {'n': 'Facility Name 2', 'f': 'Franchisee', 'rev': '\$3.2M', 'grw': '3.2%', 'r': '2'},
                       {'n': 'Facility Name 3', 'f': 'Franchisee', 'rev': '\$2.6M', 'grw': '4.4%', 'r': '3'},
                       {'n': 'Facility Name 4', 'f': 'Franchisee', 'rev': '\$1.9M', 'grw': '3.0%', 'r': '4'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['n']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['f']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Row(children: [SizedBox(width: 40, child: Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))), Container(width: double.parse(data['r']!) == 1 ? 24 : double.parse(data['r']!) == 4 ? 12 : 18, height: 4, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(2)))])),
                       DataCell(Row(children: [const Icon(Icons.arrow_drop_up, color: Colors.teal, size: 14), Text('${data['grw']}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11))])),
                       DataCell(Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: data['r'] == '4' ? Colors.amber : Colors.green, shape: BoxShape.circle)), const SizedBox(width: 8), Text(data['r']!, style: const TextStyle(fontSize: 11))])),
                    ],
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildKeyAccountCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('KEY ACCOUNT OPPORTUNITIES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Facility', 'Potential Value', 'Contact', 'Stage', 'Probability'],
                    data: const [
                       {'n': 'Facility 1', 'v': '\$33.1M', 'c': 'Contact J.', 's': 'Success', 'p': '80%'},
                       {'n': 'Facility 2', 'v': '\$22.6M', 'c': 'Costonier R.', 's': 'Doscovery', 'p': '40%'}, // Literal typo
                       {'n': 'Facility 3', 'v': '\$32.6M', 'c': 'Contact', 's': 'Success', 'p': '30%'},
                       {'n': 'Facility 4', 'v': '\$23.5M', 'c': 'Danad J.', 's': 'Success', 'p': '50%'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['n']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['v']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['c']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['s']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['p']!, style: const TextStyle(fontSize: 11))),
                    ],
                 )
              ),
           ]
        ),
     );
  }
}

class _FakeHeatmapPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final blurPaintY = Paint()..color = Colors.amber.withOpacity(0.4)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
      final blurPaintB = Paint()..color = Colors.blue.withOpacity(0.3)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      
      final ptsCenter = [Offset(size.width * 0.6, size.height * 0.7), Offset(size.width * 0.7, size.height * 0.8), Offset(size.width * 0.5, size.height * 0.9)];
      for (var p in ptsCenter) { canvas.drawCircle(p, 30, blurPaintY); }

      final ptsBlue = [Offset(size.width * 0.4, size.height * 0.4), Offset(size.width * 0.8, size.height * 0.5), Offset(size.width * 0.3, size.height * 0.6)];
      for (var p in ptsBlue) { canvas.drawCircle(p, 40, blurPaintB); }
      
      var rnd = [
        [0.2, 0.4, Colors.teal], [0.35, 0.45, Colors.teal], [0.45, 0.42, Colors.teal], [0.55, 0.4, const Color(0xFF0F4C81)], 
        [0.3, 0.6, Colors.teal], [0.25, 0.8, Colors.teal], [0.4, 0.85, const Color(0xFF0F4C81)], [0.6, 0.7, Colors.amber],
        [0.7, 0.8, const Color(0xFF0F4C81)], [0.55, 0.85, Colors.teal], [0.85, 0.4, Colors.teal], [0.8, 0.5, Colors.teal],
        [0.72, 0.6, const Color(0xFF0F4C81)], [0.75, 0.65, Colors.teal] 
      ];
      
      for (var r in rnd) {
         final pt = Offset(size.width * (r[0] as double), size.height * (r[1] as double));
         final col = r[2] as Color;
         
         canvas.drawCircle(pt, 12, Paint()..color = Colors.white..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2));
         
         final path = Path();
         path.moveTo(pt.dx, pt.dy + 12);
         path.quadraticBezierTo(pt.dx - 8, pt.dy + 4, pt.dx - 8, pt.dy - 2);
         path.arcToPoint(Offset(pt.dx + 8, pt.dy - 2), radius: const Radius.circular(8));
         path.quadraticBezierTo(pt.dx + 8, pt.dy + 4, pt.dx, pt.dy + 12);
         
         canvas.drawPath(path, Paint()..color = col);
         canvas.drawCircle(Offset(pt.dx, pt.dy - 3), 3, Paint()..color = Colors.white);
      }
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FunnelPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final p1 = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.fill;
      final p2 = Paint()..color = Colors.blue.shade700..style = PaintingStyle.fill;
      final p3 = Paint()..color = Colors.teal.shade500..style = PaintingStyle.fill;
      final p4 = Paint()..color = Colors.teal.shade300..style = PaintingStyle.fill;
      
      final cx = size.width / 2;
      double y = 0;
      
      void drawTrapezoid(double wTop, double wBot, double h, Paint paint) {
         final path = Path();
         path.moveTo(cx - wTop/2, y);
         path.lineTo(cx + wTop/2, y);
         path.lineTo(cx + wBot/2, y + h);
         path.lineTo(cx - wBot/2, y + h);
         path.close();
         canvas.drawPath(path, paint);
         y += h + 2; // Add gap
      }
      
      drawTrapezoid(200, 100, 60, p1);
      drawTrapezoid(94, 70, 15, p2);
      drawTrapezoid(66, 50, 15, p3);
      drawTrapezoid(50, 50, 10, p4); // straight bottom

      final tp = TextPainter(text: const TextSpan(children: [TextSpan(text: '\$12M\n', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), TextSpan(text: 'Potential Pipeline', style: TextStyle(color: Colors.white, fontSize: 10))]), textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(cx - tp.width/2, 10));

      canvas.drawLine(Offset(cx - 20, 50), Offset(cx + 20, 50), Paint()..color = Colors.white.withOpacity(0.5)..strokeWidth = 1);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
