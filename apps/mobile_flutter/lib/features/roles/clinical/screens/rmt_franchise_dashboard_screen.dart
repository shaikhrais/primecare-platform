import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RmtFranchiseDashboardScreen extends StatelessWidget {
  const RmtFranchiseDashboardScreen({super.key});

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
                  const GreetingHeaderWidget(name: 'Franchise Dashboard - RMT Network'),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        PrimeCareResponsiveKpiGrid(
 children: [
                              CircleAvatar(radius: 12, backgroundColor: Colors.teal.shade100, backgroundImage: const NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=5')),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Dr. Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text('(Admin)', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                 ]
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
                           ]
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.mail_outline, color: Colors.black54),
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_active_outlined, color: Colors.redAccent),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildAreaMetricCard('Total Revenue', '\$78,450.20', '+12.5%')),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildBarMetricCard('Total Bookings', '4,102', '+8%', Colors.teal, false)),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildBarMetricCard('Active Therapists', '187', '+3', Colors.teal.shade700, true)),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildBarMetricCard('Franchise Locations', '24', null, const Color(0xFF0F4C81), false)),
               ]
            ).withHeight(140),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildDualLineChartCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildDonutUtilizationCard()),
               ]
            ).withHeight(360),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildTopFranchiseeTableCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRecentActivityVerticalFeed()),
               ]
            ).withHeight(360),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaMetricCard(String title, String val, String pop) {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(pop, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              const SizedBox(child: ServerLoadGraph()), // Simulated area wave
           ]
        ),
     );
  }

  Widget _buildBarMetricCard(String title, String val, String? pop, Color blockColor, bool isDualColor) {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    if (pop != null) Text(pop, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                 ]
              ),
              SizedBox(child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _vBar(0.4, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.4)),
                       _vBar(0.5, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.5)),
                       _vBar(0.7, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.7)),
                       _vBar(0.6, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.6)),
                       _vBar(0.4, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.4)),
                       _vBar(0.8, isDualColor ? const Color(0xFF0F4C81) : blockColor.withOpacity(0.8)),
                       _vBar(0.3, isDualColor ? Colors.teal : blockColor),
                       _vBar(0.8, isDualColor ? Colors.teal : blockColor),
                       _vBar(0.6, isDualColor ? Colors.teal : blockColor),
                       _vBar(0.9, isDualColor ? Colors.teal : blockColor),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _vBar(double heightFactor, Color c) => Container(width: 8, height: 40 * heightFactor, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2)));

  Widget _buildDualLineChartCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Franchise Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Senshbooad', style: TextStyle(color: Colors.white, fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16)])),
                 ]
              ),
              const SizedBox(height: 24),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          const Text('Monthly Revenue & Bookings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 8),
                          PrimeCareResponsiveKpiGrid(
 children: [
                                Container(width: 12, height: 4, color: const Color(0xFF0F4C81)), const SizedBox(width: 4), const Text('Revenue', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 16),
                                Container(width: 12, height: 4, color: Colors.teal), const SizedBox(width: 4), const Text('Bookings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                             ]
                          )
                       ]
                    ),
                    PrimeCareResponsiveKpiGrid(
 children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.show_chart, size: 14), SizedBox(width: 4), Text('Day', style: TextStyle(fontSize: 12)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 14)])),
                          const SizedBox(width: 8),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.close, size: 14), SizedBox(width: 4), Text('Months', style: TextStyle(fontSize: 12)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 14)])),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       const Positioned.fill(child: ServerLoadGraph()), // Represents the huge dual area chart
                       Positioned(top: 0, bottom: 20, left: 0, child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('\$80,000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('\$60,000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('\$4,000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('\$20,000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('0', style: TextStyle(fontSize:10,color:Colors.grey))])),
                       Positioned(bottom: 0, left: 60, right: 20, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Jan', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Feb', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Mar', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Apr', style: TextStyle(fontSize:11,color:Colors.black54)), Text('May', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Jun', style: TextStyle(fontSize:11,color:Colors.black54)), Text('May', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Jun', style: TextStyle(fontSize:11,color:Colors.black54))])),
                       Positioned(
                          top: 40, left: 350,
                          child: Container(
                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                             child: const Text('\$78,45.20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                          )
                       )
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildDonutUtilizationCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Therapist Utilization', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 32),
              SizedBox(child: Center(
                    child: SizedBox(
                       width: 140, height: 140,
                       child: CircularProgressIndicator(value: 0.55, strokeWidth: 32, backgroundColor: const Color(0xFF0F4C81), color: Colors.teal.shade500),
                    )
                 )
              ),
              const SizedBox(height: 24),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Column(
                       children: [
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Available', style: TextStyle(fontSize: 12))]),
                          const SizedBox(height: 4),
                          const Text('45%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                       ]
                    ),
                    const SizedBox(width: 32),
                    Column(
                       children: [
                          PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Booked', style: TextStyle(fontSize: 12))]),
                          const SizedBox(height: 4),
                          const Text('55%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                       ]
                    ),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildTopFranchiseeTableCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Top Franchisee Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade600, borderRadius: BorderRadius.circular(4)), child: const Text('Data analytics', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['#', 'Franchisee', 'Total Revenue', 'Growth%', 'Rating', 'Therapists'],
                    data: const [
                       {'num': '1', 'name': 'Downtown Clinic', 'rev': '\$78,450.20', 'growth': '+3%', 'w': 1, 'rating': 4},
                       {'num': '2', 'name': 'Midtown Spa', 'rev': '\$4,102.00', 'growth': '+8%', 'w': 2, 'rating': 4},
                       {'num': '3', 'name': 'Eastside Wellness', 'rev': '\$78,450.20', 'growth': '12%', 'w': 3, 'rating': 4},
                       {'num': '4', 'name': 'West End RMT', 'rev': '\$2,020.00', 'growth': '+8%', 'w': 2, 'rating': 4},
                       {'num': '5', 'name': 'North Hub', 'rev': '\$1,263.20', 'growth': '50%', 'w': 4, 'rating': 3},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['num'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['name'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['rev'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(
                          PrimeCareResponsiveKpiGrid(
 children: [
                                _buildGrowthIndicator(data['w'] as int),
                                const SizedBox(width: 8),
                                Text(data['growth'].toString(), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                             ]
                          )
                       ),
                       DataCell(Row(mainAxisSize: MainAxisSize.min, children: List.generate(5, (index) => Icon(Icons.star, color: index < (data['rating'] as int) ? Colors.amber : Colors.grey.shade300, size: 14)))),
                       DataCell(Text(data['Therapists'] ?? '24', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildGrowthIndicator(int bars) {
     return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           Container(width: 12, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)))),
           const SizedBox(width: 2),
           Container(width: 12, height: 6, color: bars >= 2 ? Colors.teal.shade500 : Colors.teal.shade100),
           const SizedBox(width: 2),
           Container(width: 12, height: 6, color: bars >= 3 ? Colors.teal.shade500 : Colors.teal.shade100),
           const SizedBox(width: 2),
           Container(width: 12, height: 6, decoration: BoxDecoration(color: bars == 4 ? Colors.teal.shade500 : Colors.teal.shade100, borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)))),
        ]
     );
  }

  Widget _buildRecentActivityVerticalFeed() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Recent Activity Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Positioned(top: 16, bottom: 40, left: 16, child: Container(width: 2, color: Colors.grey.shade200)),
                       Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             _buildTimelineRow(Icons.calendar_today, 'Clinic A booked 5 slots', '5 minutes ago'),
                             const SizedBox(height: 24),
                             _buildTimelineRow(Icons.edit, 'RMT John updated\navailability', '2 minutes ago'),
                             const SizedBox(height: 24),
                             _buildTimelineRow(Icons.credit_card, 'Clinic C processed\nbilling', '3 minutes ago'),
                             const Spacer(),
                             Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.teal.shade600, borderRadius: BorderRadius.circular(4)), child: const Text('View more', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)))),
                             const SizedBox(height: 16),
                          ]
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTimelineRow(IconData icon, String title, String time) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: Icon(icon, color: const Color(0xFF1B6A9C), size: 14)),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                 ]
              )
           )
        ]
     );
  }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
