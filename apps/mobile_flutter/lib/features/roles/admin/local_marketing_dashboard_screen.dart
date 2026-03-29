import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalMarketingDashboardScreen extends StatelessWidget {
  const LocalMarketingDashboardScreen({super.key});

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
                        Text('Good Morning,', style: TextStyle(color: Colors.black54, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.notifications_none, color: Colors.black87, size: 20)),
                              Positioned(right: 0, top: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 24),
                        Container(width: 200, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search ...', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildPatientBookingsCard(),
                  _buildActiveCampaignsCard(),
                  _buildAverageLocationRatingCard(),
                  _buildTotalRevenueCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildPerformanceOverviewCard(),
                  _buildLocationPerformanceTable(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 1,
               desktopMainAxisExtent: 120,
               children: [
                  _buildRecentCampaignActivityCard(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
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
              Text(title, style: const TextStyle(color: Colors.black87, fontSize: 11)),
              SizedBox(child: Padding(padding: const EdgeInsets.only(top: 12), child: content)),
           ]
        ),
     );
  }

  Widget _buildPatientBookingsCard() {
     return _buildTopCardBase(
        'Total Patient Bookings',
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    const Text('8,412', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.arrow_drop_up, color: Colors.teal, size: 14), Text('+12.5%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11))]),
                 ]
              ),
              SizedBox(child: CustomPaint(painter: _WaveAreaPainter(Colors.teal.shade500, Colors.teal.shade50), size: const Size(double.infinity, 40))),
           ]
        )
     );
  }

  Widget _buildActiveCampaignsCard() {
     return _buildTopCardBase(
        'Active Campaigns',
        Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: const [
                    Text('24\nActive', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, height: 0.8)),
                    SizedBox(width: 8),
                    Text(' Active ', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    SizedBox(width: 16),
                    Text('5\nPending', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 0.8)),
                    SizedBox(width: 8),
                    Text(' Pending', style: TextStyle(fontSize: 10, color: Colors.black54)),
                 ]
              ),
              SizedBox(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       _buildColumnBars(0.4, 0.4),
                       _buildColumnBars(0.6, 0.3),
                       _buildColumnBars(0.8, 0.2),
                       _buildColumnBars(0.5, 0.5),
                       _buildColumnBars(0.3, 0.7),
                       _buildColumnBars(0.7, 0.3),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildColumnBars(double hBase, double hTop) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(width: 12, height: 40 * hTop, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
           const SizedBox(height: 2),
           Container(width: 12, height: 40 * hBase, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(bottom: Radius.circular(2)))),
        ]
     );
  }

  Widget _buildAverageLocationRatingCard() {
     return _buildTopCardBase(
        'Average Location Rating',
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: const [
                          Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                       ]
                    ),
                    const SizedBox(height: 4),
                    const Text('1.2k Reviews', style: TextStyle(color: Colors.black54, fontSize: 11)),
                 ]
              ),
              SizedBox(
                 width: 60, height: 60,
                 child: Stack(
                    children: [
                       const Positioned.fill(child: CircularProgressIndicator(value: 0.8, strokeWidth: 12, color: Color(0xFF0F4C81), backgroundColor: Colors.transparent)),
                       Positioned.fill(child: CircularProgressIndicator(value: 0.15, strokeWidth: 12, color: Colors.teal.shade500, backgroundColor: Colors.transparent)),
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildTotalRevenueCard() {
     return _buildTopCardBase(
        'Total Revenue',
        Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    const Text('\$198K', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.arrow_drop_up, color: Colors.teal, size: 14), Text('+8%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11))]),
                 ]
              ),
              SizedBox(child: CustomPaint(painter: _WaveAreaPainter(const Color(0xFF0F4C81), Colors.blue.shade50), size: const Size(double.infinity, 40))),
           ]
        )
     );
  }

  Widget _buildPerformanceOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Last 30 Days', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                          const SizedBox(width: 12),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All Locations', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                          const SizedBox(width: 12),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: const Text('Export', style: TextStyle(fontSize: 11))),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 12),
              PrimeCareResponsiveKpiGrid(
 children: [
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('Campaign Reach', style: TextStyle(fontSize: 11))]),
                    const SizedBox(width: 16),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 6), const Text('New Patients', style: TextStyle(fontSize: 11))]),
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
                                      child: CustomPaint(painter: _MassiveDualPainter())
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 40, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan-Jun', style: TextStyle(fontSize: 10)), Text('Feb', style: TextStyle(fontSize: 10)), Text('Mar', style: TextStyle(fontSize: 10)), Text('Apr', style: TextStyle(fontSize: 10)), Text('May', style: TextStyle(fontSize: 10)), Text('Jan-Jun', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildLocationPerformanceTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Location Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Location Name', 'Manager', 'Active Ads', 'Rating', 'ROI'],
                    data: const [
                       {'n': 'Location\nName 1', 'm': 'Sarah', 'a': '24', 'r': '4.8', 'roi': '50%'},
                       {'n': 'Location\nName 2', 'm': 'Sarah', 'a': '5', 'r': '4.8', 'roi': '45%'},
                       {'n': 'Location\nName 3', 'm': 'Sarah', 'a': '4', 'r': '4.8', 'roi': '50%'},
                       {'n': 'Location\nName 5', 'm': 'Sarah', 'a': '5', 'r': '4.8', 'roi': '50%'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['m']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['a']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['r']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['roi']!, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11))),
                    ],
                 )
              ),
              const SizedBox(height: 8),
              Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_left, size: 16, color: Colors.grey)),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('1', style: TextStyle(fontSize: 12))),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_right, size: 16, color: Colors.grey)),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildRecentCampaignActivityCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Campaign Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('All', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 14)])),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                       Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.person_add_alt_1, color: Colors.teal.shade700, size: 20)),
                       const SizedBox(width: 12),
                       const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
                       const SizedBox(width: 12),
                       Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.campaign, color: Color(0xFF0F4C81), size: 20)),
                       const SizedBox(width: 24),
                       SizedBox(child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('Recent Campaign Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                SizedBox(height: 4),
                                Text('Conrticezated', style: TextStyle(color: Colors.black54, fontSize: 11)),
                             ]
                          )
                       ),
                       SizedBox(child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('Status', style: TextStyle(color: Colors.grey, fontSize: 11)),
                                SizedBox(height: 4),
                                Text('6utMay 2023-, May 2023 and May 2023', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), // Intentional literal match to image typos
                             ]
                          )
                       ),
                       SizedBox(child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                                Text('Dates', style: TextStyle(color: Colors.grey, fontSize: 11)),
                                SizedBox(height: 4),
                                Text('Jan 17, 2023', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                             ]
                          )
                       ),
                       const Icon(Icons.more_horiz, color: Colors.grey),
                    ]
                 )
              )
           ]
        ),
     );
  }
}

class _WaveAreaPainter extends CustomPainter {
   final Color cLine;
   final Color cArea;
   const _WaveAreaPainter(this.cLine, this.cArea);

   @override
   void paint(Canvas canvas, Size size) {
      final linePaint = Paint()..color = cLine..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = cArea..style = PaintingStyle.fill;
      
      final pts = [0.9, 0.7, 0.85, 0.4, 0.5, 0.1];
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

class _MassiveDualPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paintT = Paint()..color = Colors.teal.shade500..strokeWidth = 3..style = PaintingStyle.stroke;
      final paintB = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      
      final fillT = Paint()..color = Colors.teal.shade500.withOpacity(0.2)..style = PaintingStyle.fill;
      final fillB = Paint()..color = const Color(0xFF0F4C81).withOpacity(0.15)..style = PaintingStyle.fill;
      
      final ptsB = [0.9, 0.65, 0.7, 0.4, 0.6, 0.3];
      final ptsT = [0.85, 0.45, 0.6, 0.25, 0.5, 0.1];
      
      final pB = Path();
      final pT = Path();
      
      final w = size.width / 5;
      
      pB.moveTo(0, size.height * ptsB[0]);
      pT.moveTo(0, size.height * ptsT[0]);

      for(int i=1; i<6; i++) {
         pB.quadraticBezierTo(w * (i - 0.5), size.height * ptsB[i-1], w * i, size.height * ptsB[i]);
         pT.quadraticBezierTo(w * (i - 0.5), size.height * ptsT[i-1], w * i, size.height * ptsT[i]);
      }

      final aB = Path.from(pB)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aB, fillB);
      canvas.drawPath(pB, paintB);
      
      final aT = Path.from(pT)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      canvas.drawPath(aT, fillT);
      canvas.drawPath(pT, paintT);
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
