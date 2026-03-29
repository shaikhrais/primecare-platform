import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClinicalTeamDashboardScreen extends StatelessWidget {
  const ClinicalTeamDashboardScreen({super.key});

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
                  const GreetingHeaderWidget(name: 'Clinical Team Dashboard | MediHealth Franchise'),
                  Row(
                     children: [
                        SizedBox(width: 200, child: TextField(decoration: InputDecoration(hintText: 'Search', prefixIcon: const Icon(Icons.search, size: 18), filled: true, fillColor: Colors.white, isDense: true, contentPadding: const EdgeInsets.all(8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black12))))),
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_active_outlined, color: Colors.redAccent),
                        const SizedBox(width: 16),
                        Row(
                           children: [
                              CircleAvatar(radius: 12, backgroundColor: Colors.teal.shade100, child: const Icon(Icons.person, color: Colors.teal, size: 16)),
                              const SizedBox(width: 8),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: const [
                                    Text('Dr. Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    Text('Medical Director', style: TextStyle(color: Colors.black54, fontSize: 11)),
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
            const SizedBox(height: 16),
            PrimeResponsiveGrid(
               desktopCrossAxisCount: 2,
               desktopMainAxisExtent: 340,
               children: [
                  _buildPatientFlowWeeklyCard(),
                  _buildFranchisePerformanceCard(),
                  _buildScheduleTimelineCard(),
                  _buildRecentAdmissionsTable(),
                  _buildCriticalAlertsTable(),
                  _buildTeamTasksKanban(),
               ]
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return PrimeResponsiveGrid(
      desktopCrossAxisCount: 4,
      desktopMainAxisExtent: 130,
      children: [
         _buildMetricCard('Total Patients', Icons.person_add_alt_1, '14,230', '+5.2%', Colors.teal),
         _buildMetricCard('Appointments Today', Icons.calendar_today, '184', '92% capacity', Colors.grey),
         _buildMetricCard('Active Staff', Icons.medical_services_outlined, '312 / 340', null, Colors.teal),
         _buildMetricCard('Average Wait Time', Icons.access_time, '12 min', '-8%', Colors.green),
      ],
    );
  }

  Widget _buildMetricCard(String title, IconData icon, String val, String? subval, Color subColor) {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: Colors.teal.shade700, size: 16)),
                 ]
              ),
              const SizedBox(height: 16),
              Row(
                 crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic,
                 children: [
                    Text(val, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    if (subval != null) Text(subval, style: TextStyle(color: subColor, fontSize: 12, fontWeight: FontWeight.bold)),
                 ]
              )
           ]
        )
     );
  }

  Widget _buildPatientFlowWeeklyCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Patient Flow & Volume (Weekly Overview)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.show_chart, size: 16), SizedBox(width: 8), Text('Chart', style: TextStyle(fontSize: 12)), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 24),
              Expanded(
                 child: Stack(
                    children: [
                       const Positioned.fill(child: ServerLoadGraph()), // Underlay mapping the visual
                       Positioned(
                          top: 40, left: 160,
                          child: Container(
                             padding: const EdgeInsets.all(8),
                             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                             child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [Text('Nov 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text('Data: 13,90', style: TextStyle(color: Colors.black87, fontSize: 11))],
                             )
                          )
                       ),
                       Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Sun', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Mon', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Tue', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Wed', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Thu', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Fri', style: TextStyle(fontSize:11,color:Colors.grey)), Text('Sun', style: TextStyle(fontSize:11,color:Colors.grey))])
                       ),
                       Positioned(top: 0, bottom: 20, left: 0, child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('2500', style: TextStyle(fontSize:10,color:Colors.grey)), Text('2000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('1500', style: TextStyle(fontSize:10,color:Colors.grey)), Text('1000', style: TextStyle(fontSize:10,color:Colors.grey)), Text('500', style: TextStyle(fontSize:10,color:Colors.grey)), Text('0', style: TextStyle(fontSize:10,color:Colors.grey))])),
                    ]
                 )
              ),
           ]
        ),
     );
  }

  Widget _buildFranchisePerformanceCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Franchise Performance Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Text('Maps & Chart', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const Text('Map & Bar Chart', style: TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 16),
              Expanded(
                 child: Row(
                    children: [
                       Expanded(
                          flex: 1,
                          child: Container(
                             decoration: const BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Blank_US_Map_%28states_only%29.svg/1000px-Blank_US_Map_%28states_only%29.svg.png'),
                                 fit: BoxFit.contain,
                                 opacity: 0.2,
                               )
                             ),
                             child: Stack(
                                children: const [
                                   Positioned(top: 40, left: 60, child: Icon(Icons.location_on, color: Color(0xFF1B6A9C), size: 16)),
                                   Positioned(top: 50, left: 140, child: Icon(Icons.location_on, color: Color(0xFF1B6A9C), size: 16)),
                                   Positioned(top: 30, left: 180, child: Icon(Icons.location_on, color: Color(0xFF1B6A9C), size: 16)),
                                ]
                             )
                          )
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                          flex: 1,
                          child: Column(
                             children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('200', style: TextStyle(fontSize:9,color:Colors.grey)), Text('150', style: TextStyle(fontSize:9,color:Colors.grey)), Text('100', style: TextStyle(fontSize:9,color:Colors.grey)), Text('50', style: TextStyle(fontSize:9,color:Colors.grey)), Text('0', style: TextStyle(fontSize:9,color:Colors.grey))]),
                                const SizedBox(height: 8),
                                Expanded(
                                   child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                         _buildDualBar(0.4, 0.6, 'Ch'),
                                         _buildDualBar(0.8, 0.5, 'NY'),
                                         _buildDualBar(0.7, 0.4, 'NY'),
                                         _buildDualBar(0.7, 0.9, 'NF'),
                                         _buildDualBar(0.6, 0.6, 'SF'),
                                      ]
                                   )
                                ),
                             ]
                          )
                       )
                    ]
                 )
              ),
              const SizedBox(height: 24),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Chicago', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]), const Text('14,230', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Text('Afl + 42.2%', style: TextStyle(color: Colors.grey, fontSize: 10))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('NY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]), const Text('84 -', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Text('chiirlcs', style: TextStyle(color: Colors.grey, fontSize: 10))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade200, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('SF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]), const Text('17.4 afin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Text('AS + 60%+', style: TextStyle(color: Colors.grey, fontSize: 10))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Text('\$28,500', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Container(width: 60, height: 4, decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(2)))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Patient Satisfaction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), const Text('95.38%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Container(width: 60, height: 4, decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: BorderRadius.circular(2)))]),
                 ]
              )
           ]
        ),
     );
  }

  Widget _buildDualBar(double h1, double h2, String lbl) {
     return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Container(width: 10, height: 80 * h1, color: const Color(0xFF0F4C81)),
                 Container(width: 10, height: 80 * h2, color: Colors.teal.shade400),
              ]
           ),
           const SizedBox(height: 8),
           Text(lbl, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
        ]
     );
  }

  Widget _buildScheduleTimelineCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('My Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Icon(Icons.calendar_month, size: 14, color: Colors.grey), SizedBox(width: 8), Text('Centers', style: TextStyle(fontSize: 12)), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const Text('Today\'s appointments', style: TextStyle(color: Colors.black54, fontSize: 12)),
              const SizedBox(height: 16),
              Expanded(
                 child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       Expanded(
                          flex: 1,
                          child: Column(
                             children: [
                                Container(
                                   padding: const EdgeInsets.all(12),
                                   decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)),
                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Dr. Sarah Chen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(height: 4), Text('09:30 - 2 pm', style: TextStyle(color: Colors.white70, fontSize: 10))]), const Icon(Icons.chevron_right, color: Colors.white, size: 16)]),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                   padding: const EdgeInsets.all(12),
                                   decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Dr. Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(height: 4), Text('13:30 - 18 pm', style: TextStyle(color: Colors.black54, fontSize: 10))]), const Icon(Icons.chevron_right, color: Colors.grey, size: 16)]),
                                ),
                             ]
                          )
                       ),
                       const SizedBox(width: 24),
                       Expanded(
                          flex: 2,
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                const Text('Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(height: 16),
                                Expanded(
                                   child: Stack(
                                      children: [
                                         Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                               _TimelineDivider('09 AM'),
                                               _TimelineDivider('10 AM'),
                                               _TimelineDivider('12 AM'),
                                               _TimelineDivider('12 AM'), // Mock logic mirrors image typo
                                            ]
                                         ),
                                         Positioned(
                                            top: 40, left: 50, right: 0,
                                            child: Container(
                                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                               decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(4), border: Border(left: BorderSide(color: Colors.teal.shade400, width: 4))),
                                               child: Row(children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.teal.shade400, shape: BoxShape.circle)), const SizedBox(width: 8), const Text('Dr. Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                                            )
                                         ),
                                         Positioned(
                                            top: 80, left: 50, right: 0,
                                            child: Container(
                                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                               decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4), border: Border(left: BorderSide(color: Colors.blue.shade400, width: 4))),
                                               child: Row(children: const [SizedBox(width: 14), Text('Dr. Sarah Chen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))]),
                                            )
                                         )
                                      ]
                                   )
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

  Widget _buildRecentAdmissionsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Recent Admissions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 24),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Patient Name', 'ID', 'Location', 'Status', 'Attending Phys'],
                    data: const [
                       {'name': 'Annonoiiizatient', 'id': '6570', 'loc': 'Location', 'stat': 'Statived', 'phys': 'Dr. Sarah Chen'},
                       {'name': 'Hown Health', 'id': '3620', 'loc': 'Chicago', 'stat': 'Chicago', 'phys': 'Dr. Sarah Chen'},
                       {'name': 'Serah Hanlttt', 'id': '8035', 'loc': 'Location', 'stat': 'Sotoved', 'phys': 'Dr. Sarah Chen'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                       DataCell(Text(data['id']!, style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['loc']!, style: const TextStyle(fontSize: 12))),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                             decoration: BoxDecoration(border: Border.all(color: Colors.teal.shade200), borderRadius: BorderRadius.circular(12)),
                             child: Text(data['stat']!, style: TextStyle(color: Colors.teal.shade700, fontSize: 11)),
                          )
                       ),
                       DataCell(Text(data['phys']!, style: const TextStyle(fontSize: 12))),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildCriticalAlertsTable() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              const Text('Critical Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              Expanded(
                 child: PrimeCareDataTable<Map<String, String>>(
                    columns: const ['Patient Name', 'Prioritity', 'Actions', ''],
                    data: const [
                       {'name': 'Patient Flags', 'date': '26 Novs, 2023', 'prio': 'Priority', 'act': 'Actions'},
                       {'name': 'Patient Patient', 'date': '26 Novs, 2023', 'prio': 'Priority', 'act': 'Actions'},
                       {'name': 'Patient Patient', 'date': 'Brouity', 'prio': '', 'act': 'Actions'},
                    ],
                    rowBuilder: (data) => [
                       DataCell(
                          Row(
                             children: [
                                const Icon(Icons.flag, color: Colors.redAccent, size: 20),
                                const SizedBox(width: 8),
                                Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Text(data['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text(data['date']!, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                                   ]
                                )
                             ]
                          )
                       ),
                       DataCell(
                          data['prio']!.isNotEmpty ? Container(
                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                             decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                             child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)), const SizedBox(width: 4), Text(data['prio']!, style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold))]),
                          ) : const SizedBox()
                       ),
                       DataCell(Text(data['act']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                             decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                             child: Row(children: const [Text('Actions', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.chevron_right, size: 16)])
                          )
                       ),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTeamTasksKanban() {
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
                          Text('Team Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Kanban view, status, assignee', style: TextStyle(color: Colors.grey, fontSize: 12)),
                       ]
                    ),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Row(children: const [Text('Kanben', style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 24),
              Expanded(
                 child: Row(
                    children: [
                       _buildKanbanColumn('Status', Icons.local_fire_department, Colors.orange, [
                          _buildKanbanCard('Patients Staff', 'Dr'),
                          _buildKanbanCard('Ehocloianagement', ''),
                       ]),
                       _buildKanbanColumn('Status', Icons.check_circle, Colors.teal, [
                          _buildKanbanCard('Dannning Task', '8d'),
                          _buildKanbanCard('Team Tasks', ''),
                       ]),
                       _buildKanbanColumn('Status', null, null, [
                          _buildKanbanCard('Team Management', '0y'),
                       ]),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildKanbanColumn(String title, IconData? icon, Color? c, List<Widget> items) {
     return Expanded(
        child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 4.0),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), if (icon != null) ...[const SizedBox(width: 4), Icon(icon, color: c, size: 14)]]),
                       const Icon(Icons.more_horiz, size: 16, color: Colors.grey),
                    ]
                 ),
                 const SizedBox(height: 12),
                 ...items.map((w) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: w)).toList(),
              ]
           )
        )
     );
  }

  Widget _buildKanbanCard(String text, String sub) {
     return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade200), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 8),
              if (sub.isNotEmpty) Row(children: [CircleAvatar(radius: 6, backgroundColor: Colors.orange.shade100, child: const Icon(Icons.person, size: 8, color: Colors.orange)), const SizedBox(width: 4), Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10))])
           ]
        ),
     );
  }
}

class _TimelineDivider extends StatelessWidget {
   final String time;
   const _TimelineDivider(this.time);
   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            SizedBox(width: 40, child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10))),
            Expanded(child: Divider(color: Colors.grey.shade200)),
         ]
      );
   }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
