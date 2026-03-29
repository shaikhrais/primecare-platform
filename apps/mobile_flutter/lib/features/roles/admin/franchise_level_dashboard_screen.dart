import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseLevelDashboardScreen extends StatelessWidget {
  const FranchiseLevelDashboardScreen({super.key});

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
 children: const [
                        Text('Hamilton Healthcare', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 18)),
                        Text('Franchise Dashboard', style: TextStyle(color: Colors.black54, fontSize: 16)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                        const SizedBox(width: 16),
                        Stack(
                           children: [
                              const Icon(Icons.notifications_none, color: Colors.grey, size: 20),
                              Positioned(right: 0, top: 0, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle))),
                           ]
                        ),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              CircleAvatar(radius: 12, backgroundImage: const NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=11')),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Michael Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text('Admin', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                 ]
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 3,
               desktopMainAxisExtent: 160,
               children: [
                  _buildPerformanceBlock(),
                  _buildPatientActivityBlock(),
                  _buildNetworkHealthBlock(),
               ]
            ),
            const SizedBox(height: 24),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 360,
               children: [
                  _buildKeyPerformanceMetricsCard(),
                  _buildTopPerformingClinicsCard(),
               ]
            ),
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildLocationPerformanceCard(),
                  _buildRecentActivitiesFeed(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceBlock() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              SizedBox(child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          const Text('Hamilton Franchise | Performance', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          const Text('Title', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          SizedBox(child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                   _buildMiniBar(0.4), _buildMiniBar(0.6), _buildMiniBar(0.5), _buildMiniBar(0.7),
                                   _buildMiniBar(0.4), _buildMiniBar(0.9), _buildMiniBar(0.3), _buildMiniBar(0.5),
                                ]
                             )
                          )
                       ]
                    )
                 )
              ),
              const SizedBox(height: 12),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('\$3,450,120', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          Text('Revenue', style: TextStyle(color: Colors.black87, fontSize: 12)),
                       ]
                    ),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: const [
                          Text('+8.4%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                          Text('YoY', style: TextStyle(color: Colors.black87, fontSize: 12)),
                       ]
                    ),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildMiniBar(double h) => Container(width: 12, height: 40 * h, decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: const BorderRadius.vertical(top: Radius.circular(2))));

  Widget _buildPatientActivityBlock() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Patient Appointment Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('24,198', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          Text('Bookings', style: TextStyle(color: Colors.black87, fontSize: 12)),
                       ]
                    ),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('71% New', style: TextStyle(fontSize: 11))]),
                          const SizedBox(height: 4),
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('29% Follow-up', style: TextStyle(fontSize: 11))]),
                       ]
                    )
                 ]
              ),
              const SizedBox(child: ServerLoadGraph()), // Represents the dual-wave lines
           ]
        )
     );
  }

  Widget _buildNetworkHealthBlock() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [Text('Clinic Network Health', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.more_vert, color: Colors.grey, size: 16)]
              ),
              SizedBox(child: Stack(
                    children: [
                       Positioned.fill(
                          child: Align(
                             alignment: Alignment.centerRight,
                             child: Container(
                                width: 220,
                                decoration: const BoxDecoration(
                                   image: DecorationImage(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/World_map_blank_without_borders.svg/1000px-World_map_blank_without_borders.svg.png'), opacity: 0.3, fit: BoxFit.contain)
                                ),
                                child: Stack(
                                   children: const [
                                      Positioned(top: 20, left: 30, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 12)),
                                      Positioned(top: 40, left: 50, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 12)),
                                      Positioned(top: 60, left: 100, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 12)),
                                      Positioned(top: 30, left: 120, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 12)),
                                      Positioned(top: 50, left: 160, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 12)),
                                   ]
                                )
                             )
                          )
                       ),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                   Text('38', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                   Text('Locations', style: TextStyle(color: Colors.black87, fontSize: 12)),
                                ]
                             ),
                             const SizedBox(height: 16),
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                   Text('94.2%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                   Text('Occupancy', style: TextStyle(color: Colors.black87, fontSize: 12)),
                                ]
                             ),
                          ]
                       )
                    ]
                 )
              )
           ]
        )
     );
  }

  Widget _buildKeyPerformanceMetricsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Key Performance Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Interactive', style: TextStyle(fontSize: 12)), const SizedBox(width: 4), const Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const Text('Monthly Revenue by Location', style: TextStyle(color: Colors.black87, fontSize: 12)),
              const SizedBox(height: 32),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('\$400K'), _ChartLine('\$750K'), _ChartLine('\$300K'), _ChartLine('\$150K'), _ChartLine('0'),
                          ]
                       ),
                       Positioned.fill(
                          child: Padding(
                             padding: const EdgeInsets.only(left: 40, right: 10),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildGroupedColumn('June', 0.4, 0.45),
                                   _buildGroupedColumn('July', 0.45, 0.4),
                                   _buildGroupedColumn('Aug', 0.5, 0.55),
                                   _buildGroupedColumn('Sep', 0.55, 0.6),
                                   _buildGroupedColumn('Oct', 0.7, 0.8),
                                   _buildGroupedColumn('Nov', 0.85, 0.95),
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

  Widget _buildGroupedColumn(String label, double leftH, double rightH) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 Container(width: 24, height: 260 * leftH, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(top: Radius.circular(2)))),
                 const SizedBox(width: 2),
                 Container(width: 24, height: 260 * rightH, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
              ]
           ),
           const SizedBox(height: 12),
           Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
        ]
     );
  }

  Widget _buildTopPerformingClinicsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Top Performing Clinics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildLocationTile(Icons.location_on, 'Hamilton Central', Colors.blue.shade50, const Color(0xFF0F4C81)),
                       _buildLocationTile(Icons.business, 'North Park', Colors.teal.shade50, Colors.teal),
                       _buildLocationTile(Icons.business, 'Hamilton Gather', Colors.teal.shade50, Colors.teal),
                       _buildLocationTile(Icons.business, 'North Permark', Colors.teal.shade50, Colors.teal),
                       _buildLocationTile(Icons.location_on, 'Hamilton Central', Colors.blue.shade50, const Color(0xFF0F4C81)),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildLocationTile(IconData icon, String lbl, Color bg, Color ic) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: ic, size: 18)),
           const SizedBox(width: 12),
           Text(lbl, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ]
     );
  }

  Widget _buildLocationPerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Location Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Activity', style: TextStyle(fontSize: 12)), const SizedBox(width: 4), const Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['Location Name', 'Status', 'Staff', 'Revenue', 'Occupancy', 'Activity', 'Performance'],
                    data: const [
                       {'loc': 'Hamilton Central', 'stat': 'Online', 'staff': '42', 'rev': '\$785K', 'occ': '92%', 'act': 'High', 'v1': 0.8, 'v2': 0.6},
                       {'loc': 'North Park', 'stat': 'Online', 'staff': '36', 'rev': '\$610K', 'occ': '88%', 'act': 'High', 'v1': 0.7, 'v2': 0.5},
                       {'loc': 'North Park', 'stat': 'Active', 'staff': '51', 'rev': '\$920K', 'occ': '97%', 'act': 'High', 'v1': 0.9, 'v2': 0.8},
                       {'loc': 'East Park', 'stat': 'Active', 'staff': '33', 'rev': '\$785K', 'occ': '92%', 'act': 'High', 'v1': 0.6, 'v2': 0.4},
                       {'loc': 'Hamilton Central', 'stat': 'Active', 'staff': '36', 'rev': '\$660K', 'occ': '97%', 'act': 'High', 'v1': 0.7, 'v2': 0.7},
                       {'loc': 'West Beton', 'stat': 'Active', 'staff': '48', 'rev': '\$920K', 'occ': '97%', 'act': 'High', 'v1': 0.9, 'v2': 0.9},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['loc'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)), child: Text(data['stat'], style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 11)))),
                       DataCell(Text(data['staff'], style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['rev'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['occ'], style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['act'], style: const TextStyle(fontSize: 12))),
                       DataCell(
                          Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                                Container(width: 30 * data['v1'] as double, height: 6, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.horizontal(left: Radius.circular(3)))),
                                Container(width: 30 * data['v2'] as double, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.horizontal(right: Radius.circular(3)))),
                                Container(width: 10, height: 6, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: const BorderRadius.horizontal(right: Radius.circular(3)))),
                             ]
                          )
                       ),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildRecentActivitiesFeed() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Recent Activities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Positioned(top: 20, bottom: 20, left: 20, child: Container(width: 2, color: Colors.grey.shade200)),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             _buildFeedRow(Icons.business_center_outlined, 'Clinic updates Hamilton\nHealthcare.', '11 minutes ago'),
                             _buildFeedRow(Icons.edit_note, 'Clinic updates staff changed\nthemed.', '20 minutes ago'),
                             _buildFeedRow(Icons.person_outline, 'Clinic updates staff changed.', '1 nsever ago'),
                             _buildFeedRow(Icons.file_copy_outlined, 'Clinic updates staff changed staff.', '1 svever ago'), // Match raw image typo text
                          ]
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildFeedRow(IconData ic, String text, String time) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: Icon(ic, color: const Color(0xFF0F4C81), size: 16)),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(time, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                 ]
              )
           )
        ]
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
            SizedBox(width: 40, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black54))),
            SizedBox(child: Divider(color: Colors.grey.shade200, height: 1)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
