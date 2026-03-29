import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class OperationsMgrDashboardScreen extends StatelessWidget {
  const OperationsMgrDashboardScreen({super.key});

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
                  Row(
                     children: const [
                        Text('Operations Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 18)),
                        Text('Healthcare Franchise (12 Locations)', style: TextStyle(color: Colors.black54, fontSize: 16)),
                     ]
                  ),
                  Row(
                     children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(children: const [Icon(Icons.location_on_outlined, size: 16), SizedBox(width: 8), Text('Locations', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.search, size: 16)),
                        const SizedBox(width: 8),
                        Stack(
                           children: [
                              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.notifications_none, size: 16)),
                              Positioned(right: 0, top: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                           child: Row(
                              children: const [
                                 Icon(Icons.person_outline, size: 16),
                                 SizedBox(width: 8),
                                 Text('A. Patel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                 SizedBox(width: 8),
                                 Icon(Icons.keyboard_arrow_down, size: 16),
                              ]
                           )
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildMetricLineCard('Franchise Performance', '92%', '+4%'),
                  _buildMetricLineCard('Total Revenue', '\$1.2M', '+8%'),
                  _buildMetricLineCard('Patient Visits', '24,560', '+12%'),
                  _buildStaffUtilizationCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 3,
               desktopMainAxisExtent: 360,
               children: [
                  _buildRevenueByLocationCard(),
                  _buildFranchiseMapCard(),
                  _buildRecentActivitiesList(),
               ]
            ),
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildFranchisePerformanceMetricsTable(),
                  _buildOperationalTasksStack(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricLineCard(String title, String val, String grw) {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                    Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                          const Icon(Icons.arrow_drop_up, color: Colors.teal, size: 16),
                          Text(grw, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
                       ]
                    )
                 ]
              ),
              const Expanded(child: ServerLoadGraph()),
           ]
        )
     );
  }

  Widget _buildStaffUtilizationCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Staff Utilization', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.people_outline, color: Colors.grey, size: 16)]
              ),
              const Text('88%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              const Spacer(),
              Container(height: 8, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)), alignment: Alignment.centerLeft, child: FractionallySizedBox(widthFactor: 0.88, child: Container(decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4))))),
              const SizedBox(height: 8),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Progress', style: TextStyle(color: Colors.black54, fontSize: 11)), Text('88%', style: TextStyle(fontSize: 11))]
              )
           ]
        ),
     );
  }

  Widget _buildRevenueByLocationCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Revenue by Location (Last 30 Days)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(
                       children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.insert_chart_outlined, size: 14), SizedBox(width: 4), Text('Chart', style: TextStyle(fontSize: 11))])),
                          const SizedBox(width: 8),
                          const Icon(Icons.more_horiz, color: Colors.grey),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 24),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('\$150K'), _ChartLine('\$100K'), _ChartLine('750K'), _ChartLine('500K'), _ChartLine('250K'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildStackedCol('Downtown', 0.8, 0.5),
                                   _buildStackedCol('North', 0.6, 0.4),
                                   _buildStackedCol('West', 0.65, 0.45),
                                   _buildStackedCol('West', 0.4, 0.25),
                                   _buildStackedCol('Eiast', 0.6, 0.4),
                                   _buildStackedCol('South', 0.55, 0.35),
                                   _buildStackedCol('Nona...', 0.35, 0.2),
                                   _buildStackedCol('North', 0.3, 0.25),
                                   _buildStackedCol('West', 0.2, 0.1),
                                   _buildStackedCol('Other', 0.2, 0.1),
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

  Widget _buildStackedCol(String lbl, double hTotal, double hBase) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Column(
              children: [
                 Container(width: 24, height: 260 * (hTotal - hBase), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
                 Container(width: 24, height: 260 * hBase, decoration: const BoxDecoration(color: Color(0xFF0F4C81))),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 9, color: Colors.black87)),
        ]
     );
  }

  Widget _buildFranchiseMapCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Franchise Map & Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),
              Expanded(
                 child: Container(
                    decoration: BoxDecoration(
                       image: const DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/World_map_blank_without_borders.svg/1000px-World_map_blank_without_borders.svg.png'), opacity: 0.3, fit: BoxFit.cover),
                       color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)
                    ),
                    child: Stack(
                       children: const [
                          _MapPin(40, 150, 'Downtown', 'Online', true),
                          _MapPin(80, 80, 'Downtown', 'Gnline', true),
                          _MapPin(120, 110, 'North', 'Online', true),
                          _MapPin(150, 100, 'West', 'Online', true),
                          _MapPin(100, 170, 'North', 'Issue', false),
                          _MapPin(160, 180, 'South', 'Online', true),
                          _MapPin(200, 180, 'South', 'Issue', false),
                       ]
                    )
                 )
              )
           ]
        ),
     );
  }

  Widget _buildRecentActivitiesList() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Recent Activities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Icon(Icons.more_horiz, color: Colors.grey)]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildActivityRow(Icons.warning_amber_rounded, Colors.red.shade50, Colors.redAccent, 'Alerts updated', 'Recruitment: yi lanchers for\n+1 hours ago'),
                       _buildActivityRow(Icons.chat_bubble_outline, Colors.blue.shade50, Colors.blue, 'Mert updated', 'Updated this ranchers for\n27 hours ago'),
                       _buildActivityRow(Icons.notifications_none, Colors.amber.shade50, Colors.amber, 'Updates updated', 'Updated new updates for\n+1 hours ago'),
                    ]
                 )
              ),
              const Center(child: Text('Show more >', style: TextStyle(color: Color(0xFF0F4C81), fontWeight: FontWeight.bold, fontSize: 12))),
           ]
        ),
     );
  }

  Widget _buildActivityRow(IconData ic, Color bg, Color iconC, String title, String sub) {
     return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: bg, shape: BoxShape.circle), child: Icon(ic, color: iconC, size: 16)),
           const SizedBox(width: 12),
           Expanded(
              child: Column(
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

  Widget _buildFranchisePerformanceMetricsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Franchise Performance Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                       children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.filter_list, size: 14), SizedBox(width: 4), Text('Filters', style: TextStyle(fontSize: 12))])),
                          const SizedBox(width: 8),
                          const Icon(Icons.more_horiz, color: Colors.grey),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Name', 'Manager', 'Patient Satisfaction', 'Daily Visits', 'Status'],
                    data: const [
                       {'n': 'Downtown', 'm': 'J. Doe', 's': '4.9', 'v': '120', 'st': 'Operational'},
                       {'n': 'North', 'm': 'L. Chen', 's': '4.7', 'v': '95', 'st': 'Review'},
                       {'n': 'South', 'm': 'L. Chen', 's': '4.5', 'v': '80', 'st': 'Operational'},
                       {'n': 'Downtown', 'm': 'J. Doe', 's': '4.9', 'v': '70', 'st': 'Operational'},
                       {'n': 'North', 'm': 'L. Chen', 's': '4.5', 'v': '80', 'st': 'Review'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['n']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['m']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['s']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['v']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: data['st'] == 'Review' ? Colors.amber.shade50 : Colors.teal.shade50, borderRadius: BorderRadius.circular(12)), child: Text(data['st']!, style: TextStyle(color: data['st'] == 'Review' ? Colors.amber.shade700 : Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 11)))),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildOperationalTasksStack() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Operational Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.more_horiz, color: Colors.grey)]
              ),
              const SizedBox(height: 16),
              _buildTaskRow(true, 'Checklist checklist'),
              const SizedBox(height: 12),
              _buildTaskRow(true, 'Operationd tasks'),
              const SizedBox(height: 12),
              _buildTaskRow(false, 'Check in nonplete graph'),
              const SizedBox(height: 24),
              Expanded(
                 child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('150'), _ChartLine('100'), _ChartLine('50'), _ChartLine('0'),
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
                                         size: const Size(double.infinity, 100),
                                         painter: _LineAreaPainter(),
                                      )
                                   )
                                ]
                             )
                          )
                       ),
                       Positioned(bottom: 0, left: 30, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Mon', style: TextStyle(fontSize: 10)), Text('Tue', style: TextStyle(fontSize: 10)), Text('Wed', style: TextStyle(fontSize: 10)), Text('Thu', style: TextStyle(fontSize: 10))]))
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTaskRow(bool isC, String txt) {
     return Row(
        children: [
           Container(width: 16, height: 16, decoration: BoxDecoration(color: isC ? const Color(0xFF0F4C81) : Colors.transparent, border: Border.all(color: isC ? const Color(0xFF0F4C81) : Colors.grey), borderRadius: BorderRadius.circular(4)), child: isC ? const Icon(Icons.check, color: Colors.white, size: 12) : null),
           const SizedBox(width: 12),
           Text(txt, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ]
     );
  }
}

class _MapPin extends StatelessWidget {
   final double t;
   final double l;
   final String title;
   final String stat;
   final bool isOk;
   const _MapPin(this.t, this.l, this.title, this.stat, this.isOk);
   
   @override
   Widget build(BuildContext context) {
      return Positioned(
         top: t, left: l,
         child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Icon(Icons.adjust, color: Color(0xFF0F4C81), size: 12),
               const SizedBox(width: 4),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9)),
                     Text(stat, style: TextStyle(color: isOk ? Colors.teal : Colors.red, fontSize: 9)),
                  ]
               )
            ]
         )
      );
   }
}

class _ChartLine extends StatelessWidget {
   final String lbl;
   const _ChartLine(this.lbl);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 20, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            Expanded(child: Divider(color: Colors.grey.shade300, height: 1)),
         ]
      );
   }
}

class _LineAreaPainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paint = Paint()..color = const Color(0xFF0F4C81)..strokeWidth = 3..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = Colors.teal.shade500.withOpacity(0.2)..style = PaintingStyle.fill;
      
      final pts = [0.9, 0.5, 0.7, 0.2];
      final path = Path();
      
      final w = size.width / (pts.length - 1);
      path.moveTo(0, size.height * pts[0]);
      
      // Draw smooth curve using cubicTo or simple lines
      for(int i=1; i<pts.length; i++) {
         path.quadraticBezierTo(w * (i - 0.5), size.height * pts[i-1], w * i, size.height * pts[i]);
      }
      
      final areaPath = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, paint);
   }
   
   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
