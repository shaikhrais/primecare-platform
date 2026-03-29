import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:math' as math;

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Overview: Q3 2023 | HealthNet Franchise'), // Title overrides standard location
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Overview: Q3 2023 | HealthNet Franchise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Row(
                     children: [
                        Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 16),
                        const Icon(Icons.mail_outline, color: Colors.black54),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black54, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle), child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Row(
                           children: [
                              const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                              const SizedBox(width: 6),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 320,
               desktopCrossAxisCount: 2,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        const Text('Key Performance Indicators', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: PrimeResponsiveGrid(
                              desktopMainAxisExtent: 120,
                              tabletMainAxisExtent: 140,
                              mobileMainAxisExtent: 140,
                              desktopCrossAxisCount: 2,
                              children: [
                                 _buildSparklineCard('Active Clinics', '12/12', 'Modern Trend', const [0.7, 0.4, 0.5, 0.3, 0.6, 0.2, 0.7]),
                                 _buildSparklineCard('Total Patients', '24,850', 'Modern Trend', const [0.8, 0.6, 0.7, 0.5, 0.4, 0.6, 0.3]),
                                 _buildSparklineCard('Franchise Revenue', '\$4.2M', 'Modern Trend', const [0.6, 0.5, 0.8, 0.4, 0.3, 0.5, 0.4]),
                                 _buildSparklineCard('Staff Performance', '94.2%', 'Modern Trend', const [0.5, 0.4, 0.6, 0.5, 0.3, 0.4, 0.6]),
                              ]
                           )
                        )
                     ]
                  ),
                  _buildRevenueGrowthCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 540,
               desktopCrossAxisCount: 2,
               children: [
                  _buildClinicNetworkOverviewCard(),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        Expanded(
                           flex: 5,
                           child: PrimeResponsiveGrid(
                              desktopMainAxisExtent: 260,
                              desktopCrossAxisCount: 2,
                              children: [
                                 _buildEfficiencyTableCard(),
                                 _buildPatientDemographicsCard(),
                              ]
                           )
                        ),
                        Expanded(
                           flex: 4,
                           child: PrimeResponsiveGrid(
                              desktopMainAxisExtent: 200,
                              desktopCrossAxisCount: 2,
                              children: [
                                 _buildAppointmentStatisticsCard(),
                                 _buildPatientFeedbackScoreCard(),
                              ]
                           )
                        ),
                     ]
                  ),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 220,
               desktopCrossAxisCount: 2,
               children: [
                  _buildRecentFranchiseActivityCard(),
                  _buildActionableInsightsCard(),
               ]
            ),
            const SizedBox(height: 32),
         ]
        ),
      ),
    );
  }

  Widget _buildSparklineCard(String title, String val, String sub, List<double> pts) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]), // 3D shadow required
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                       ]
                    ),
                    SizedBox(
                       width: 80, height: 40,
                       child: CustomPaint(painter: _MiniGradientSparklinePainter(Colors.teal.shade500, pts))
                    )
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildRevenueGrowthCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Revenue Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('Menthly twel v', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])), // Literal typo mapping
                 ]
              ),
              const SizedBox(height: 8),
              Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    Row(children: [Container(width: 12, height: 2, color: Colors.teal.shade500), const SizedBox(width: 6), const Text('Revenue', style: TextStyle(fontSize: 10))]),
                    const SizedBox(width: 16),
                    Row(children: [Container(width: 12, height: 2, color: Colors.grey.shade400), const SizedBox(width: 6), const Text('Previous Year', style: TextStyle(fontSize: 10))]),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('\$90M'), _ChartLineEmpty('\$75M'), _ChartLineEmpty('\$40M'), _ChartLineEmpty('\$25M'), _ChartLineEmpty('0'), // Literal jumps on y-axis
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _RevenueGrowthPainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 10)), Text('Feb', style: TextStyle(fontSize: 10)), Text('Mar', style: TextStyle(fontSize: 10)), Text('Apr', style: TextStyle(fontSize: 10)), Text('May', style: TextStyle(fontSize: 10)), Text('Jun', style: TextStyle(fontSize: 10)), Text('Jul', style: TextStyle(fontSize: 10)), Text('Aug', style: TextStyle(fontSize: 10)), Text('Hep', style: TextStyle(fontSize: 10))])) // Literal typo Hep
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildClinicNetworkOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Clinic Network Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Text('Interactive Map', style: TextStyle(fontSize: 10)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 12)])),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 flex: 2,
                 child: Center(
                    child: Stack(
                       alignment: Alignment.center,
                       children: [
                          Opacity(opacity: 0.1, child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png', fit: BoxFit.contain)), // Abstract map substitute for layout sizing
                          // Draw specific literal pin groupings covering US nodes based on design
                          Positioned(left: 40, top: 40, child: _pin()),
                          Positioned(left: 60, top: 120, child: _pin()),
                          Positioned(left: 140, top: 80, child: _pin()),
                          Positioned(right: 80, top: 60, child: _pin()),
                          Positioned(right: 60, top: 100, child: _pin()),
                          Positioned(right: 120, bottom: 40, child: _pin()),
                       ]
                    )
                 )
              ),
              const SizedBox(height: 16),
              Expanded(
                 flex: 1,
                 child: Stack(
                    children: [
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(bottom: 24),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildMapBarCol(0.6, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.4, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.5, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.4, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.3, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.8, Colors.teal.shade500), // Middle block is teal
                                   _buildMapBarCol(0.6, Colors.teal.shade500),
                                   _buildMapBarCol(0.3, const Color(0xFF0F4C81)),
                                   _buildMapBarCol(0.5, const Color(0xFF0F4C81)),
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 0, right: 0, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
                          _XColMap('Mon\n12'), _XColMap('Tue\n14'), _XColMap('Max\n15'), _XColMap('Mon\n16'), _XColMap('Tue\n17'), _XColMap('Wed\n18'), _XColMap('Ttnu\n19'), _XColMap('Sat\n12'), _XColMap('Sun\n12'), // Literal typos (Max, Ttnu, Sat 12 reversing)
                       ]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _pin() => Container(width: 8, height: 12, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8))));

  Widget _buildMapBarCol(double h, Color c) {
     return Container(width: 16, height: 100 * h, color: c); // Map relative height 
  }

  Widget _buildEfficiencyTableCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Expanded(flex: 2, child: Text('Clinic', style: TextStyle(fontSize: 10, color: Colors.black54))),
                    Expanded(flex: 2, child: Text('Patients', style: TextStyle(fontSize: 10, color: Colors.black54))),
                    Expanded(flex: 2, child: Text('Revenue', style: TextStyle(fontSize: 10, color: Colors.black54))),
                    Expanded(flex: 2, child: Text('Efficiency', style: TextStyle(fontSize: 10, color: Colors.black54))),
                 ]
              ),
              const SizedBox(height: 8),
              Expanded(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildEffRow('Cllin 1', '\$62.2M', 0.6, 0.4), // Literal typographical formatting
                       _buildEffRow('Cllin 2', '\$34.2Ml', 0.8, 0.3), // Typo Ml
                       _buildEffRow('Cllin 3', '\$42.2M', 0.7, 0.5),
                       _buildEffRow('Cllix 4', '\$30.68M', 0.4, 0.6), // Typo Cllix
                       _buildEffRow('Cllin 5', '\$30.82%', 0.5, 0.7), // Typo % vs M
                       _buildEffRow('Clini 7', '\$33.67%', 0.4, 0.5), // Typo Clini
                       _buildEffRow('Cllin 7', '\$36.55%', 0.6, 0.6), // Duplicate 7
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildEffRow(String n, String eff, double h1, double h2) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(flex: 2, child: Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
           Expanded(flex: 2, child: Padding(padding: const EdgeInsets.only(right: 8), child: Container(height: 6, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: h1, child: Container(decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4))))))),
           Expanded(flex: 2, child: Padding(padding: const EdgeInsets.only(right: 8), child: Container(height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: h2, child: Container(decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4))))))),
           Expanded(flex: 2, child: Text(eff, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
        ]
     );
  }
  
  Widget _buildPatientDemographicsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Patient Demographics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                          width: 140, height: 140, // Pure Donut geometry scaling
                          child: CustomPaint(painter: _DemographicsPiePainter())
                       ),
                    ]
                 )
              ),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Age Groups', style: TextStyle(fontSize: 10))]),
                          const SizedBox(height: 8),
                          Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('10-4 maxns', style: TextStyle(fontSize: 10))]), // Literal typo mapping (instead of maybe 10-40 months?
                       ]
                    ),
                    const SizedBox(width: 16),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Gender', style: TextStyle(fontSize: 10))]),
                          const SizedBox(height: 8),
                          const SizedBox(height: 8), // spacer matching
                       ]
                    )
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildAppointmentStatisticsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Appointment Statistics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const Text('Line chart', style: TextStyle(color: Color(0xFF0F4C81), fontSize: 10)),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('250'), _ChartLineEmpty('200'), _ChartLineEmpty('150'), _ChartLineEmpty('100'), _ChartLineEmpty('50'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _ApptStatsPainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Men', style: TextStyle(fontSize: 9)), Text('Tue', style: TextStyle(fontSize: 9)), Text('Tue', style: TextStyle(fontSize: 9)), Text('Wed', style: TextStyle(fontSize: 9)), Text('Thu', style: TextStyle(fontSize: 9)), Text('Fri', style: TextStyle(fontSize: 9)), Text('Sat', style: TextStyle(fontSize: 9))])) // Literal typos Men, Tue, Tue
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildPatientFeedbackScoreCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Patient Feedback Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Expanded(
                 child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                          width: 160, height: 120, // Needle Gauge dimensions mapping Top bounded center
                          child: CustomPaint(painter: _NeedleGaugePainter())
                       ),
                       Positioned(
                          bottom: 20,
                          child: const Text('4.8/5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32))
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildRecentFranchiseActivityCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Recent Franchise Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('View all', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildActivityRowWrapper(Icons.notifications_none, 'Updates on Clinic Openings', 'Updater 17, 2023', '12/11ies'), // Literal Typo string Updater, 11ies
                       const Divider(height: 1),
                       _buildActivityRowWrapper(Icons.group_outlined, 'Staff Hires and Financial Data', 'Januaer 18, 2023', '\$4,55,500'), // Literal Typo Januaer, $4,55,500
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildActivityRowWrapper(IconData ic, String t, String sub, String tr) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
              children: [
                 Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.teal.shade50, shape: BoxShape.circle), child: Icon(ic, color: Colors.teal.shade600, size: 20)),
                 const SizedBox(width: 12),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                       Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                    ]
                 )
              ]
           ),
           Text(tr, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade700, fontSize: 12)),
        ]
     );
  }

  Widget _buildActionableInsightsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Actionable Insights', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('View more', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildInsightRowWrapper(Icons.bar_chart, 'Increase Staff Training for Clinic 4', 'Increase Staff Training for Clinic in Sancelting Clinc 4'), // Literal Typo Sancelting
                       const Divider(height: 1),
                       _buildInsightRowWrapper(Icons.center_focus_strong_outlined, 'Optimize Marketing in Region West', 'Optimize marketino optimize Marketing in Region West'), // Literal Typo marketino optimize
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildInsightRowWrapper(IconData ic, String t, String sub) {
     return Row(
        children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: const Color(0xFF0F4C81), size: 20)),
           const SizedBox(width: 12),
           Expanded(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                 ]
              )
           )
        ]
     );
  }
}

class _ChartLineEmpty extends StatelessWidget {
   final String lbl;
   const _ChartLineEmpty(this.lbl);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 32, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            Expanded(child: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, style: BorderStyle.none))))),
         ]
      );
   }
}

class _XColMap extends StatelessWidget {
   final String lbl;
   const _XColMap(this.lbl);
   @override
   Widget build(BuildContext context) => Text(lbl, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: Colors.black87));
}

class _MiniGradientSparklinePainter extends CustomPainter {
   final Color cLine;
   final List<double> pts;
   const _MiniGradientSparklinePainter(this.cLine, this.pts);

   @override
   void paint(Canvas canvas, Size size) {
      final linePaint = Paint()..color = cLine..strokeWidth = 3..style = PaintingStyle.stroke;
      final fillPaint = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [cLine.withOpacity(0.4), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
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
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RevenueGrowthPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final pT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final fT = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.teal.shade500.withOpacity(0.4), Colors.teal.shade200.withOpacity(0.1)]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final pts = [0.8, 0.7, 0.7, 0.35, 0.5, 0.35, 0.2, 0.3, 0.1]; // Jan - Hep
      
      final path = Path();
      final w = size.width / 8;
      
      path.moveTo(0, size.height * pts[0]);
      for(int i=1; i<9; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * pts[i-1], w * i, size.height * pts[i]);
      }
      
      final aPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aPath, fT);
      canvas.drawPath(path, pT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DemographicsPiePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;
      
      final paintDB = Paint()..color = const Color(0xFF0F4C81)..style = PaintingStyle.stroke..strokeWidth = 28;
      final paintT = Paint()..color = Colors.teal.shade500..style = PaintingStyle.stroke..strokeWidth = 28;
      
      final rect = Rect.fromCircle(center: center, radius: radius - 14);
      final pi2 = 3.14159 * 2;
      
      final gap = 0.05;
      
      // 60 / 40 split visually
      canvas.drawArc(rect, -3.14159 / 2 + gap, pi2 * 0.60 - gap, false, paintDB);
      canvas.drawArc(rect, -3.14159 / 2 + pi2 * 0.60 + gap, pi2 * 0.40 - gap, false, paintT);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ApptStatsPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final pDB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 2..style = PaintingStyle.stroke;
      final fDB = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [const Color(0xFF0F4C81).withOpacity(0.2), Colors.transparent]).createShader(Rect.fromLTRB(0, 0, 0, size.height));
      
      final pts = [0.8, 0.6, 0.8, 0.6, 0.3, 0.6, 0.3]; // Men -> Sat
      
      final path = Path();
      final w = size.width / 6;
      
      path.moveTo(0, size.height * pts[0]);
      for(int i=1; i<7; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * pts[i-1], w * i, size.height * pts[i]);
      }
      
      final aPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aPath, fDB);
      canvas.drawPath(path, pDB);
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NeedleGaugePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final center = Offset(size.width / 2, size.height - 20); // Bottom center for semi-circle
      final radius = size.width / 2 - 16;
      
      // Background full grey arc
      final pBG = Paint()..color = Colors.grey.shade200..style = PaintingStyle.stroke..strokeWidth = 16..strokeCap = StrokeCap.butt;
      
      // Active teal arc (4.8/5 = 96%)
      final pT = Paint()..color = Colors.teal.shade600..style = PaintingStyle.stroke..strokeWidth = 16..strokeCap = StrokeCap.butt;
      
      final rect = Rect.fromCircle(center: center, radius: radius);
      
      final startAngles = -3.14159; // 180 deg
      final sweepTotal = 3.14159; // half circle
      final sweepActive = 3.14159 * 0.96; 
      
      // Draw arcs
      canvas.drawArc(rect, startAngles, sweepTotal, false, pBG);
      canvas.drawArc(rect, startAngles, sweepActive, false, pT);
      
      // Draw Needle
      final needleAngle = startAngles + sweepActive; // Point to end of active arc
      final needleLength = radius - 8;
      
      final nx = center.dx + needleLength * math.cos(needleAngle);
      final ny = center.dy + needleLength * math.sin(needleAngle);
      
      final pNeedle = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 4..strokeCap = StrokeCap.round;
      canvas.drawLine(center, Offset(nx, ny), pNeedle);
      
      // Center dot
      canvas.drawCircle(center, 8, Paint()..color = const Color(0xFF0F4C81));
   }
   @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
