import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswManagementDashboardScreen extends StatelessWidget {
  const PswManagementDashboardScreen({super.key});

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
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                        Text('PSW Management Dashboard | June 18, 2024', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        SizedBox(height: 4),
                        Text('Welcome, Administrator Sarah J.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        SizedBox(width: 200, child: TextField(decoration: InputDecoration(hintText: 'Search', prefixIcon: const Icon(Icons.search, size: 18), filled: true, fillColor: Colors.white, isDense: true, contentPadding: const EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black12))))),
                        const SizedBox(width: 16),
                        const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_active_outlined, color: Colors.redAccent),
                        const SizedBox(width: 16),
                        PrimeCareResponsiveKpiGrid(
 children: [
                              CircleAvatar(radius: 12, backgroundColor: Colors.teal.shade100, child: const Icon(Icons.person, color: Colors.teal, size: 16)),
                              const SizedBox(width: 8),
                              const Text('Sarah J.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(width: 8),
                              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                           ]
                        )
                     ]
                  )
               ]
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildTrackingOverviewCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRealTimeMapCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildRecentActivityFeedCard()),
               ]
            ).withHeight(360),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildClientManagementCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildStaffAvailabilityCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildUpcomingTasksCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildVisitSatisfactionCard()),
               ]
            ).withHeight(360),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingOverviewCard() {
    return PrimeCareCard(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text('Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Text('Daily visits', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                ]
             ),
             const SizedBox(height: 24),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Active PSWs', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text('142', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))]),
                   Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Scheduled Visits', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text('387', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))]),
                   Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(16)), child: Text('Daily visits', style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold, fontSize: 12))),
                ]
             ),
             const SizedBox(height: 16),
             SizedBox(child: Stack(
                   children: [
                      const Positioned.fill(child: ServerLoadGraph()), // Represents the huge teal area chart
                      Positioned(top: 0, bottom: 20, left: 0, child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('300', style: TextStyle(fontSize:10,color:Colors.grey)), Text('200', style: TextStyle(fontSize:10,color:Colors.grey)), Text('100', style: TextStyle(fontSize:10,color:Colors.grey))])),
                      Positioned(bottom: 0, left: 30, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Sun', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Mon', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Tue', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Wed', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Thu', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Fri', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Sat', style: TextStyle(fontSize:11,color:Colors.black54)), Text('Sun', style: TextStyle(fontSize:11,color:Colors.black54))])),
                   ]
                )
             ),
             const SizedBox(height: 16),
             PrimeCareResponsiveKpiGrid(
 children: [
                   SizedBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Clients Served', style: TextStyle(fontSize: 12)), SizedBox(height: 4), Text('215', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))])),
                   SizedBox(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Performance Score', style: TextStyle(fontSize: 12)), SizedBox(height: 4), Text('94%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))])),
                ]
             )
          ]
       )
    );
  }

  Widget _buildRealTimeMapCard() {
    return PrimeCareCard(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                   PrimeCareResponsiveKpiGrid(
 children: [Icon(Icons.location_on_outlined, size: 18), SizedBox(width: 8), Text('Real-Time Map', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                   Icon(Icons.more_horiz, color: Colors.grey),
                ]
             ),
             const SizedBox(height: 16),
             const Text('24 active PSWs and scheduled\nclient visits in the city.', style: TextStyle(color: Colors.black87, fontSize: 12)),
             const SizedBox(height: 16),
             SizedBox(child: Container(
                   decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                         image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Map_of_Manhattan.png/800px-Map_of_Manhattan.png'),
                         fit: BoxFit.cover,
                         opacity: 0.6,
                      )
                   ),
                   child: Stack(
                      children: const [
                         Positioned(top: 20, left: 100, child: Icon(Icons.location_on, color: Colors.red, size: 20)),
                         Positioned(top: 40, left: 140, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 24)),
                         Positioned(top: 80, left: 120, child: Icon(Icons.location_on, color: Colors.teal, size: 24)),
                         Positioned(top: 60, left: 90, child: Icon(Icons.location_on, color: Colors.orange, size: 20)),
                         Positioned(top: 130, left: 80, child: Icon(Icons.location_on, color: Color(0xFF0F4C81), size: 24)),
                         Positioned(top: 110, left: 150, child: Icon(Icons.location_on, color: Colors.teal, size: 20)),
                         Positioned(top: 160, left: 130, child: Icon(Icons.location_on, color: Colors.red, size: 24)),
                      ]
                   )
                )
             )
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
                 children: const [
                    Text('Recent Activity Feed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    children: [
                       _buildActivityRow('D', 'David L.', 'started visit @ 9:02 AM'),
                       const Divider(height: 24),
                       _buildActivityRow('M', 'Maria K.', 'completed care plan @\n8:45 AM'),
                       const Divider(height: 24),
                       _buildActivityRow('M', 'Maria L.', 'completed care plan @ 8:45 AM'),
                       const Divider(height: 24),
                       _buildActivityRow('D', 'David L.', 'started visit @ 9:02 AM'),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildActivityRow(String initial, String name, String subtitle) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           CircleAvatar(radius: 12, backgroundColor: Colors.teal.shade400, child: Text(initial, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.black87, fontSize: 11)),
                 ]
              )
           )
        ]
     );
  }

  Widget _buildClientManagementCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Client Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              const Text('Client Needs Breakdown', style: TextStyle(color: Colors.black87, fontSize: 12)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('100'), _ChartLine('75'), _ChartLine('50'), _ChartLine('25'), _ChartLine('0'),
                          ]
                       ),
                       Padding(
                          padding: const EdgeInsets.only(left: 30, right: 10),
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                                _buildBarColumn('Bathing', 0.4, Colors.teal),
                                _buildBarColumn('Meds', 0.6, const Color(0xFF0F4C81)),
                                _buildBarColumn('Meals', 0.8, const Color(0xFF1B6A9C)),
                                _buildBarColumn('Companion', 0.7, Colors.teal.shade500),
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

  Widget _buildBarColumn(String lbl, double h, Color c) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Container(width: 24, height: 200 * h, color: c),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
        ]
     );
  }

  Widget _buildStaffAvailabilityCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Staff Availability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 32),
              SizedBox(child: Center(
                    child: SizedBox(
                       width: 140, height: 140,
                       child: CircularProgressIndicator(value: 0.68, strokeWidth: 32, backgroundColor: const Color(0xFF0F4C81), color: Colors.teal),
                    )
                 )
              ),
              const SizedBox(height: 24),
              _buildAvailabilityLegend('Active (68%)', Colors.teal),
              const SizedBox(height: 8),
              _buildAvailabilityLegend('Scheduled (22%)', const Color(0xFF0F4C81)),
              const SizedBox(height: 8),
              _buildAvailabilityLegend('Off-Duty (10%)', Colors.blueGrey),
           ]
        ),
     );
  }

  Widget _buildAvailabilityLegend(String text, Color c) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 8, height: 8, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
           const SizedBox(width: 8),
           Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        ]
     );
  }

  Widget _buildUpcomingTasksCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Upcoming Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildTaskTile('Important deadlines', 'June 18, 2024', Colors.red),
                       _buildTaskTile('Schedule Visit', 'June 18, 2024', const Color(0xFF0F4C81)),
                       _buildTaskTile('Maria K. completed\ncare plan @ visit', 'June 18, 2024', Colors.teal),
                       _buildTaskTile('Compamiaor', 'June 18, 2024', Colors.teal.shade300),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTaskTile(String title, String sub, Color c) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(width: 4, height: 32, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4))),
           const SizedBox(width: 12),
           SizedBox(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                 ]
              )
           )
        ]
     );
  }

  Widget _buildVisitSatisfactionCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Visit Satisfaction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              const Text('Average Rating', style: TextStyle(color: Colors.black87, fontSize: 12)),
              const SizedBox(height: 4),
              const Text('4.8/5.0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              SizedBox(child: Stack(
                    children: [
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                             _ChartLine('5.0'), _ChartLine('4.0'), _ChartLine('3.0'), _ChartLine('2.0'), _ChartLine('1.0'), _ChartLine('0'),
                          ]
                       ),
                       Padding(
                          padding: const EdgeInsets.only(left: 30, right: 10),
                          child: Column(
                             children: [
                                const SizedBox(child: ServerLoadGraph()), // Green baseline trend
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: const [
                                      Text('Mon', style: TextStyle(fontSize:9, color:Colors.black87)),
                                      Text('Tue', style: TextStyle(fontSize:9, color:Colors.black87)),
                                      Text('Wed', style: TextStyle(fontSize:9, color:Colors.black87)),
                                      Text('Thu', style: TextStyle(fontSize:9, color:Colors.black87)),
                                      Text('Fri', style: TextStyle(fontSize:9, color:Colors.black87)),
                                      Text('Sat', style: TextStyle(fontSize:9, color:Colors.black87)),
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
}

class _ChartLine extends StatelessWidget {
   final String lbl;
   const _ChartLine(this.lbl);
   @override
   Widget build(BuildContext context) {
      return PrimeCareResponsiveKpiGrid(
 children: [
            SizedBox(width: 24, child: Text(lbl, style: const TextStyle(fontSize: 10, color: Colors.black87))),
            SizedBox(child: Divider(color: Colors.grey.shade200, height: 1)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
