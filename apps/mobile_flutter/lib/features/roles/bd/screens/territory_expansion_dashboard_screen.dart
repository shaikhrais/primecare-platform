import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryExpansionDashboardScreen extends StatelessWidget {
  const TerritoryExpansionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const GreetingHeaderWidget(name: 'Territory Expansion Overview'),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)),
                     child: const Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  )
               ]
            ),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildMarketHeatmapCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildDualPipelineCard()),
               ]
            ).withHeight(360),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildKeyMarketsTableCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildUpcomingAppointmentsCard()),
               ]
            ).withHeight(340),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeCareResponsiveKpiGrid(
 children: [
         SizedBox(child: _buildSparklineCard('Open Markets', '+2', '8', 'Open Markets')),
         const SizedBox(width: 16),
         SizedBox(child: _buildSparklineCard('Active Leads', '+12', '45', 'Active Leads')),
         const SizedBox(width: 16),
         SizedBox(child: _buildSparklineCard('Approved Franchises', '+4', '19', 'Approved Franchises')),
         const SizedBox(width: 16),
         SizedBox(child: _buildSparklineCard('Revenue Potential', '+15%', '\$8.5M', 'Revenue Potential')),
      ],
    );
  }

  Widget _buildSparklineCard(String title, String variance, String val, String subtitle) {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: Text(variance, style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                 ]
              ),
              const SizedBox(height: 16),
              Text(val, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const SizedBox(height: 48, child: ServerLoadGraph()), // Aesthetic line
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
           ]
        )
     );
  }

  Widget _buildMarketHeatmapCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Market Performance Heatmap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PrimeCareResponsiveKpiGrid(
 children: const [
                          Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 16),
                          SizedBox(width: 8),
                          Text('Target Expansion Hubs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Container(
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           image: const DecorationImage(
                             image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                             fit: BoxFit.contain,
                             opacity: 0.25,
                           )
                         ),
                       ),
                       _buildHeatmapPin(60, 100),   // WA
                       _buildHeatmapPin(150, 60),  // CA north
                       _buildHeatmapPin(220, 100), // CA south
                       _buildHeatmapPin(200, 200), // AZ
                       _buildHeatmapPin(260, 320), // TX
                       _buildHeatmapPin(180, 480), // IL
                       _buildHeatmapPin(100, 580), // NY
                       _buildHeatmapPin(160, 520), // OH
                       _buildHeatmapPin(180, 600), // Mid-Atlantic
                       _buildHeatmapPin(260, 620), // FL
                       Positioned(
                          bottom: 20, right: 40,
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                _buildLegendItem('High', Colors.teal.shade500),
                                const SizedBox(height: 8),
                                _buildLegendItem('Medium', Colors.blue.shade600),
                                const SizedBox(height: 8),
                                _buildLegendItem('Low', Colors.grey.shade300),
                             ]
                          )
                       )
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildHeatmapPin(double top, double left) {
     return Positioned(
        top: top, left: left,
        child: Container(
           padding: const EdgeInsets.all(4),
           decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
           child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16),
        )
     );
  }

  Widget _buildLegendItem(String label, Color c) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 12, height: 12, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
           const SizedBox(width: 8),
           Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildDualPipelineCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Lead Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                       SizedBox(child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                                _buildFunnelRow('New', '18', 1.0, const Color(0xFF1B6A9C)),
                                _buildFunnelRow('Contacted', '12', 0.8, const Color(0xFF2885B5)),
                                _buildFunnelRow('Qualified', '9', 0.6, const Color(0xFF33A2CE)),
                                _buildFunnelRow('Proposal', '6', 0.45, Colors.cyan.shade600),
                                _buildFunnelRow('Closed', '4', 0.3, Colors.teal),
                             ]
                          )
                       ),
                       const SizedBox(width: 8),
                       SizedBox(child: Stack(
                             children: [
                                _buildHLine(0.1, '28%'),
                                _buildHLine(0.3, '12%'),
                                _buildHLine(0.5, '9%'),
                                _buildHLine(0.7, '6%'),
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                      _buildBar(0.9, const Color(0xFF1B6A9C), 'New'),
                                      _buildBar(0.6, const Color(0xFF2885B5), 'Con'),
                                      _buildBar(0.4, const Color(0xFF33A2CE), 'Pro'),
                                      _buildBar(0.2, Colors.teal, 'Clo'),
                                   ]
                                )
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

  Widget _buildFunnelRow(String title, String val, double width, Color c) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           SizedBox(width: 70, child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
           SizedBox(child: Center(
                 child: FractionallySizedBox(
                    widthFactor: width,
                    child: Container(
                       height: 32,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(color: c),
                       child: Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    )
                 )
              )
           )
        ]
     );
  }

  Widget _buildHLine(double topPercent, String lbl) {
     return Positioned(
        top: 250 * topPercent, left: 0, right: 0,
        child: PrimeCareResponsiveKpiGrid(
 children: [
              SizedBox(child: Divider(color: Colors.grey.shade300)),
              const SizedBox(width: 4),
              Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.grey)),
           ]
        )
     );
  }

  Widget _buildBar(double height, Color c, String lbl) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(width: 14, height: 180 * height, color: c),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildKeyMarketsTableCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Key Markets Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                       decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                       child: PrimeCareResponsiveKpiGrid(
 children: [
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(right: BorderSide(color: Colors.grey.shade300))), child: const Text('Area', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade300))), child: const Text('Bar', style: TextStyle(fontSize: 11))),
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: const Text('Heatmap', style: TextStyle(fontSize: 11))),
                          ]
                       )
                    ),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['Region', 'Manager', 'Leads', 'Status', 'Potential', 'Growth', ''],
                    data: const [
                       {'reg': 'California North', 'mgr': 'Sarah Jenkin', 'leads': '18', 'stat': 'Active', 'pot': '\$8.5M', 'growth': '24%'},
                       {'reg': 'Texas South', 'mgr': 'Sarah Jevan', 'leads': '15', 'stat': 'High Priority', 'pot': '\$8.5M', 'growth': '24%'},
                       {'reg': 'California North', 'mgr': 'Sarah Jenkin', 'leads': '12', 'stat': 'High Priority', 'pot': '\$8.5M', 'growth': '26%'},
                       {'reg': 'Texas South', 'mgr': 'Sarah Jevan', 'leads': '9', 'stat': 'Active', 'pot': '\$3.5M', 'growth': '23%'},
                       {'reg': 'Texas South', 'mgr': 'Sarah Jenki', 'leads': '4', 'stat': 'Active', 'pot': '\$1.5M', 'growth': '15%'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['reg']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [CircleAvatar(radius: 10, backgroundColor: Colors.blue.shade100, child: const Icon(Icons.person, size: 12, color: Colors.blue)), const SizedBox(width: 8), Text(data['mgr']!, style: const TextStyle(fontSize: 12))])),
                       DataCell(Text(data['leads']!, style: const TextStyle(fontSize: 12))),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                             decoration: BoxDecoration(color: data['stat'] == 'Active' ? Colors.teal : const Color(0xFF1B6A9C), borderRadius: BorderRadius.circular(12)),
                             child: Text(data['stat']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                       ),
                       DataCell(Text(data['pot']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['growth']!, style: const TextStyle(fontSize: 12))),
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.edit, color: Colors.grey, size: 16), SizedBox(width: 8), Icon(Icons.more_vert, color: Colors.grey, size: 16)])),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildUpcomingAppointmentsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Upcoming Appointments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildAptTile('Meeting + Franchisee', '8 am - 1:10 am', true),
                       _buildAptTile('Meeting + Franchisee', 'Franchisee Candidate', false),
                       _buildAptTile('Meeting - Franchisee', 'Team - 3:0 pm', false),
                       _buildAptTile('Meeting - Candidates', 'Team - 1:0 pm', false),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildAptTile(String title, String subtitle, bool isTeal) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: isTeal ? Colors.teal.shade50 : Colors.white, borderRadius: BorderRadius.circular(8)),
        child: PrimeCareResponsiveKpiGrid(
 children: [
              Container(width: 4, height: 32, decoration: BoxDecoration(color: isTeal ? Colors.teal : const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4))),
              const SizedBox(width: 12),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.black87, fontSize: 11)),
                 ]
              )
           ]
        )
     );
  }
}
