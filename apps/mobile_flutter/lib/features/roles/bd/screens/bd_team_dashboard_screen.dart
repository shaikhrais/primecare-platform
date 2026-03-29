import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BdTeamDashboardScreen extends StatelessWidget {
  const BdTeamDashboardScreen({super.key});

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
                  const GreetingHeaderWidget(name: 'Good morning, Sarah Chen!\nFranchise Development Overview'),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add_chart, color: Colors.grey, size: 20)),
                        const SizedBox(width: 16),
                        PrimeCareButton(label: 'New Lead', onPressed: (){}),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildPipelineAndMapRow(context),
            const SizedBox(height: 24),
            _buildGrowthAndLeadsRow(context),
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
                     PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.store, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Total Franchises', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold))]),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: const [
                           Text('214', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           SizedBox(width: 8),
                           Text('+12% MoM', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                        ]
                     ),
                     const SizedBox(height: 16),
                     const SizedBox(height: 48, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.format_list_bulleted, color: Colors.grey, size: 16), SizedBox(width: 8), Text('Active Leads', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold))]),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('89', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           const SizedBox(width: 8),
                           Text('5 New', style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.bold)),
                        ]
                     ),
                     const SizedBox(height: 16),
                     const SizedBox(height: 48, child: ServerLoadGraph()),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.monetization_on, color: Colors.teal, size: 16), SizedBox(width: 8), Text('Pipeline Value', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold))]),
                     const SizedBox(height: 16),
                     const Text('\$18.4M', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 32),
                     PrimeCareProgressBar(progress: 0.8, activeColor: Colors.teal.shade500),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 16), SizedBox(width: 8), Text('Locations Open', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold))]),
                     const SizedBox(height: 16),
                     const Text('168', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 32),
                     PrimeCareProgressBar(progress: 0.65, activeColor: const Color(0xFF0F4C81)),
                  ]
               )
            ),
         ),
      ],
    );
  }

  Widget _buildPipelineAndMapRow(BuildContext context) {
    return SizedBox(
      height: 340,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Lead Acquisition Pipeline (Funnel)
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Lead Acquisition Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(4)),
                           child: const Text('New Lead', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                     ]
                  ),
                  const SizedBox(height: 24),
                  SizedBox(child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          _buildFunnelRow('Identified', '35', 1.0, 0.7, Colors.teal.shade300),
                          _buildFunnelRow('Contacted', '28', 0.8, 0.6, const Color(0xFF0F4C81)),
                          _buildFunnelRow('Qualified', '15', 0.6, 0.4, Colors.blue.shade600),
                          _buildFunnelRow('Neg.', '7', 0.4, 0.3, Colors.blue.shade800),
                          _buildFunnelRow('Signed', '4', 0.25, 0.15, const Color(0xFF0F4C81)),
                       ]
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Regional Performance Map
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Regional Performance Map', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                           child: const Text('Export Report', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: Stack(
                        alignment: Alignment.center,
                        children: [
                           Container(
                             decoration: BoxDecoration(
                               image: const DecorationImage(
                                 image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                                 fit: BoxFit.contain,
                                 opacity: 0.3,
                               )
                             ),
                           ),
                           Positioned(top: 130, left: 160, child: _buildMapNode('West\n51', Colors.teal.shade600)),
                           Positioned(top: 80, left: 280, child: _buildMapNode('Midwest\n65', Colors.teal.shade500)),
                           Positioned(top: 180, left: 360, child: _buildMapNode('South\n50', const Color(0xFF0F4C81))),
                           Positioned(top: 60, left: 400, child: _buildMapNode('Northeast\n48', const Color(0xFF0A3159))),
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

  Widget _buildMapNode(String text, Color bg) {
     return Container(
        width: 60, height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]),
        child: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
     );
  }

  Widget _buildFunnelRow(String label, String count, double widthFactor, double innerProgress, Color color) {
     return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
            SizedBox(child: Center(
                  child: FractionallySizedBox(
                     widthFactor: widthFactor,
                     child: Container(
                        height: 36,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                           color: color.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                           widthFactor: innerProgress / widthFactor,
                           child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
                           )
                        )
                     )
                  )
               )
            ),
            SizedBox(width: 40, child: Text(count, textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
         ]
     );
  }

  Widget _buildGrowthAndLeadsRow(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Monthly Franchise Growth
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
                              Text('Monthly Franchise Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('Q1-Q3 2024 | growth vs target', style: TextStyle(color: Colors.grey, fontSize: 12)),
                           ]
                        ),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                           child: PrimeCareResponsiveKpiGrid(
 children: const [
                                 Text('Q1-Q3 2024', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                                 Icon(Icons.keyboard_arrow_down, size: 16),
                              ]
                           )
                        ),
                     ]
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(child: ServerLoadGraph(), // Stand-in for aesthetic Q1-Q3 Growth Line Graph
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Top Leads & Deals
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Top Leads & Deals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                           child: const Text('Export Report', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                     ]
                  ),
                  const SizedBox(height: 24),
                  _buildLeadDeal('Dr. Amelia Reed', 'SF Clinic', '\$2.2M', 'Negotiation', '326', 0.85, const Color(0xFF0F4C81)),
                  const Divider(height: 32),
                  _buildLeadDeal('Health Partners Group', 'Dallas', '\$4.5M', 'Due Diligence', '50%', 0.65, Colors.teal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadDeal(String doc, String clinic, String val, String status, String statVal, double prog, Color color) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           CircleAvatar(radius: 20, backgroundColor: Colors.blue.shade100, child: const Icon(Icons.person, color: Colors.blue)),
           const SizedBox(width: 16),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(doc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(clinic, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 8),
                    PrimeCareProgressBar(progress: prog, activeColor: color),
                 ]
              )
           ),
           const SizedBox(width: 16),
           Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                 Text(status, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                 const SizedBox(height: 8),
                 PrimeCareResponsiveKpiGrid(
 children: [
                       const Text('Stats:', style: TextStyle(color: Colors.grey, fontSize: 11)),
                       const SizedBox(width: 4),
                       Text(statVal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    ]
                 )
              ]
           )
        ]
     );
  }
}
