import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadMarketingDashboardScreen extends StatelessWidget {
  const HeadMarketingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Marketing Performance Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GreetingHeaderWidget(name: 'Hi, Sarah (HoM)\nWelcome Back!'),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildAcquisitionRow(context),
            const SizedBox(height: 24),
            _buildCampaignDistributionsRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeCareResponsiveKpiGrid(
 children: [
         const SizedBox(child: PrimeCareStatCard(
                title: 'Total Revenue',
                value: '\$1.2M',
                delta: 8.0,
                icon: Icons.monetization_on,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'New Patient Leads',
                value: '14.5K',
                delta: 15.0,
                icon: Icons.person_add,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'Marketing Spend',
                value: '\$180K',
                delta: -3.0,
                icon: Icons.account_balance_wallet,
            ),
         ),
         const SizedBox(width: 16),
         const SizedBox(child: PrimeCareStatCard(
                title: 'CAC',
                value: '\$12.50',
                delta: -5.0,
                icon: Icons.monetization_on_outlined,
            ),
         ),
      ],
    );
  }

  Widget _buildAcquisitionRow(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Patient Acquisition Breakdown
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
                              Text('Patient Acquisition Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('Multi-channel line and area chart', style: TextStyle(color: Colors.grey, fontSize: 13)),
                           ]
                        ),
                        PrimeCareButton(label: 'View Report', onPressed: (){}),
                     ]
                  ),
                  const SizedBox(height: 16),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                        _buildLegendItem('SEO', const Color(0xFF0F4C81)),
                        const SizedBox(width: 16),
                        _buildLegendItem('Paid Ads', Colors.teal),
                        const SizedBox(width: 16),
                        _buildLegendItem('Social', Colors.cyan),
                        const SizedBox(width: 16),
                        _buildLegendItem('Referrals', Colors.lightBlue),
                     ],
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(child: ServerLoadGraph(), // Natively interpolating the multi-line chart structure
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Franchise Performance Overview Bars
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
                              Text('Franchise Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('Top 10 franchises by revenue and leads sorted', style: TextStyle(color: Colors.grey, fontSize: 13)),
                           ]
                        ),
                        PrimeCareButton(label: 'View Report', onPressed: (){}),
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          _buildHorizontalBar('Austin', '\$145K', 1.0, '1200 Leads'),
                          _buildHorizontalBar('Commark', '\$123K', 0.85, '1100 Leads'),
                          _buildHorizontalBar('Canron', '\$55K', 0.65, '700 Leads'),
                          _buildHorizontalBar('Bannan', '\$100K', 0.60, '600 Leads'),
                          _buildHorizontalBar('Deacon', '\$30K', 0.45, '500 Leads'),
                          _buildHorizontalBar('Mavin', '\$55K', 0.40, '400 Leads'),
                          _buildHorizontalBar('Beroriz', '\$20K', 0.35, '200 Leads'),
                          _buildHorizontalBar('Slevana', '\$12.5K', 0.25, '100 Leads'),
                          _buildHorizontalBar('Italia', '\$12.5K', 0.20, '100 Leads'),
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

  Widget _buildHorizontalBar(String city, String rev, double widthPercent, String leads) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           SizedBox(width: 60, child: Text(city, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
           SizedBox(width: 50, child: Text(rev, style: const TextStyle(fontSize: 12))),
           SizedBox(child: FractionallySizedBox(
                 alignment: Alignment.centerLeft,
                 widthFactor: widthPercent,
                 child: Container(
                    height: 16,
                    decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: BorderRadius.circular(4)),
                 )
              )
           ),
           SizedBox(width: 80, child: Text(leads, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
        ]
     );
  }

  Widget _buildLegendItem(String label, Color color) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
           const SizedBox(width: 8),
           Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ]
     );
  }

  Widget _buildCampaignDistributionsRow(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Top Campaigns Data Table
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Top Campaigns', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                           decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)),
                           child: const Text('Manage Campaigns', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        )
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                      columns: const ['Campaign Name', 'Spend', 'Leads', 'ROI', 'Status'],
                      data: const [
                        {'name': 'Fall Health Drive', 'spend': '\$15K', 'leads': '2100', 'roi': '4.2x', 'stat': 'Active'},
                        {'name': 'Fall Health Spent', 'spend': '\$15K', 'leads': '2100', 'roi': '4.2x', 'stat': 'Active'},
                        {'name': 'Domext silent', 'spend': '\$15K', 'leads': '2100', 'roi': '4.2x', 'stat': 'Active'},
                        {'name': 'Patient Strive', 'spend': '\$15K', 'leads': '1100', 'roi': '4.2x', 'stat': 'Active'},
                      ],
                      rowBuilder: (data) => [
                        DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                        DataCell(Text(data['spend']!)),
                        DataCell(Text(data['leads']!)),
                        DataCell(Text(data['roi']!)),
                        DataCell(
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                              child: Text(data['stat']!, style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                           )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Social Engagement Metrics Donut Chart
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Social Engagement Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text('Engagement by Platform', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 24),
                  SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                          SizedBox(child: Center(
                               child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   SizedBox(
                                      width: 140, 
                                      height: 140, 
                                      child: CircularProgressIndicator(value: 1.0, color: Colors.teal.shade300, strokeWidth: 35)
                                   ),
                                   const SizedBox(
                                      width: 140, 
                                      height: 140, 
                                      child: CircularProgressIndicator(value: 0.55, color: Color(0xFF0F4C81), strokeWidth: 35)
                                   ),
                                   const SizedBox(
                                      width: 140, 
                                      height: 140, 
                                      child: CircularProgressIndicator(value: 0.25, color: Colors.cyan, strokeWidth: 35)
                                   ),
                                 ],
                               )
                             ),
                          ),
                          Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                _buildLegendItem('Instagram (45K)', const Color(0xFF0F4C81)),
                                const SizedBox(height: 8),
                                _buildLegendItem('Facebook (30%)', Colors.teal.shade300),
                                const SizedBox(height: 8),
                                _buildLegendItem('LinkedIn (15%)', Colors.cyan),
                                const SizedBox(height: 8),
                                _buildLegendItem('TikTok (10%)', Colors.lightBlue),
                             ]
                          )
                       ]
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Recent Leads Feed List
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Recent Leads Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        SizedBox(child: Text('Patient Name', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                        SizedBox(child: Text('Franchise', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                        SizedBox(child: Text('Source', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                        SizedBox(child: Text('Date', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                     ]
                  ),
                  const Divider(height: 24),
                  _buildLeadRow('Sarah\nJohnson', 'Health', 'Source', 'Oct 26'),
                  const Divider(height: 16),
                  _buildLeadRow('John F.\nStecker', 'Franchi', 'Source', 'Oct 27'),
                  const Divider(height: 16),
                  _buildLeadRow('Bantern\nDannson', 'Health', 'Source', 'Oct 28'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadRow(String name, String fran, String src, String date) {
     return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            SizedBox(child: Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
            SizedBox(child: Text(fran, style: const TextStyle(fontSize: 11, color: Colors.grey))),
            SizedBox(child: Text(src, style: const TextStyle(fontSize: 11, color: Colors.grey))),
            SizedBox(child: Text(date, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
         ]
     );
  }
}
