import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CfoDashboardScreen extends StatelessWidget {
  const CfoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Overview | Q3 2024 Financial Performance'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'David Chen | CFO'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildFinancialOverviewRow(context),
            const SizedBox(height: 24),
            _buildOperationalDistributionsRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return const PrimeCareResponsiveKpiGrid(
 children: [
         SizedBox(child: PrimeCareStatCard(
                title: 'Total Revenue',
                value: '\$48.7M',
                delta: 12.1,
                icon: Icons.account_balance_wallet,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'Net Profit',
                value: '\$7.2M',
                delta: 15.5,
                icon: Icons.pie_chart_outline,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'EBITDA Margin',
                value: '18.4%',
                delta: 0.8,
                icon: Icons.bar_chart,
            ),
         ),
         SizedBox(width: 16),
         SizedBox(child: PrimeCareStatCard(
                title: 'Operating Cash Flow',
                value: '\$9.1M',
                delta: 6.3,
                icon: Icons.timeline,
            ),
         ),
      ],
    );
  }

  Widget _buildFinancialOverviewRow(BuildContext context) {
    return PrimeCareResponsiveKpiGrid(
 children: [
        // Left: Financial Performance Overview
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                            Text('Financial Performance Overview (Q3 2024)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            Text('Interactive area usages and charts.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                         ],
                      ),
                      PrimeCareButton(label: 'Export', icon: Icons.download, onPressed: (){}),
                   ]
                ),
                const SizedBox(height: 24),
                // Legend
                PrimeCareResponsiveKpiGrid(
 children: [
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.teal.shade300, borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 8),
                      const Text('Revenue', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 16),
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 8),
                      const Text('Expense', style: TextStyle(fontSize: 12)),
                   ],
                ),
                const SizedBox(height: 16),
                const SizedBox(child: PrimeCareBarChart(
                    data: {
                      'Mar': 120,
                      'Apr': 150,
                      'May': 180,
                      'Jun': 200,
                      'Jul': 240,
                      'Aug': 260,
                      'Sep': 320,
                      'Oct': 350,
                    },
                    barColor: Color(0xFF0F4C81),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Right: Franchise Portfolio Performance 
        SizedBox(child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                            Text('Franchise Portfolio Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            Text('120 Locations', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
                         ],
                      ),
                      PrimeCareButton(label: 'Export', icon: Icons.download, onPressed: (){}),
                   ]
                ),
                const SizedBox(height: 16),
                SizedBox(child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                        fit: BoxFit.contain,
                        opacity: 0.15,
                      )
                    ),
                    child: const Icon(Icons.location_on, size: 54, color: Color(0xFF0F4C81)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                            Text('Total revenue contribution', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            SizedBox(height: 4),
                            Text('\$48.7M sized by revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                         ]
                      ),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                            Text('Top Performers:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            SizedBox(height: 4),
                            Text('Boston, SF, Chicago', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                         ]
                      ),
                   ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOperationalDistributionsRow(BuildContext context) {
    return SizedBox(
      height: 380, // strict boundary constraint to align table and donut chart equally
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Data Table Top Franchises
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Top Performing Franchises (Q3)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        PrimeCareButton(label: 'Export', icon: Icons.download, onPressed: (){}),
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                      columns: const ['Ranking', 'Location', 'Revenue', 'Growth', 'Profitability'],
                      data: const [
                        {'rnk': '1', 'loc': 'Bestamolenity', 'rev': '\$48.7M', 'grw': '12.1%', 'pro': '5.85%'},
                        {'rnk': '2', 'loc': 'SF', 'rev': '\$48.7M', 'grw': '15.5%', 'pro': '2.35%'},
                        {'rnk': '3', 'loc': 'Chicago', 'rev': '\$42.7M', 'grw': '10.8%', 'pro': '3.25%'},
                        {'rnk': '4', 'loc': 'Boston', 'rev': '\$28.7M', 'grw': '15.5%', 'pro': '3.05%'},
                        {'rnk': '5', 'loc': 'Marketing', 'rev': '\$20.7M', 'grw': '12.8%', 'pro': '0.35%'},
                      ],
                      rowBuilder: (data) => [
                        DataCell(Text(data['rnk']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(data['loc']!)),
                        DataCell(Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                        DataCell(
                           PrimeCareResponsiveKpiGrid(
 children: [
                                 const Icon(Icons.arrow_drop_up, color: Colors.green, size: 20),
                                 Text(data['grw']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ]
                           )
                        ),
                        DataCell(Text(data['pro']!)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Donut Chart Operating Expenses Breakdown
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Operating Expenses Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 24),
                  SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                          SizedBox(child: Center(
                               child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   SizedBox(
                                      width: 180, 
                                      height: 180, 
                                      child: CircularProgressIndicator(value: 1.0, color: Colors.teal.shade200, strokeWidth: 40)
                                   ),
                                   const SizedBox(
                                      width: 180, 
                                      height: 180, 
                                      child: CircularProgressIndicator(value: 0.70, color: Colors.lightBlue, strokeWidth: 40)
                                   ),
                                   const SizedBox(
                                      width: 180, 
                                      height: 180, 
                                      child: CircularProgressIndicator(value: 0.40, color: Color(0xFF0F4C81), strokeWidth: 40)
                                   ),
                                 ],
                               )
                             ),
                          ),
                          Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                _buildLegendItem('Salaries', const Color(0xFF0F4C81)),
                                const SizedBox(height: 8),
                                _buildLegendItem('Facilities', Colors.lightBlue),
                                const SizedBox(height: 8),
                                _buildLegendItem('Medical Supplies', Colors.teal.shade200),
                                const SizedBox(height: 8),
                                _buildLegendItem('Admin', Colors.cyan),
                                const SizedBox(height: 8),
                                _buildLegendItem('Marketing', Colors.grey.shade400),
                             ]
                          )
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

   Widget _buildLegendItem(String label, Color color) {
     return PrimeCareResponsiveKpiGrid(
 children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
       ],
     );
   }
}
