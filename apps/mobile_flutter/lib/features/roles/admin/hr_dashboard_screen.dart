import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HrDashboardScreen extends StatelessWidget {
  const HrDashboardScreen({super.key});

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
                  const Text('Talent Acquisition\nDashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1.2)),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 300, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Search Candidates, Jobs...', style: TextStyle(color: Colors.grey, fontSize: 13))])),
                        const SizedBox(width: 24),
                        Stack(
                           children: [
                              const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_none, color: Colors.black87, size: 24)),
                              Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle), child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.mail_outline, color: Colors.black87, size: 24),
                        const SizedBox(width: 24),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: const [
                                    Text('Sarah Jones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text('Admin', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                 ]
                              ),
                              const SizedBox(width: 12),
                              const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=9')),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: const [
                  Text('Welcome back, Sarah Jones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 4),
                  Text('Healthcare franchise hiring and HR dashboard, summary.', style: TextStyle(color: Colors.black87, fontSize: 14)),
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 4,
               desktopMainAxisExtent: 160,
               children: [
                  _buildJobOpeningsCard(),
                  _buildNewApplicationsCard(),
                  _buildInterviewsCard(),
                  _buildEmployeesHiredCard(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildHiringPipelineCard(),
                  _buildDepartmentalHiresCard(),
               ]
            ),
            const SizedBox(height: 24),
            _buildRecentApplicationsTable().withHeight(340),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCardBase(IconData ic, String title, String val, Widget sub, Widget vizGraphic) {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(ic, color: const Color(0xFF0F4C81), size: 20)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                          sub,
                       ]
                    ),
                    SizedBox(child: Padding(padding: const EdgeInsets.only(left: 16), child: vizGraphic)),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildJobOpeningsCard() {
     return _buildTopCardBase(
        Icons.business_center_outlined, 'Total Job Openings', '142',
        PrimeCareResponsiveKpiGrid(
 children: const [Text('+8%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(width: 4), Text('this month', style: TextStyle(color: Colors.black54, fontSize: 11))]),
        const SizedBox(height: 40, child: ServerLoadGraph())
     );
  }

  Widget _buildNewApplicationsCard() {
     return _buildTopCardBase(
        Icons.article_outlined, 'New Applications', '948',
        const Text('115 pending', style: TextStyle(color: Colors.black54, fontSize: 11)),
        Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), Container(width: 40, height: 4, color: const Color(0xFF0F4C81), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: 0.3, child: Container(color: Colors.teal)))]),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)), const SizedBox(width: 8), Container(width: 40, height: 4, color: Colors.grey.shade300)]),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)), const SizedBox(width: 8), Container(width: 40, height: 4, color: Colors.grey.shade300)]),
           ]
        )
     );
  }

  Widget _buildInterviewsCard() {
     return _buildTopCardBase(
        Icons.people_outline, 'Interviews Today', '12',
        const Text('12 scheduled', style: TextStyle(color: Colors.black54, fontSize: 11)),
        SizedBox(
           height: 40,
           child: Stack(
              alignment: Alignment.centerRight,
              children: [
                 Positioned(right: 0, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.teal)), child: const Icon(Icons.person, color: Colors.teal, size: 12))),
                 Positioned(right: 12, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.teal)), child: const Icon(Icons.person, color: Colors.teal, size: 12))),
                 Positioned(right: 24, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.teal)), child: const Icon(Icons.person, color: Colors.teal, size: 12))),
              ]
           )
        )
     );
  }

  Widget _buildEmployeesHiredCard() {
     return _buildTopCardBase(
        Icons.people_alt_outlined, 'Employees Hired', '34',
        PrimeCareResponsiveKpiGrid(
 children: const [Text('this month ', style: TextStyle(color: Colors.black54, fontSize: 11)), Icon(Icons.arrow_drop_up, color: Colors.green, size: 14), Text('22.5%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11))]),
        SizedBox(height: 40, child: CustomPaint(painter: _UpwardLinePainter(), size: const Size(double.infinity, 40)))
     );
  }

  Widget _buildHiringPipelineCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Hiring Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('50%', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 16),
                          Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('197%', style: TextStyle(fontSize: 12)), // match mock literal
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('160'), _ChartLine('120'), _ChartLine('90'), _ChartLine('40'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildGradientCol('Applied', '133', '82%', 0.82),
                                   _buildGradientCol('Screened', '80', '43%', 0.5),
                                   _buildGradientCol('Interviewed', '58', '30%', 0.35),
                                   _buildGradientCol('Offer', '34', '15%', 0.2),
                                   _buildGradientCol('Hired', '35', '18%', 0.22),
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

  Widget _buildGradientCol(String lbl, String topVal, String pct, double h) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Text(topVal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
           const SizedBox(height: 8),
           Container(
              width: 50, height: 260 * h,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [const Color(0xFF0F4C81), Colors.teal.shade400]), borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
              padding: const EdgeInsets.only(top: 8),
              child: Text(pct, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
           ),
           const SizedBox(height: 12),
           Text(lbl, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        ]
     );
  }

  Widget _buildDepartmentalHiresCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
              const Align(alignment: Alignment.centerLeft, child: Text('Departmental Hires', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              SizedBox(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(width: 140, height: 140, child: CircularProgressIndicator(value: 0.8, strokeWidth: 32, backgroundColor: Colors.teal.shade500, color: const Color(0xFF0F4C81))),
                       const SizedBox(width: 32),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Nursing', style: TextStyle(fontSize: 12))]), const SizedBox(height: 8),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.blue.shade700, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Admin', style: TextStyle(fontSize: 12))]), const SizedBox(height: 8),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.blue.shade400, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Tech', style: TextStyle(fontSize: 12))]), const SizedBox(height: 8),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade600, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Clinic', style: TextStyle(fontSize: 12))]), const SizedBox(height: 8),
                             PrimeCareResponsiveKpiGrid(
 children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.teal.shade400, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Support', style: TextStyle(fontSize: 12))]),
                          ]
                       )
                    ]
                 )
              ),
              const Center(child: Text('Active roles • active roles.', style: TextStyle(fontSize: 12))),
              const SizedBox(height: 8),
           ]
        ),
     );
  }

  Widget _buildRecentApplicationsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Recent Applications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['Applicant', 'Role', 'Department', 'Source', 'Applied Date', 'Status (Active)', 'Actions'],
                    data: const [
                       {'pn': 'Sarah Jones', 'w': 9, 'role': 'Nurse Practitioner', 'dep': 'Healthcare', 'src': 'Pompany', 'date': '24 May 2024', 'stat': 'Reviewing'},
                       {'pn': 'Harry Nurse', 'w': 8, 'role': 'ICU Nurse', 'dep': 'Department', 'src': 'Clinic', 'date': '24 May 2024', 'stat': 'Shortlisted'},
                       {'pn': 'Mama Toreh', 'w': 7, 'role': 'Medical Assistant', 'dep': 'Medical Assist...', 'src': 'Source', 'date': '24 May 2024', 'stat': 'Interview Scheduled'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=random?u=${data['w']}')), const SizedBox(width: 12), Text(data['pn'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))])),
                       DataCell(Text(data['role'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['dep'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['src'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['date'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(_buildStatusPill(data['stat'])),
                       const DataCell(Icon(Icons.more_horiz, color: Colors.blueGrey)),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildStatusPill(String stat) {
     Color bg; Color text;
     if (stat == 'Reviewing') { bg = Colors.yellow.shade100; text = Colors.orange.shade900; }
     else if (stat == 'Shortlisted') { bg = Colors.green.shade50; text = Colors.green.shade800; }
     else { bg = Colors.blue.shade50; text = Colors.blue.shade800; } // Interview Scheduled
     
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text(stat, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 11))
     );
  }
}

class _UpwardLinePainter extends CustomPainter {
   @override
   void paint(Canvas canvas, Size size) {
      final paint = Paint()..color = Colors.teal.shade500..strokeWidth = 2..style = PaintingStyle.stroke;
      final fillPaint = Paint()..color = Colors.teal.shade50..style = PaintingStyle.fill;
      final path = Path();
      
      path.moveTo(0, size.height);
      path.quadraticBezierTo(size.width * 0.3, size.height * 0.8, size.width * 0.5, size.height * 0.5);
      path.quadraticBezierTo(size.width * 0.8, size.height * 0.7, size.width, 0);

      final areaPath = Path.from(path)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
      
      canvas.drawPath(areaPath, fillPaint);
      canvas.drawPath(path, paint);
      
      canvas.drawPath(Path()..moveTo(size.width - 5, 5)..lineTo(size.width, 0)..lineTo(size.width - 2, 8), paint);
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
            SizedBox(width: 30, child: Text(lbl, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
            SizedBox(child: Divider(color: Colors.grey.shade300, height: 1)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
