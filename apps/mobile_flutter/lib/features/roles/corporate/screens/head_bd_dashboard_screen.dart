import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadBdDashboardScreen extends StatelessWidget {
  const HeadBdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Executive Overview | Global Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Eleanor Vance | Head of BizDev'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildFranchisePipelineRow(context),
            const SizedBox(height: 24),
            _buildAcquisitionRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return Row(
      children: [
         const Expanded(
            child: PrimeCareStatCard(
                title: 'YTD Franchise Growth',
                value: '+18.2%',
                delta: null,
                icon: Icons.trending_up,
            ),
         ),
         const SizedBox(width: 16),
         Expanded(
            child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           const Text('Pipeline Revenue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                 children: [
                                    Icon(Icons.arrow_drop_up, color: Colors.teal.shade700, size: 16),
                                    Text('Active', style: TextStyle(color: Colors.teal.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                                 ]
                              )
                           )
                        ],
                     ),
                     const SizedBox(height: 8),
                     const Text('\$3.5M', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 12),
                     const SizedBox(
                        height: 48,
                        child: ServerLoadGraph(), // Using aesthetic line graph
                     )
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         const Expanded(
            child: PrimeCareStatCard(
                title: 'New Leads',
                value: '127',
                delta: 12,
                icon: Icons.person_add,
            ),
         ),
         const SizedBox(width: 16),
         const Expanded(
            child: PrimeCareStatCard(
                title: 'Avg. Franchise Rev.',
                value: '\$840K',
                delta: 8.4,
                icon: Icons.monetization_on,
            ),
         ),
      ],
    );
  }

  Widget _buildFranchisePipelineRow(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Franchise Performance Data Table
          Expanded(
            flex: 2,
            child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Franchise Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: PrimeCareDataTable<Map<String, dynamic>>(
                      columns: const ['Franchisee Name', 'Location', 'Revenue', 'Growth', 'Leads', 'Actions'],
                      data: const [
                        {'name': 'Franchisee A', 'loc': 'HealthMan', 'rev': '\$18.5M', 'grw': 0.85, 'lead': '127'},
                        {'name': 'Keren Enter B', 'loc': 'Location', 'rev': '\$12.0M', 'grw': 0.65, 'lead': '116'},
                        {'name': 'Daniel Canzes', 'loc': 'Location', 'rev': '\$840K', 'grw': 0.35, 'lead': '12'},
                        {'name': 'Harner Seach', 'loc': 'Location', 'rev': '\$840K', 'grw': 0.30, 'lead': '10'},
                        {'name': 'Telan Knala', 'loc': 'Location', 'rev': '\$840K', 'grw': 0.15, 'lead': '5'},
                      ],
                      rowBuilder: (data) => [
                        DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                        DataCell(Text(data['loc']!)),
                        DataCell(Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(
                           SizedBox(
                              width: 80,
                              child: PrimeCareProgressBar(progress: data['grw'], activeColor: Colors.teal),
                           )
                        ),
                        DataCell(Text(data['lead']!)),
                        DataCell(const Icon(Icons.edit, color: Color(0xFF0F4C81), size: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Growth Pipeline & Conversion (Stacked bars mapped to columns)
          Expanded(
            flex: 1,
            child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Growth Pipeline & Conversion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          _buildStackedBar('Discovery', 58.0),
                          _buildStackedBar('Application', 42.3),
                          _buildStackedBar('LOI', 23.5),
                          _buildStackedBar('Final\nApproval', 13.6),
                          _buildStackedBar('Openings', 7.5),
                       ]
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedBar(String label, double percent) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
           const SizedBox(height: 6),
           Container(
              width: 36,
              height: 180 * (percent / 60.0), // Scale relative to max 60%
              decoration: BoxDecoration(
                 color: const Color(0xFF0F4C81),
                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
              child: Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(
                    height: 90 * (percent / 60.0), // lower half teal
                    color: Colors.teal.shade400,
                 )
              )
           ),
           const SizedBox(height: 12),
           SizedBox(
              height: 28,
              child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey)),
           )
        ]
     );
  }

  Widget _buildAcquisitionRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Performing Franchises Map
        Expanded(
          flex: 2,
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: const [
                      Text('Top Performing Franchises', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.more_horiz, color: Colors.grey),
                   ]
                ),
                const SizedBox(height: 16),
                Container(
                  height: 240,
                  width: double.infinity,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/World_map_blank_without_borders.svg/1000px-World_map_blank_without_borders.svg.png'),
                      fit: BoxFit.cover,
                      opacity: 0.15,
                    )
                  ),
                  child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                        child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                              const Icon(Icons.location_on, color: Colors.teal, size: 20),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisSize: MainAxisSize.min,
                                 children: const [
                                    Text('Location', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                                    Text('Locations', style: TextStyle(fontSize: 12)),
                                 ]
                              ),
                              const SizedBox(width: 16),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisSize: MainAxisSize.min,
                                 children: const [
                                    Text('313', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    Text('Locations', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                 ]
                              ),
                              const SizedBox(width: 16),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisSize: MainAxisSize.min,
                                 children: const [
                                    Text('\$49+', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    Text('Growth', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                 ]
                              )
                           ],
                        )
                     )
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Franchise Acquisition Funnel
        Expanded(
          flex: 1,
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Franchise Acquisition Funnel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 32),
                _buildFunnelLayer('Leads', '1,578', 1.0, const Color(0xFF0F4C81), '3.37%'),
                const SizedBox(height: 8),
                _buildFunnelLayer('Application', '392', 0.8, const Color(0xFF007A8D), '1.72%'),
                const SizedBox(height: 8),
                _buildFunnelLayer('LOI Approval', '166', 0.6, const Color(0xFF00A3A6), '3.35%'),
                const SizedBox(height: 8),
                _buildFunnelLayer('Openings', '25', 0.4, const Color(0xFF00D2B4), '0.32%'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelLayer(String label, String value, double widthFactor, Color color, String dropoff) {
     return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(
              width: 80,
              child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
           ),
           Expanded(
              child: Center(
                 child: FractionallySizedBox(
                    widthFactor: widthFactor,
                    child: Container(
                       height: 48,
                       decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                       alignment: Alignment.center,
                       child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                             const Text('Leads', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          ]
                       )
                    )
                 )
              )
           ),
           SizedBox(
              width: 60,
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    Container(width: 8, height: 1, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(dropoff, style: const TextStyle(fontSize: 12, color: Colors.teal, fontWeight: FontWeight.bold)),
                 ]
              )
           )
        ]
     );
  }
}
