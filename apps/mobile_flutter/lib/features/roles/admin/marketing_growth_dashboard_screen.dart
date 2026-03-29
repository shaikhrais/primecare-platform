import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class MarketingGrowthDashboardScreen extends StatelessWidget {
  const MarketingGrowthDashboardScreen({super.key});

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
                  const Text('GROWTH DASHBOARD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 24),
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.add, color: Colors.black87, size: 16)),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle), child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 24),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                              const SizedBox(width: 12),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Welcome,', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                    Text('Dr. Sarah Evans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                 ]
                              ),
                           ]
                        )
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
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text('Growth Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                 Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Oct 1 - Oct 31, 2023', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
              ]
           ),
           const SizedBox(height: 24),
           PrimeResponsiveGrid(
              desktopCrossAxisCount: 4,
              desktopMainAxisExtent: 120,
              children: [
                 _buildMetricCard('Total Revenue', '\$458,720', '12'),
                 _buildMetricCard('Patient Growth', '1,245', '18'),
                 _buildMetricCard('Marketing ROI', '3.8x', '6'),
                 _buildMetricCard('Local Visibility', '89%', '4'),
              ]
           ),
           const SizedBox(height: 24),
           _buildMonthlyFranchiseGrowthCard().withHeight(360),
           const SizedBox(height: 24),
           PrimeResponsiveGrid(
              desktopCrossAxisCount: 2,
              desktopMainAxisExtent: 340,
              children: [
                 _buildMarketingCampaignPerformanceCard(),
                 _buildLocalLocationPerformanceCard(),
              ]
           ),
        ]
     );
  }

  Widget _buildRightColumn() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           _buildGrowthAlertsPillCard(),
           const SizedBox(height: 24),
           _buildUpcomingCampaignsCard().withHeight(360),
           const SizedBox(height: 24),
           _buildGrowthAlertsFeedCard().withHeight(410), // fill remaining space
        ]
     );
  }

  Widget _buildMetricCard(String title, String val, String grw) {
     return Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              PrimeCareResponsiveKpiGrid(
 children: [const Icon(Icons.arrow_drop_up, color: Colors.teal, size: 16), Text('$grw%', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12))]),
           ]
        ),
     );
  }

  Widget _buildMonthlyFranchiseGrowthCard() {
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
                          Text('Monthly Franchise Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Revenue vs. Patients', style: TextStyle(color: Colors.black54, fontSize: 12)),
                       ]
                    ),
                    Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(24)),
                       child: PrimeCareResponsiveKpiGrid(
 children: [
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Revenue', style: TextStyle(fontSize: 12))]),
                             const SizedBox(width: 16),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Patients', style: TextStyle(fontSize: 12))]),
                          ]
                       )
                    )
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('2000'), _ChartLine('1500'), _ChartLine('1,000'), _ChartLine('500'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned.fill(
                                      child: CustomPaint(painter: _DualGrowthLinePainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize: 11)), Text('Feb', style: TextStyle(fontSize: 11)), Text('Mar', style: TextStyle(fontSize: 11)), Text('Apr', style: TextStyle(fontSize: 11)), Text('May', style: TextStyle(fontSize: 11)), Text('Jun', style: TextStyle(fontSize: 11)), Text('July', style: TextStyle(fontSize: 11)), Text('Aug', style: TextStyle(fontSize: 11))]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildMarketingCampaignPerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Marketing Campaign Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              const Text('Leads / Leads/ Cost', style: TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLineEmpty('200'), _ChartLineEmpty('120'), _ChartLineEmpty('80'), _ChartLineEmpty('40'), _ChartLineEmpty('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildGroupedCol('Social Media', 0.6, 0.3),
                                   _buildGroupedCol('Google Ads', 0.8, 0.5),
                                   _buildGroupedCol('Email', 0.4, 0.2),
                                   _buildGroupedCol('Local Events', 0.8, 0.4),
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

  Widget _buildGroupedCol(String lbl, double h1, double h2) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 Container(width: 14, height: 210 * h1, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(top: Radius.circular(2)))),
                 const SizedBox(width: 4),
                 Container(width: 14, height: 210 * h2, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ]
     );
  }

  Widget _buildLocalLocationPerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
              const Align(alignment: Alignment.centerLeft, child: Text('Local Location Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              SizedBox(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(width: 160, height: 160, child: CircularProgressIndicator(value: 0.65, strokeWidth: 36, backgroundColor: Colors.teal.shade500, color: const Color(0xFF0F4C81))),
                       const SizedBox(width: 32),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Top Performers (40%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]), const SizedBox(height: 16),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade600, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Growth Areas (25%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]), const SizedBox(height: 16),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Needs Focus (35%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                          ]
                       )
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildGrowthAlertsPillCard() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Growth Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 16),
           Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(24)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.emoji_events, color: Color(0xFF0F4C81), size: 16), SizedBox(width: 8), Text('Top Performe', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 12))])),
           const SizedBox(height: 12),
           Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(24)), child: PrimeCareResponsiveKpiGrid(
 children: [Icon(Icons.trending_up, color: Colors.teal.shade700, size: 16), const SizedBox(width: 8), Text('Growth Areas', style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 12))])),
           const SizedBox(height: 12),
           Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(24)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.lightbulb_outline, color: Color(0xFF0F4C81), size: 16), SizedBox(width: 8), Text('Needs Focus', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 12))])),
        ]
     );
  }

  Widget _buildUpcomingCampaignsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Upcoming Campa...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildCampaignRow(Icons.bolt, 'Social Blitz', 'Date ups your mi...', Colors.blue.shade50, const Color(0xFF0F4C81)),
                       _buildCampaignRow(Icons.mail_outline, 'Email Outrea...', 'Date up your mi...\nhealthcare mari...', Colors.blueGrey.shade50, const Color(0xFF0F4C81)),
                       _buildCampaignRow(Icons.location_on_outlined, 'Local Events', 'Lead out our bmr...\nmindimg are pos...', Colors.blueGrey.shade50, const Color(0xFF0F4C81)),
                    ]
                 )
              ),
              const SizedBox(height: 8),
              const Center(child: Text('More >', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 12))),
           ]
        ),
     );
  }

  Widget _buildCampaignRow(IconData ic, String title, String sub, Color bi, Color ti) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: bi, borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: ti, size: 20)),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                 ]
              )
           )
        ]
     );
  }

  Widget _buildGrowthAlertsFeedCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Growth Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildCampaignRow(Icons.notifications_none, 'Top Performers', 'Growth ensrram...', Colors.blue.shade50, const Color(0xFF0F4C81)),
                       _buildCampaignRow(Icons.warning_amber_rounded, 'Growth Areas', 'Growth siareas ...', Colors.teal.shade50, Colors.teal.shade700),
                       _buildCampaignRow(Icons.lightbulb_outline, 'Needs Focus', 'Growthareaw in ...', Colors.blue.shade50, const Color(0xFF0F4C81)),
                    ]
                 )
              ),
           ]
        ),
     );
  }
}

class _DualGrowthLinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
      
      final pathB = Path();
      pathB.moveTo(0, size.height * 0.9);
      pathB.lineTo(size.width * 0.14, size.height * 0.7);
      pathB.lineTo(size.width * 0.28, size.height * 0.85);
      pathB.lineTo(size.width * 0.42, size.height * 0.5);
      pathB.lineTo(size.width * 0.57, size.height * 0.6);
      pathB.lineTo(size.width * 0.71, size.height * 0.3);
      pathB.lineTo(size.width * 0.85, size.height * 0.45);
      pathB.lineTo(size.width, size.height * 0.1);
      
      final pathT = Path();
      pathT.moveTo(0, size.height * 0.9);
      pathT.lineTo(size.width * 0.14, size.height * 0.85);
      pathT.lineTo(size.width * 0.28, size.height * 0.5);
      pathT.lineTo(size.width * 0.42, size.height * 0.75); // dip below blue
      pathT.lineTo(size.width * 0.57, size.height * 0.35);
      pathT.lineTo(size.width * 0.71, size.height * 0.45);
      pathT.lineTo(size.width * 0.85, size.height * 0.35);
      pathT.lineTo(size.width, size.height * 0.2);

      canvas.drawPath(pathB, paintB);
      canvas.drawPath(pathT, paintT);
      
      final ptsB = [0.9, 0.7, 0.85, 0.5, 0.6, 0.3, 0.45, 0.1];
      final ptsT = [0.9, 0.85, 0.5, 0.75, 0.35, 0.45, 0.35, 0.2];
      
      for(int i=0; i<8; i++) {
         canvas.drawCircle(Offset(size.width * (i/7), size.height * ptsB[i]), 5, paintB);
         canvas.drawCircle(Offset(size.width * (i/7), size.height * ptsB[i]), 3, dotPaint);
         canvas.drawCircle(Offset(size.width * (i/7), size.height * ptsT[i]), 5, paintT);
         canvas.drawCircle(Offset(size.width * (i/7), size.height * ptsT[i]), 3, dotPaint);
      }

      // Tooltip box over Oct 31 path
      final tooltipCenter = Offset(size.width * (3/7), size.height * 0.5 - 30);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: tooltipCenter, width: 80, height: 36), const Radius.circular(6)), Paint()..color = const Color(0xFF2E3B4E));
      
      final textA = TextSpan(text: 'Oct 31, 31\n', style: const TextStyle(color: Colors.grey, fontSize: 9));
      final textB = TextSpan(text: 'Revenue: 1,225', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold));
      final tp = TextPainter(text: TextSpan(children: [textA, textB]), textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, tooltipCenter.translate(-34, -14));
      
      // connecting dot
      canvas.drawCircle(Offset(size.width * (3/7), size.height * 0.5), 6, Paint()..color = const Color(0xFF0F4C81));
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
