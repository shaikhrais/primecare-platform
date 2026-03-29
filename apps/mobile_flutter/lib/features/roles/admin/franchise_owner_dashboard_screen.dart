import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerDashboardScreen extends StatelessWidget {
  const FranchiseOwnerDashboardScreen({super.key});

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
                  PrimeCareResponsiveKpiGrid(
 children: [
                        const CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=9')),
                        const SizedBox(width: 16),
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                              Text('Welcome back, Sarah Jensen!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                              SizedBox(height: 4),
                              Text('(Franchise Owner)', style: TextStyle(color: Colors.black54, fontSize: 16)),
                           ]
                        )
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Stack(
                           children: [
                              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.notifications_none, color: Colors.grey, size: 20)),
                              Positioned(right: 0, top: 0, child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.search, color: Colors.grey, size: 20)),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), child: const Text('New Report', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildMetricCard(Icons.monetization_on_outlined, 'Total Revenue', '\$1,840,200', '+8.2%', 'vs Last Month'),
                  _buildMetricCard(Icons.people_outline, 'Total Visits', '12,500', '+10%', null),
                  _buildMetricCard(Icons.star_border, 'Avg Patient Rating', '4.8', null, '110 Reviews'),
                  _buildMetricCard(Icons.person_outline, 'Occupancy Rate', '89%', null, '15 Units'),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildMonthlyRevenueCard(),
                  _buildTopPerformingCard(),
               ]
            ),
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildClinicPerformanceTable(),
                  _buildRecentAppointmentsTable(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(IconData ic, String title, String val, String? pos, String? sub) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: Colors.white, size: 20)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              PrimeCareResponsiveKpiGrid(
 children: [
                    if (pos != null) Text(pos, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                    if (pos != null) const SizedBox(width: 4),
                    if (sub != null) Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildMonthlyRevenueCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Monthly Revenue & Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          const Text('Jan-Dec 2023', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(width: 8),
                          const Icon(Icons.more_horiz, color: Colors.grey),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                    const SizedBox(width: 24),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Patient Vists', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('\$K'), _ChartLine('3K'), _ChartLine('2K'), _ChartLine('1K'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 30, right: 10, bottom: 20),
                             child: Stack(
                                children: [
                                   Positioned(
                                      bottom: 0, left: 0, right: 0,
                                      child: CustomPaint(
                                         size: const Size(double.infinity, 200),
                                         painter: _LineAreaPainter(),
                                      )
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(
                          bottom: 0, left: 30, right: 10,
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: const [
                                Text('Jan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Feb', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Mar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Apr', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('May', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Jun', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Aug', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Sep', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Oct', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Nov', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text('Dec', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                             ]
                          )
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTopPerformingCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Top Performing Clinics (by Revenue)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: const [Text('Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), SizedBox(width: 16), Text('Patient Vists', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))]),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                                _buildGradientRow('Name Point 1', 1.0, '\$450K', '3100'),
                                _buildGradientRow('Chicago Metro', 0.9, '\$410K', '3100'),
                                _buildGradientRow('Name Point 2', 0.6, '\$470K', '2100'),
                                _buildGradientRow('Name Point 3', 0.5, '\$330K', '1300'),
                                _buildGradientRow('Name Point 4', 0.5, '\$320K', '1300'),
                                _buildGradientRow('Name Point 4', 0.4, '\$230K', '900'), // intentional duplicate from mock
                                _buildGradientRow('Dame Point 5', 0.3, '\$120K', '300'),
                             ]
                          )
                       ),
                       Positioned(
                          bottom: 0, left: 100, right: 60,
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: const [Text('0', style: TextStyle(fontSize: 10)), Text('500', style: TextStyle(fontSize: 10)), Text('1000', style: TextStyle(fontSize: 10)), Text('1500', style: TextStyle(fontSize: 10))]
                          )
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildGradientRow(String title, double widthFlex, String innerLbl, String val) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(width: 90, child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
           SizedBox(child: Stack(
                 alignment: Alignment.centerLeft,
                 children: [
                    FractionallySizedBox(
                       widthFactor: widthFlex,
                       child: Container(
                          height: 16,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), gradient: LinearGradient(colors: [const Color(0xFF0F4C81), Colors.teal.shade400])),
                          child: Text(innerLbl, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                       )
                    )
                 ]
              )
           ),
           SizedBox(width: 40, child: Text(val, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
        ]
     );
  }

  Widget _buildClinicPerformanceTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Clinic Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.more_horiz, color: Colors.grey)]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Location', 'Manager', 'Revenue', 'Patient Visits', 'Growth', 'Status'],
                    data: const [
                       {'loc': 'Boston Central', 'mgr': 'Sarah Jenser', 'rev': '\$410K', 'vis': '3100', 'grw': '+9.1%', 'stat': 'On Track'},
                       {'loc': 'Chicago Metro', 'mgr': 'Sarah Jenser', 'rev': '\$410K', 'vis': '3100', 'grw': '+9.1%', 'stat': 'On Track'},
                       {'loc': 'Chicago', 'mgr': 'Sarah Jenser', 'rev': '\$420K', 'vis': '3100', 'grw': '+9.1%', 'stat': 'On Track'},
                       {'loc': 'etc.', 'mgr': 'Sarah Jenser', 'rev': '\$410K', 'vis': '3100', 'grw': '+9.1%', 'stat': 'On Track'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['loc']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['mgr']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['vis']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['grw']!, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)), child: Text(data['stat']!, style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 11)))),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildRecentAppointmentsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Recent Appointments & Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.more_horiz, color: Colors.grey)]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Patient Name', 'Clinic', 'Type', 'Time', 'Status'],
                    data: const [
                       {'pn': 'Patient Name', 'cl': 'Clinic', 'type': 'Healthary', 'time': '9:30 AM', 'stat': 'Status'},
                       {'pn': 'Jasant Harson', 'cl': 'Clinic', 'type': 'User', 'time': '9:30 AM', 'stat': 'Status'},
                       {'pn': 'Tommy Marth', 'cl': 'Clinic', 'type': 'User', 'time': '8:30 AM', 'stat': 'Status'},
                       {'pn': 'Sarah Jenaen', 'cl': 'Clinic', 'type': 'Healthary', 'time': '8:30 AM', 'stat': 'Status'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['pn']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['cl']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['type']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['time']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(Text(data['stat']!, style: const TextStyle(fontSize: 11))),
                    ],
                 )
              )
           ]
        ),
     );
  }
}

class _ChartLine extends StatelessWidget {
   final String lbl;
   const _ChartLine(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 20, child: Text(lbl, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
            SizedBox(child: Divider(color: Colors.grey.shade300, height: 1)),
         ]
      );
   }
}

class _LineAreaPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paint = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = const Color(0xFF0F4C81).withOpacity(0.1)..style = PaintingStyle.fill;
      final dotPaint = Paint()..color = Colors.teal.shade400..style = PaintingStyle.fill;
      final borderDotPaint = Paint()..color = Colors.white..strokeWidth = 2..style = PaintingStyle.stroke;
      
      final pts = [0.9, 0.5, 0.7, 0.6, 0.4, 0.6, 0.4, 0.35, 0.6, 0.5, 0.2];
      final path = Path();
      
      final w = size.width / (pts.length - 1);
      path.moveTo(0, size.height * pts[0]);
      
      for(int i=1; i<pts.length; i++) {
         path.lineTo(w * i, size.height * pts[i]);
      }
      
      final areaPath = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, paint);
      
      for(int i=0; i<pts.length; i++) {
         canvas.drawCircle(Offset(w * i, size.height * pts[i]), 5, dotPaint);
         canvas.drawCircle(Offset(w * i, size.height * pts[i]), 5, borderDotPaint);
      }
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
