import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseSalesDashboardScreen extends StatelessWidget {
  const FranchiseSalesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const GreetingHeaderWidget(name: 'Sales Manager Dashboard'),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.add, size: 16), SizedBox(width: 8), Text('Quick Add', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])),
                        const SizedBox(width: 16),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.notifications_none, size: 16), SizedBox(width: 8), Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              CircleAvatar(radius: 16, backgroundColor: Colors.blue.shade100, child: const Icon(Icons.person, color: Colors.blue, size: 20)),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Alex Johnson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    Text('Franchise Sales Manager', style: TextStyle(color: Colors.grey, fontSize: 10)),
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
            const SizedBox(height: 24),
            _buildKeyMetricsRow(),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildPipelineOverviewCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildUpcomingMilestonesCard()),
               ]
            ).withHeight(340),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildMapPerformanceCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildTopFranchiseesTableCard()),
               ]
            ).withHeight(380),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildKanbanFlowCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRecentActivityFeedCard()),
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
         SizedBox(child: Container(
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(color: Colors.teal.shade300, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('New Franchisee Applications', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13)),
                     const SizedBox(height: 16),
                     PrimeCareResponsiveKpiGrid(
 children: [
                           const Text('148', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
                           const SizedBox(width: 8),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(12)), child: const Text('+15%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                        ]
                     ),
                     const SizedBox(height: 24),
                     SizedBox(
                        height: 40,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                              _bar(0.6), _bar(0.4), _bar(0.7), _bar(0.5), _bar(1.0), _bar(0.8), _bar(0.65), _bar(0.5)
                           ]
                        )
                     ),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('Active Leads', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                     const SizedBox(height: 16),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 const Text('412', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                 const SizedBox(height: 8),
                                 Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Text('+8%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                              ]
                           ),
                           SizedBox(
                              width: 60, height: 60,
                              child: CircularProgressIndicator(value: 0.7, strokeWidth: 12, backgroundColor: Colors.teal.shade200, color: const Color(0xFF0F4C81)),
                           )
                        ]
                     ),
                  ]
               )
            ),
         ),
         const SizedBox(width: 16),
         SizedBox(child: PrimeCareCard(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           const Text('Deals Closed (YTD)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                           Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.trending_up, color: Colors.blue, size: 16)),
                        ]
                     ),
                     const SizedBox(height: 16),
                     PrimeCareResponsiveKpiGrid(
 children: [
                           const Text('29', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                           const SizedBox(width: 8),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Text('+12%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                        ]
                     ),
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
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           const Text('Avg. Time to Close', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                           Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.access_time, color: Colors.blue, size: 16)),
                        ]
                     ),
                     const SizedBox(height: 16),
                     const Text('78 Days', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 32),
                     PrimeCareProgressBar(progress: 0.8, activeColor: Colors.teal.shade300),
                  ]
               )
            ),
         ),
      ],
    );
  }

  Widget _bar(double val) {
     return Container(width: 12, height: 40 * val, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(2)));
  }

  Widget _buildPipelineOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('Leads Pipeline Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Line Chart: Jan-Oct', style: TextStyle(color: Colors.grey, fontSize: 12)),
                       ]
                    ),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('#0F4C81 & #48', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('New Leads', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))]),
                    const SizedBox(width: 16),
                    PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade400, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Qualified', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))]),
                 ]
              ),
              const SizedBox(height: 16),
              const SizedBox(child: ServerLoadGraph()), // Represents the dual Jan-Oct lines
           ]
        )
     );
  }

  Widget _buildUpcomingMilestonesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Upcoming Milestones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              _buildMilestoneTile('Discovery Day', 'Oct 26', true),
              const SizedBox(height: 12),
              _buildMilestoneTile('Agreement Signings', 'Oct 29', false),
              const SizedBox(height: 12),
              _buildMilestoneTile('Training Kickoff', 'Oct 27', false),
           ]
        )
     );
  }

  Widget _buildMilestoneTile(String title, String date, bool active) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: active ? Colors.grey.shade400 : Colors.grey.shade200, width: active ? 2 : 1)),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                 ]
              ),
              if (active) const Icon(Icons.chevron_right, color: Colors.black87),
           ]
        ),
     );
  }

  Widget _buildMapPerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: const [
                          Text('Sales Performance by Region', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Interactive Map of USA', style: TextStyle(color: Colors.grey, fontSize: 12)),
                       ]
                    ),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Interactive Map', style: TextStyle(fontSize: 11)), SizedBox(width: 4), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Container(
                         alignment: Alignment.centerLeft,
                         decoration: BoxDecoration(
                           image: const DecorationImage(
                             image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                             fit: BoxFit.contain,
                             opacity: 0.3,
                             alignment: Alignment.centerLeft,
                           )
                         ),
                       ),
                       Positioned(top: 80, left: 40, child: Icon(Icons.location_on, color: Colors.teal.shade600, size: 24)),
                       Positioned(top: 150, left: 20, child: Icon(Icons.location_on, color: Colors.teal.shade400, size: 24)),
                       Positioned(top: 180, left: 50, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 160, left: 100, child: Icon(Icons.location_on, color: Colors.teal.shade500, size: 24)),
                       Positioned(top: 190, left: 120, child: Icon(Icons.location_on, color: Colors.teal.shade300, size: 24)),
                       Positioned(top: 250, left: 180, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 150, left: 220, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 200, left: 250, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 120, left: 280, child: Icon(Icons.location_on, color: Colors.teal.shade600, size: 24)),
                       Positioned(top: 220, left: 280, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 170, left: 320, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 150, left: 350, child: Icon(Icons.location_on, color: Colors.teal.shade400, size: 24)),
                       Positioned(top: 250, left: 320, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 280, left: 350, child: Icon(Icons.location_on, color: Colors.teal.shade600, size: 24)),
                       Positioned(top: 100, left: 380, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(top: 150, left: 400, child: Icon(Icons.location_on, color: const Color(0xFF0F4C81), size: 24)),
                       Positioned(
                          right: 20, top: 40,
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                                PrimeCareResponsiveKpiGrid(
 children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [Text('Sales', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('552', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('Sales', style: TextStyle(color: Colors.grey, fontSize: 11))]),
                                      const SizedBox(width: 16),
                                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [const Text('', style: TextStyle(color: Colors.grey, fontSize: 12)), const Text('\$150K', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)), const Text('Revenue', style: TextStyle(color: Colors.grey, fontSize: 11))]),
                                   ]
                                ),
                                const SizedBox(height: 24),
                                const Text('Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(height: 8),
                                PrimeCareResponsiveKpiGrid(
 children: [
                                      Container(width: 16, height: 16, color: Colors.teal.shade100),
                                      Container(width: 16, height: 16, color: Colors.teal.shade300),
                                      Container(width: 16, height: 16, color: Colors.teal.shade500),
                                      Container(width: 16, height: 16, color: Colors.teal.shade700),
                                      Container(width: 16, height: 16, color: const Color(0xFF0F4C81)),
                                   ]
                                ),
                                const SizedBox(height: 4),
                                SizedBox(width: 80, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('\$0K', style: TextStyle(fontSize: 10, color: Colors.grey)), Text('\$50K', style: TextStyle(fontSize: 10, color: Colors.grey))])),
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

  Widget _buildTopFranchiseesTableCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Top Performing Franchisees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('Card', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Franchisee Name', 'Location', 'Clinics', 'Revenue', 'Growth', 'Status'],
                    data: const [
                       {'name': 'Alera Johnson', 'loc': 'Healthcare', 'clinics': '2', 'rev': '\$23.0K', 'growth': '23%', 'stat': 'Status'},
                       {'name': 'John Rendez', 'loc': 'Springerd', 'clinics': '5', 'rev': '\$13.0K', 'growth': '15%', 'stat': 'Growth'},
                       {'name': 'Johe Adhon', 'loc': 'Bounnary', 'clinics': '6', 'rev': '\$17.0K', 'growth': '18%', 'stat': 'Growth'},
                       {'name': 'John Bosen', 'loc': 'Baglton', 'clinics': '3', 'rev': '\$15.9K', 'growth': '12%', 'stat': 'Growth'},
                       {'name': 'John Capper', 'loc': 'Washington', 'clinics': '10', 'rev': '\$17.0K', 'growth': '12%', 'stat': 'Growth'},
                       {'name': 'Maria Persson', 'loc': 'Hanonca', 'clinics': '3', 'rev': '\$13.0K', 'growth': '10%', 'stat': 'Lewr'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11))),
                       DataCell(Text(data['loc']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['clinics']!, style: const TextStyle(fontSize: 11))),
                       DataCell(Text(data['rev']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [const Icon(Icons.arrow_drop_up, color: Colors.green, size: 16), Text(data['growth']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11))])),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                             decoration: BoxDecoration(color: data['stat'] == 'Lewr' ? Colors.blue.shade100 : Colors.teal.shade100, borderRadius: BorderRadius.circular(12)),
                             child: Text(data['stat']!, style: TextStyle(color: data['stat'] == 'Lewr' ? Colors.blue.shade700 : Colors.teal.shade700, fontSize: 10)),
                          )
                       ),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildKanbanFlowCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Applicant Stage Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('Kanban Flow', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildKanbanColumn('Application', [
                          _buildKanbanCard('Application', 'Stage 1', true, null),
                       ]),
                       _buildKanbanColumn('Vetting', [
                          _buildKanbanCard('Vetting', 'Stage 2', false, Icons.person),
                          _buildKanbanCard('Agreement', 'Stage 1', false, Icons.person),
                       ]),
                       _buildKanbanColumn('Disclosure', [
                          _buildKanbanCard('Disclosure', 'Stage 3', false, Icons.person),
                       ]),
                       _buildKanbanColumn('Agreement', [
                          _buildKanbanCard('Agreement', 'Stage 4', false, Icons.person),
                       ]),
                       _buildKanbanColumn('Training', [
                          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('None', style: TextStyle(color: Colors.grey, fontSize: 12))),
                       ]),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildKanbanColumn(String title, List<Widget> items) {
     return SizedBox(child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 4.0),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                       if (title != 'Training') const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                    ]
                 ),
                 const SizedBox(height: 12),
                 ...items.map((w) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: w)).toList(),
              ]
           )
        )
     );
  }

  Widget _buildKanbanCard(String title, String subtitle, bool active, IconData? icon) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: active ? Colors.blue : Colors.grey.shade200, width: active ? 2 : 1), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                 ]
              ),
              if (icon != null) CircleAvatar(radius: 8, backgroundColor: Colors.blue.shade100, child: Icon(icon, size: 10, color: Colors.blue)),
              if (active) Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
           ]
        )
     );
  }

  Widget _buildRecentActivityFeedCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Recent Activity Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Text('Active Card', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                 ]
              ),
              const SizedBox(height: 24),
              _buildActivityRow(Icons.person, 'Activity updates wih the Healthcare Franchises at a Hesithcare Franchisee.', '5 hours ago'),
              const Divider(height: 24),
              _buildActivityRow(Icons.person, 'Erea: Johrosen updated om darnets wsiting Ennshure franchises.', '8 hours ago'),
              const Divider(height: 24),
              _buildActivityRow(Icons.person, 'Alex Johnson created a nsnes Sales Manager', '1 hours ago'),
           ]
        ),
     );
  }

  Widget _buildActivityRow(IconData icon, String text, String time) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           CircleAvatar(radius: 12, backgroundColor: Colors.blue.shade100, child: Icon(icon, size: 14, color: Colors.blue)),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(text, style: const TextStyle(fontSize: 12)),
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
