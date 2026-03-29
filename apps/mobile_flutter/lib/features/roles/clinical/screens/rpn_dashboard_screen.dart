import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RpnDashboardScreen extends StatelessWidget {
  const RpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Welcome back, Sarah!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.search, size: 16), SizedBox(width: 8), Text('Search', style: TextStyle(fontSize: 12))])),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.notifications_none, size: 16), SizedBox(width: 8), Text('Notifications', style: TextStyle(fontSize: 12))])),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.calendar_today, size: 16), SizedBox(width: 8), Text('Oct 26, 2023', style: TextStyle(fontSize: 12))])),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)), child: const Text('Add Nurse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildTotalRpnsCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRadialGaugeCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildCredentialComplianceCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildFranchiseRevenueCard()),
               ]
            ).withHeight(160),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildRegionalStaffingPerformanceCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: Column(children: [SizedBox(child: _buildFranchiseMapCard()), const SizedBox(height: 16), SizedBox(child: _buildNurseDeploymentMixCard()), const SizedBox(height: 16), SizedBox(child: _buildNotificationsAlertsCard())])),
               ]
            ).withHeight(600),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRpnsCard() {
     return Container(
        decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        padding: const EdgeInsets.all(16),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Total RPNs', style: TextStyle(color: Colors.white, fontSize: 13)), Icon(Icons.more_vert, color: Colors.white70, size: 16)]
              ),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: const [
                    Text('1,248', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(width: 8),
                    Text('+15% MoM', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              const SizedBox(child: ServerLoadGraph()),
              const Text('Line Chart', style: TextStyle(color: Colors.white70, fontSize: 11)),
           ]
        ),
     );
  }

  Widget _buildRadialGaugeCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Active Placements', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              SizedBox(child: Stack(
                    alignment: Alignment.center,
                    children: [
                       Container(
                         width: 140, height: 140,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(70),
                           border: Border(
                             top: BorderSide(color: Colors.teal.shade500, width: 14),
                             left: BorderSide(color: Colors.teal.shade500, width: 14),
                             right: BorderSide(color: Colors.teal.shade100, width: 14),
                             bottom: const BorderSide(color: Colors.transparent, width: 14),
                           )
                         ),
                       ),
                       Positioned(bottom: 20, child: Column(children: const [Text('912 / 1,050', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text('87% Fill Rate', style: TextStyle(color: Colors.black54, fontSize: 10))])),
                    ]
                 )
              ),
              const Text('Radial Gauge', style: TextStyle(color: Colors.black54, fontSize: 11)),
           ]
        )
     );
  }

  Widget _buildCredentialComplianceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Credential Compliance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              SizedBox(child: Stack(
                    alignment: Alignment.center,
                    children: [
                       SizedBox(
                         width: 90, height: 90,
                         child: CircularProgressIndicator(value: 0.98, strokeWidth: 14, backgroundColor: Colors.teal.shade100, color: Colors.teal.shade500),
                       ),
                       Column(mainAxisSize: MainAxisSize.min, children: const [Text('98.2%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('+2.1%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11))]),
                    ]
                 )
              ),
              const SizedBox(height: 12),
           ]
        )
     );
  }

  Widget _buildFranchiseRevenueCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Franchise Revenue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: const [
                    Text('\$450,210', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(width: 8),
                    Text('+18%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              const SizedBox(child: ServerLoadGraph()),
              const Text('Area Chart', style: TextStyle(color: Colors.black54, fontSize: 11)),
           ]
        )
     );
  }

  Widget _buildRegionalStaffingPerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Regional Staffing Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_vert, color: Colors.grey),
                 ]
              ),
              const Text('Stacked Bar Chart', style: TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('300'), _ChartLine('250'), _ChartLine('200'), _ChartLine('150'), _ChartLine('100'), _ChartLine('50'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildStackedColumn('GTA', 0.85, 0.4, 0.1),
                                   _buildStackedColumn('Metro', 0.8, 0.35, 0.1),
                                   _buildStackedColumn('Central', 0.7, 0.3, 0.05),
                                   _buildStackedColumn('East', 0.65, 0.25, 0.05),
                                   _buildStackedColumn('West', 0.55, 0.2, 0.05),
                                ]
                             )
                          )
                       )
                    ]
                 )
              ),
              const SizedBox(height: 24),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    _buildLegendItem('RPNs', const Color(0xFF0F4C81)), const SizedBox(width: 16),
                    _buildLegendItem('Hours', const Color(0xFF1B6A9C)), const SizedBox(width: 16),
                    _buildLegendItem('Vacancy', Colors.teal.shade500),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildStackedColumn(String label, double totalH, double midBarH, double topBarH) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Column(
              children: [
                 Container(width: 44, height: 400 * topBarH, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
                 Container(width: 44, height: 400 * midBarH, color: const Color(0xFF1B6A9C)),
                 Container(width: 44, height: 400 * (totalH - midBarH - topBarH), color: const Color(0xFF0F4C81)),
                 Container(width: 44, height: 16, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(bottom: Radius.circular(2)))), // Base to ground
              ]
           ),
           const SizedBox(height: 12),
           Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildLegendItem(String text, Color c) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 12, height: 12, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
           const SizedBox(width: 8),
           Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildFranchiseMapCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Franchise Map Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_vert, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              Stack(
                 children: [
                    Container(height: 120, decoration: BoxDecoration(image: const DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Map_of_Manhattan.png/800px-Map_of_Manhattan.png'), fit: BoxFit.cover, opacity: 0.4), borderRadius: BorderRadius.circular(8))),
                    Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]), child: const Text('34 clinic locations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)))),
                    const Positioned(top: 30, left: 40, child: Icon(Icons.circle, color: Colors.teal, size: 8)),
                    const Positioned(top: 60, left: 90, child: Icon(Icons.circle, color: Colors.teal, size: 10)),
                    const Positioned(top: 40, left: 160, child: Icon(Icons.circle, color: Colors.teal, size: 8)),
                    const Positioned(top: 20, left: 120, child: Icon(Icons.circle, color: Colors.teal, size: 12)),
                    const Positioned(top: 70, left: 140, child: Icon(Icons.circle, color: Colors.teal, size: 8)),
                    const Positioned(top: 90, left: 180, child: Icon(Icons.circle, color: Colors.teal, size: 10)),
                    const Positioned(top: 50, left: 220, child: Icon(Icons.circle, color: Colors.teal, size: 8)),
                 ]
              ),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('RPNs', style: TextStyle(fontSize: 10))]), const Text('34 clinizes', style: TextStyle(fontSize: 10, color: Colors.black87))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Part time', style: TextStyle(fontSize: 10))]), const Text('Key metrics', style: TextStyle(fontSize: 10, color: Colors.black87))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: Colors.teal.shade300 == Colors.teal.shade300 ? BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle) : BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Status', style: TextStyle(fontSize: 10))]), const Text('Indicators', style: TextStyle(fontSize: 10, color: Colors.black87))]),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildNurseDeploymentMixCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Nurse Deployment Mix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_vert, color: Colors.grey),
                 ]
              ),
              const Spacer(),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    SizedBox(width: 80, height: 80, child: CircularProgressIndicator(value: 0.62, strokeWidth: 40, backgroundColor: Colors.teal.shade500, color: const Color(0xFF0F4C81))),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Full-time 62%', style: TextStyle(fontSize: 11))]), const SizedBox(height: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Part-time 28%', style: TextStyle(fontSize: 11))]), const SizedBox(height: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: Colors.green.shade500 == Colors.green.shade500 ? BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle) : BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Casual 10%', style: TextStyle(fontSize: 11))]),
                       ]
                    )
                 ]
              ),
              const Spacer(),
           ]
        )
     );
  }

  Widget _buildNotificationsAlertsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Notifications & Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_vert, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('List of recent activities/critical alerts', style: TextStyle(fontSize: 11))]),
                       PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('List of recent activities/critical alerts', style: TextStyle(fontSize: 11))]),
                       PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('List of recent activities/critical alerts', style: TextStyle(fontSize: 11))]),
                    ]
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
            SizedBox(width: 30, child: Text(lbl, style: const TextStyle(fontSize: 11, color: Colors.black87))),
            SizedBox(child: Divider(color: Colors.grey.shade200, height: 1)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
