import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegBdOnDashboardScreen extends StatelessWidget {
  const RegBdOnDashboardScreen({super.key});

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
                  const GreetingHeaderWidget(name: 'Ontario Regional Dashboard - Q4 2024'),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.filter_list, size: 16), SizedBox(width: 8), Text('Filter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.swap_vert, color: Colors.grey, size: 20)),
                        const SizedBox(width: 16),
                        Flexible(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 200), child: TextField(decoration: InputDecoration(hintText: 'Search', prefixIcon: const Icon(Icons.search, size: 18), filled: true, fillColor: Colors.grey.shade100, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none))))),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            _buildOperationsMiddleRow(context),
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
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Regional Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.show_chart, color: Colors.grey, size: 16)]),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('\$2.4M', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           const Spacer(),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Text('+12.8%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                        ]
                     ),
                     const Text('Revenue', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Active Franchisees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.group, color: Colors.grey, size: 16)]),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('58', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           const Spacer(),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Text('+4.8%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                        ]
                     ),
                     const Text('Clinics', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Patient Visits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.local_hospital, color: Colors.grey, size: 16)]),
                     const SizedBox(height: 16),
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                        children: [
                           const Text('185K', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           const Spacer(),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Text('+8.1%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                        ]
                     ),
                     const Text('Visits', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('New Franchise Leads', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Icon(Icons.star, color: Colors.teal, size: 16)]),
                     const SizedBox(height: 16),
                     const Text('24', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const Text('New Franchise Leads', style: TextStyle(fontSize: 12, color: Colors.grey)),
                     const SizedBox(height: 24),
                     Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: const [
                              Text('Teal highlight', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              Icon(Icons.chevron_right, color: Colors.white, size: 16),
                           ]
                        )
                     )
                  ]
               )
            ),
         ),
      ],
    );
  }

  Widget _buildOperationsMiddleRow(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Franchise Performance Data Table
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        const Text('Franchisee Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.filter_alt_outlined, size: 14), SizedBox(width: 4), Text('Filter', style: TextStyle(fontSize: 11))])),
                              const SizedBox(width: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Sort', style: TextStyle(fontSize: 11)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 14)])),
                           ]
                        )
                     ]
                  ),
                  const SizedBox(height: 16),
                  SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                      columns: const ['Name', 'Location', 'Quarterly Revenue', 'Patient Rating', 'Status', ''],
                      data: const [
                        {'name': 'Samantha Lee', 'loc': 'Ontario', 'rev': '\$22.4M', 'stat': 'Odgey', 'color': Colors.blue},
                        {'name': 'Samantha Nisra', 'loc': 'Ontario', 'rev': '\$26.8M', 'stat': 'Good', 'color': Colors.teal},
                        {'name': 'Derry Hivlis', 'loc': 'London', 'rev': '\$10.5M', 'stat': 'Slow', 'color': Colors.amber},
                        {'name': 'Plantin Lee', 'loc': 'Ontario', 'rev': '\$15.8M', 'stat': 'Secur', 'color': Colors.teal},
                      ],
                      rowBuilder: (data) => [
                        DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                        DataCell(Text(data['loc']!)),
                        DataCell(Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.star, color: Colors.amber, size: 14), Icon(Icons.star, color: Colors.amber, size: 14), Icon(Icons.star, color: Colors.amber, size: 14), Icon(Icons.star, color: Colors.amber, size: 14), Icon(Icons.star_half, color: Colors.amber, size: 14)])),
                        DataCell(
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: data['color'].shade100, borderRadius: BorderRadius.circular(12)),
                              child: Text(data['stat']!, style: TextStyle(color: data['color'].shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                           )
                        ),
                        DataCell(const Icon(Icons.more_vert, color: Colors.grey, size: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Center: Quarterly Revenue Growth Area Chart
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quarterly Revenue Growth (Ontario)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 16),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('\$0F4C81', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('\$0F4C81', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                     ]
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(child: ServerLoadGraph(), // Dual area chart
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Regional Market Share Donut
          SizedBox(child: PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(alignment: Alignment.centerLeft, child: Text('Regional Market Share', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                  const SizedBox(height: 32),
                  SizedBox(
                     width: 140, height: 140,
                     child: CircularProgressIndicator(value: 0.485, color: Colors.teal.shade400, backgroundColor: const Color(0xFF0F4C81), strokeWidth: 32),
                  ),
                  const Spacer(),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('GTA', style: TextStyle(fontSize: 12))]),
                        const Text('43.8%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                     ]
                  ),
                  const SizedBox(height: 8),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade400, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Ottawa', style: TextStyle(fontSize: 12))]),
                        const Text('48.5%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                     ]
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNetworkRow(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PrimeCareResponsiveKpiGrid(
 children: [
          // Left: Clinic Network Growth Bars
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
                              Text('Clinic Network Growth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('By region by Region', style: TextStyle(color: Colors.grey, fontSize: 13)),
                           ]
                        ),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.filter_alt_outlined, size: 14), SizedBox(width: 4), Text('Filter', style: TextStyle(fontSize: 11))])),
                     ]
                  ),
                  const SizedBox(height: 24),
                  SizedBox(child: Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          _buildTwinBar('GTA', 0.45, 0.70),
                          _buildTwinBar('Ottawa', 0.85, 0.55),
                          _buildTwinBar('London', 0.25, 0.85),
                       ]
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right: Operations Summary and Map
          SizedBox(child: PrimeCareCard(
              child: PrimeCareResponsiveKpiGrid(
 children: [
                    SizedBox(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const Text('Operations Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                             const Text('Key alerts, tasks, and leads', style: TextStyle(color: Colors.grey, fontSize: 13)),
                             const SizedBox(height: 24),
                             _buildActionTile(Icons.warning, Colors.red, 'Key Alerts', 'Key alerts with clerts', Colors.red.shade50),
                             const SizedBox(height: 12),
                             _buildActionTile(Icons.check_box_outlined, Colors.teal, 'Tasks', 'Convnonalers of tasks', Colors.white),
                             const SizedBox(height: 12),
                             _buildActionTile(Icons.show_chart, Colors.grey.shade700, 'Leads', 'Lest conallate clinic', Colors.white),
                          ]
                       )
                    ),
                    const SizedBox(width: 24),
                    SizedBox(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                             SizedBox(width: 140, child: TextField(decoration: InputDecoration(hintText: 'Search', prefixIcon: const Icon(Icons.search, size: 14), isDense: true, contentPadding: const EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300))))),
                             const SizedBox(height: 16),
                             SizedBox(child: Container(
                                   width: double.infinity,
                                   decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Ontario_in_Canada.svg/1000px-Ontario_in_Canada.svg.png'),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.bottomRight,
                                      )
                                   ),
                                   child: const Stack(
                                      children: [
                                         Positioned(top: 20, left: 20, child: Text('Ontario', style: TextStyle(fontWeight: FontWeight.bold))),
                                      ]
                                   )
                                )
                             )
                          ]
                       )
                    ),
                 ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwinBar(String label, double val1, double val2) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           PrimeCareResponsiveKpiGrid(
 children: [
                 Container(width: 32, height: 180 * val1, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))),
                 const SizedBox(width: 8),
                 Container(width: 32, height: 180 * val2, decoration: BoxDecoration(color: Colors.teal.shade500, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))),
              ]
           ),
           const SizedBox(height: 12),
           Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ]
     );
  }

  Widget _buildActionTile(IconData icon, Color color, String title, String subtitle, Color bgColor) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
        child: PrimeCareResponsiveKpiGrid(
 children: [
              Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade200)), child: Icon(icon, color: color, size: 16)),
              const SizedBox(width: 12),
              SizedBox(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                       Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ]
                 )
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 18),
           ]
        ),
     );
  }
}
