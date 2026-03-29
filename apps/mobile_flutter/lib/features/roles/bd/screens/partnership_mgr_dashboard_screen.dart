import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipMgrDashboardScreen extends StatelessWidget {
  const PartnershipMgrDashboardScreen({super.key});

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
                  const GreetingHeaderWidget(name: 'Medifuse Franchise Dashboard'),
                  Row(
                     children: [
                        SizedBox(width: 240, child: TextField(decoration: InputDecoration(hintText: 'Search', prefixIcon: const Icon(Icons.search, size: 18), filled: true, fillColor: Colors.white, isDense: true, contentPadding: const EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)))),
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_active_outlined, color: Colors.grey),
                        const SizedBox(width: 16),
                        Row(
                           children: [
                              CircleAvatar(radius: 12, backgroundColor: Colors.blue.shade100, child: const Icon(Icons.person, color: Colors.blue, size: 16)),
                              const SizedBox(width: 8),
                              const Text('Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            Row(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  Expanded(flex: 2, child: _buildPartnershipOverviewCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: _buildNetworkDistributionCard()),
               ]
            ).withHeight(400),
            const SizedBox(height: 24),
            Row(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  Expanded(flex: 2, child: _buildRecentPartnershipsTableCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: _buildTopPerformingColumnsCard()),
               ]
            ).withHeight(340),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return Row(
      children: [
         Expanded(
            child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Active Partnerships', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.handshake_outlined, color: Colors.grey, size: 18)]),
                     const SizedBox(height: 24),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('124', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.trending_up, color: Colors.green, size: 14), SizedBox(width: 4), Text('+8%', style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))])),
                        ]
                     ),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         Expanded(
            child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Network Clinics', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.insert_chart_outlined, color: Colors.grey, size: 18)]),
                     const SizedBox(height: 24),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('38', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.bar_chart, color: Colors.blue, size: 14), SizedBox(width: 4), Text('+3', style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold))])),
                        ]
                     ),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         Expanded(
            child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Revenue Generated', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.monetization_on_outlined, color: Colors.grey, size: 18)]),
                     const SizedBox(height: 24),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('\$1.2M', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.trending_up, color: Colors.green, size: 14), SizedBox(width: 4), Text('+15%', style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))])),
                        ]
                     ),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         Expanded(
            child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('New Contracts (Q3)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Icon(Icons.description_outlined, color: Colors.grey, size: 18)]),
                     const SizedBox(height: 24),
                     const Text('17', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ]
               )
            ),
         ),
      ],
    );
  }

  Widget _buildPartnershipOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Partnership Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Text('Part data', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('Active Partnerships & Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Jan-Sep', style: TextStyle(color: Colors.grey, fontSize: 12)),
                       ]
                    ),
                    Row(
                       children: [
                          const Text('124', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Current', style: TextStyle(color: Colors.grey, fontSize: 11)), Text('Partners', style: TextStyle(color: Colors.grey, fontSize: 11))]),
                       ]
                    )
                 ]
              ),
              const SizedBox(height: 24),
              Expanded(
                 child: Stack(
                    children: [
                       const Positioned.fill(child: ServerLoadGraph()), // Underlay mapping the visual
                       Positioned(bottom: 50, left: 60, child: _buildGrowthTooltip('36,138')),
                       Positioned(bottom: 110, left: 140, child: _buildGrowthTooltip('54,195')),
                       Positioned(bottom: 150, left: 220, child: _buildGrowthTooltip('78,394')),
                       Positioned(bottom: 140, right: 60, child: _buildGrowthTooltip('124')),
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildGrowthTooltip(String val) {
     return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
        child: Text(val, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
     );
  }

  Widget _buildNetworkDistributionCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Network Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 flex: 2,
                 child: Container(
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     color: Colors.teal.shade50.withOpacity(0.5),
                     borderRadius: BorderRadius.circular(8),
                     image: const DecorationImage(
                       image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                       fit: BoxFit.contain,
                       opacity: 0.2,
                     )
                   ),
                   child: Stack(
                      children: [
                         Positioned(top: 20, left: 30, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 80, left: 20, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 100, left: 150, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 60, left: 180, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 130, left: 190, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 80, left: 240, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 150, left: 260, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 60, left: 280, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 90, left: 290, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                         Positioned(top: 60, left: 330, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 16)),
                      ]
                   ),
                 )
              ),
              const SizedBox(height: 24),
              Expanded(
                 flex: 1,
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('New York', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text('9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                       const Divider(),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Chicago', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text('7', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                       const Divider(),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Los Angeles', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text('6', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildRecentPartnershipsTableCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Partnerships', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Text('Scroll raing', style: TextStyle(fontSize: 11)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Clinic Name', 'Type', 'Start Date', 'Performance', 'Contract Value', 'Status'],
                    data: const [
                       {'name': 'Clinic Name', 'type': 'Healthcare', 'start': '09/10/2023', 'perf': '80%', 'val': '\$10,000', 'stat': 'Active'},
                       {'name': 'Clinic Eecitation', 'type': 'Healthcare', 'start': '08/10/2023', 'perf': '80%', 'val': '\$40,000', 'stat': 'Pending'},
                       {'name': 'Clinic Name', 'type': 'Healthy', 'start': '08/10/2023', 'perf': '80%', 'val': '\$30,000', 'stat': 'Pending'},
                       {'name': 'Clinic Name', 'type': 'Healthcare', 'start': '08/10/2023', 'perf': '15%', 'val': '\$20,000', 'stat': 'Active'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(Text(data['type']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['start']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Row(children: [const Icon(Icons.show_chart, color: Colors.green, size: 16), const SizedBox(width: 4), Text(data['perf']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12))])),
                       DataCell(Text(data['val']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                             decoration: BoxDecoration(color: data['stat'] == 'Active' ? Colors.green.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
                             child: Text(data['stat']!, style: TextStyle(color: data['stat'] == 'Active' ? Colors.green : Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                       ),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTopPerformingColumnsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Top Performing Clinics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text('Quarterly Revenue', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 16),
              Expanded(
                 child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildRevColumn('Clinic', 0.5, '435', false),
                       _buildRevColumn('Mew', 0.4, '179', false),
                       _buildRevColumn('Clin', 0.6, '336', false),
                       _buildRevColumn('Csv', 0.8, '\$59K', true),
                       _buildRevColumn('Los', 0.7, '\$15K', true),
                       _buildRevColumn('Sep', 0.95, '\$00K', true),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildRevColumn(String label, double val, String tooltip, bool isDarkTooltip) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(color: isDarkTooltip ? const Color(0xFF0F4C81) : const Color(0xFF1B6A9C), borderRadius: BorderRadius.circular(4)),
              child: Text(tooltip, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
           ),
           const SizedBox(height: 4),
           Container(width: 20, height: 160 * val, decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: const BorderRadius.vertical(top: Radius.circular(2)))),
           const SizedBox(height: 8),
           Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ]
     );
  }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
