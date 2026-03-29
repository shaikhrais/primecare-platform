import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegBdUsaDashboardScreen extends StatelessWidget {
  const RegBdUsaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const GreetingHeaderWidget(name: 'Regional Business Development Dashboard - USA\nMonday, October 28, 2024'),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.notifications_none, size: 16), SizedBox(width: 8), Text('User Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.keyboard_arrow_down, size: 16)])),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 8),
            const Text('Active Regions: 5 (Northeast, South, Midwest, West, Southwest)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildPerformanceMiddleRow(context),
            const SizedBox(height: 24),
            _buildBottomNetworkRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeCareResponsiveKpiGrid(
 children: [
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('Total Franchise Locations', style: TextStyle(fontSize: 13)),
                     const SizedBox(height: 16),
                     const Text('412', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     const Text('+5% YoY', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 16),
                     const SizedBox(height: 40, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('Total Revenue (YTD)', style: TextStyle(fontSize: 13)),
                     const SizedBox(height: 16),
                     const Text('\$145.8M', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     const Text('18% vs Target', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 16),
                     const SizedBox(height: 40, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('Lead Conversion Rate', style: TextStyle(fontSize: 13)),
                     const SizedBox(height: 16),
                     const Text('38.5%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     const Text('+2.1%', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 16),
                     const SizedBox(height: 40, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('New Franchise Signed (YTD)', style: TextStyle(fontSize: 13)),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: const [
                           Text('29', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           SizedBox(width: 8),
                           Text('Locations', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ]
                     ),
                     const SizedBox(height: 16),
                     const SizedBox(height: 40, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
      ],
    );
  }

  Widget _buildPerformanceMiddleRow(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Regional Performance Stacked Area
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Regional Performance Breakdown (Q4 2024)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 32),
                  SizedBox(child: Stack(
                       children: [
                          Positioned(
                             top: 0, left: 40,
                             child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                                child: const Text('NE: \$31.2M', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
                             )
                          ),
                          Positioned(
                             top: 40, left: 140,
                             child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                                child: const Text('S: \$28.5M', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
                             )
                          ),
                          Padding(
                             padding: const EdgeInsets.only(top: 32),
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   _buildTriStackedBar('Northeast', 0.6, 0.2, 0.2),
                                   _buildTriStackedBar('South', 0.5, 0.3, 0.1),
                                   _buildTriStackedBar('Midwest', 0.4, 0.25, 0.15),
                                   _buildTriStackedBar('West', 0.3, 0.3, 0.2),
                                   _buildTriStackedBar('Southwest', 0.2, 0.4, 0.3),
                                ]
                             )
                          ),
                       ]
                    )
                  ),
                  const SizedBox(height: 16),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                        _buildLegendItem('Active', const Color(0xFF0F4C81)),
                        const SizedBox(width: 16),
                        _buildLegendItem('Growth', Colors.teal.shade700),
                        const SizedBox(width: 16),
                        _buildLegendItem('Review', Colors.teal.shade200),
                     ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Expansion Pipeline Status (Funnel overlay)
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Expansion Pipeline Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 24),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        SizedBox(),
                        Text('Deal stages', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text('Values', style: TextStyle(color: Colors.grey, fontSize: 12)),
                     ]
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  SizedBox(child: PrimeCareResponsiveKpiGrid(
 children: [
                           SizedBox(child: Column(
                                 children: [
                                    _buildCenteredFunnelLayer('145', 1.0, const Color(0xFF0F4C81)),
                                    const SizedBox(height: 4),
                                    _buildCenteredFunnelLayer('62', 0.8, const Color(0xFF1B6A9C)),
                                    const SizedBox(height: 4),
                                    _buildCenteredFunnelLayer('34', 0.6, const Color(0xFF2885B5)),
                                    const SizedBox(height: 4),
                                    _buildCenteredFunnelLayer('18', 0.4, const Color(0xFF33A2CE)),
                                    const SizedBox(height: 4),
                                    _buildCenteredFunnelLayer('9', 0.25, Colors.cyan.shade300),
                                 ]
                              )
                           ),
                           const SizedBox(width: 16),
                           SizedBox(child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                    _buildFunnelLegend('Prospecting', '145', const Color(0xFF0F4C81)),
                                    _buildFunnelLegend('Qualified', '62', const Color(0xFF1B6A9C)),
                                    _buildFunnelLegend('Due Diligence', '34', const Color(0xFF2885B5)),
                                    _buildFunnelLegend('Agreement Sent', '18', const Color(0xFF33A2CE)),
                                    _buildFunnelLegend('Franchise Signed', '9', Colors.cyan.shade300),
                                 ]
                              )
                           ),
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

  Widget _buildTriStackedBar(String label, double val1, double val2, double val3) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(
              width: 32,
              decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.vertical(top: Radius.circular(2))),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    Container(height: 160 * val3, color: Colors.teal.shade200),
                    Container(height: 160 * val2, color: Colors.teal.shade700),
                    Container(height: 160 * val1, color: const Color(0xFF0F4C81)),
                 ]
              )
           ),
           const SizedBox(height: 8),
           Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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

  Widget _buildCenteredFunnelLayer(String value, double widthFactor, Color color) {
     return SizedBox(child: Center(
           child: FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                 decoration: BoxDecoration(color: color),
                 alignment: Alignment.center,
                 child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              )
           )
        )
     );
  }

  Widget _buildFunnelLegend(String text, String count, Color color) {
     return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 8), Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]),
            Text(count, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
         ]
     );
  }

  Widget _buildBottomNetworkRow(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Key Franchise Metrics by Region (Map)
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                        Text('Key Franchise Metrics by Region', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.more_horiz, color: Colors.grey),
                     ]
                  ),
                  const SizedBox(height: 24),
                  SizedBox(child: Stack(
                       alignment: Alignment.center,
                       children: [
                           Container(
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               image: const DecorationImage(
                                 image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                                 fit: BoxFit.contain,
                                 opacity: 0.15,
                               )
                             ),
                           ),
                           Positioned(top: 80, left: 240, child: _buildMapToolTip('NY', '32 Locations\n\$14.2M Rev', '+6% Growth')),
                           const Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                 padding: EdgeInsets.only(bottom: 16.0),
                                 child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                       _MapChip('NY', true),
                                       _MapChip('TX', false),
                                       _MapChip('CA', false),
                                       _MapChip('FL', false),
                                       _MapChip('IL', false),
                                    ],
                                 )
                              )
                           )
                       ]
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Top Performing Franchisees (Q4)
          SizedBox(child: PrimeCareCard(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: const [
                          Text('Top Performing Franchisees (Q4)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Icon(Icons.more_horiz, color: Colors.grey),
                       ]
                    ),
                    const SizedBox(height: 24),
                    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('List        Region', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('Growth', style: TextStyle(color: Colors.grey, fontSize: 12))]),
                    const Divider(height: 24),
                    _buildLeaderboardRow('1.', 'C', 'CityMed Boston\nRegion', '\$1.8M'),
                    const Divider(height: 24),
                    _buildLeaderboardRow('2.', 'H', 'HealthFirst Dallas\nRegion', '\$1.6M'),
                    const Divider(height: 24),
                    _buildLeaderboardRow('3.', 'U', 'UrgentCare LA\nRegion', '\$1.5M'),
                    const Divider(height: 24),
                    _buildLeaderboardRow('4.', 'P', 'Premier Care ATL\nRegion', '\$1.3M'),
                 ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapToolTip(String title, String subtitle, String pop) {
     return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(subtitle, style: const TextStyle(color: Colors.black87, fontSize: 10)),
              Text(pop, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
           ]
        )
     );
  }
}

class _MapChip extends StatelessWidget {
   final String label;
   final bool active;
   const _MapChip(this.label, this.active);
   @override
   Widget build(BuildContext context) {
      return Container(
         width: 60, height: 32, alignment: Alignment.center,
         decoration: BoxDecoration(color: active ? const Color(0xFF0F4C81) : Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
         child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 11)),
      );
   }
}

Widget _buildLeaderboardRow(String num, String initial, String name, String growth) {
   return PrimeCareResponsiveKpiGrid(
 children: [
         Text(num, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
         const SizedBox(width: 16),
         CircleAvatar(radius: 16, backgroundColor: Colors.grey.shade200, child: Text(initial, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
         const SizedBox(width: 12),
         SizedBox(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
         Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(growth, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
               PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.arrow_drop_up, color: Colors.green, size: 16), Text('Growth', style: TextStyle(color: Colors.green, fontSize: 10))]),
            ]
         )
      ]
   );
}
