import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50.withOpacity(0.5),
      appBar: const PrimeCareAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Clinical Workflow",
  actions: [
    PrimeCareActionItem(title: 'Care Plans', icon: Icons.medical_services, route: AppRoutes.rnCarePlan, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'RN Inbox', icon: Icons.mail, route: AppRoutes.rnInbox, color: Colors.blueGrey),
    PrimeCareActionItem(title: 'Clinical SOW', icon: Icons.analytics, route: AppRoutes.rnSow, color: Colors.teal),
  ]
),

            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  PrimeCareResponsiveKpiGrid(
 children: const [
                        Text('NurseDirect', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F4C81))),
                        SizedBox(width: 8),
                        Text('|', style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(width: 8),
                        Text('Healthcare Franchise Portal', style: TextStyle(fontSize: 14)),
                     ]
                  ),
                  PrimeCareResponsiveKpiGrid(
 children: [
                        CircleAvatar(radius: 12, backgroundImage: const NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=1')),
                        const SizedBox(width: 8),
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: const [
                              Text('Emily Roberts, RN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              Text('ID: 0010301885', style: TextStyle(color: Colors.black54, fontSize: 11)),
                           ]
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_active_outlined, color: Colors.grey),
                        const SizedBox(width: 16),
                        const Icon(Icons.settings_outlined, color: Colors.grey),
                     ]
                  )
               ]
            ),
            const SizedBox(height: 32),
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: const [
                  Text('Welcome back, Emily!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 4),
                  Text('Today: Friday, Oct 27, 2023  |  Good Morning', style: TextStyle(color: Colors.black87, fontSize: 13)),
               ]
            ),
            const SizedBox(height: 24),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildDailyPatientRosterCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildMyScheduleCard()),
               ]
            ).withHeight(360),
            const SizedBox(height: 16),
            PrimeCareResponsiveKpiGrid(
 children: [
                  SizedBox(child: _buildCriticalAlertsCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: _buildCareTasksOverviewCard()),
                  const SizedBox(width: 16),
                  SizedBox(child: Column(children: [SizedBox(child: _buildRecentActivityFeedCard()), const SizedBox(height: 16), SizedBox(child: _buildFranchiseUpdatesCard())])),
               ]
            ).withHeight(340),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyPatientRosterCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    const Text('Daily Patient Roster', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: PrimeCareResponsiveKpiGrid(
 children: const [Icon(Icons.tune, size: 16), SizedBox(width: 8), Text('Filters', style: TextStyle(fontSize: 12)), Icon(Icons.keyboard_arrow_down, size: 16)])),
                 ]
              ),
              const SizedBox(height: 16),
              SizedBox(child: PrimeCareDataTable<Map<String, dynamic>>(
                    columns: const ['Name', 'Age', 'Room', 'Status', 'Next Task', 'Alerts'],
                    data: const [
                       {'name': 'Liam Chen', 'age': '26', 'room': '#6', 'stat': 'Monted', 'task': 'Propeiare Br...', 'alert': 'red', 'w': 1},
                       {'name': 'Sofia Garcia', 'age': '24', 'room': '#2', 'stat': 'Monted', 'task': 'Next Task lr...', 'alert': 'red_outline', 'w': 2},
                       {'name': 'Mark Davis', 'age': '20', 'room': '#5', 'stat': 'Status', 'task': 'Start Tatinsia...', 'alert': 'amber', 'w': 3},
                       {'name': 'Mark Davis', 'age': '20', 'room': '#4', 'stat': 'Momed', 'task': 'Next Task lr...', 'alert': 'amber', 'w': 3},
                       {'name': 'John Doen', 'age': '29', 'room': '#8', 'stat': 'Monted', 'task': 'Next Task', 'alert': 'amber', 'w': 4},
                    ],
                    rowBuilder: (data) => [
                       DataCell(PrimeCareResponsiveKpiGrid(
 children: [CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=random?u=${data['w']}')), const SizedBox(width: 8), Text(data['name'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))])),
                       DataCell(Text(data['age'].toString(), style: const TextStyle(fontSize: 12))),
                       DataCell(Text(data['room'].toString(), style: const TextStyle(fontSize: 12))),
                       DataCell(
                          Container(
                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                             decoration: BoxDecoration(color: data['stat'] == 'Status' ? Colors.purple.shade50 : Colors.teal.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: data['stat'] == 'Status' ? Colors.purple.shade200 : Colors.teal.shade200)),
                             child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: data['stat'] == 'Status' ? Colors.purple : Colors.teal, shape: BoxShape.circle)), const SizedBox(width: 4), Text(data['stat'].toString(), style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold))]),
                          )
                       ),
                       DataCell(Text(data['task'].toString(), style: const TextStyle(fontSize: 12))),
                       DataCell(Icon(data['alert'] == 'red' ? Icons.notifications_active : Icons.warning_amber_rounded, color: data['alert'].toString().contains('red') ? Colors.redAccent : Colors.amber, size: 18)),
                    ],
                 )
              )
           ]
        ),
     );
  }

  Widget _buildMyScheduleCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('My Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              const Text('Today\'s appointments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 24),
              SizedBox(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildScheduleBlock('9:30 AM', 'Sarah Miller', '9:30 AM'),
                       _buildScheduleBlock('11:00 AM', 'John Doe', '11:00 AM'),
                       _buildScheduleBlock('2:00 PM', 'Mark Davis', '2:00 PM'),
                       PrimeCareResponsiveKpiGrid(
 children: const [
                             SizedBox(width: 50, child: Text('3:00 PM', style: TextStyle(fontSize: 10))),
                             SizedBox(width: 12),
                          ]
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildScheduleBlock(String timeList, String name, String timeBlock) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           SizedBox(width: 50, child: Text(timeList, style: const TextStyle(fontSize: 10))),
           const SizedBox(width: 12),
           SizedBox(child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                 decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4), border: Border(left: BorderSide(color: Colors.teal.shade400, width: 4))),
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                             const SizedBox(height: 4),
                             Text(timeBlock, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                          ]
                       ),
                       Text(timeBlock, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    ]
                 ),
              )
           )
        ]
     );
  }

  Widget _buildCriticalAlertsCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Critical Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 16),
              const Text('List', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 16),
              SizedBox(child: Column(
                    children: [
                       PrimeCareResponsiveKpiGrid(
 children: [
                             const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=12')),
                             const SizedBox(width: 12),
                             Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Sarah M. - High BP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('Conditions', style: TextStyle(color: Colors.black87, fontSize: 11))]),
                          ]
                       ),
                       const Divider(height: 32),
                       PrimeCareResponsiveKpiGrid(
 children: [
                             const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=11')),
                             const SizedBox(width: 12),
                             Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('John D. - Lab Results', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('Conditions', style: TextStyle(color: Colors.black87, fontSize: 11))]),
                          ]
                       ),
                       const Divider(height: 32),
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildCareTasksOverviewCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              const Text('Care Tasks Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 32),
              SizedBox(child: Center(
                    child: SizedBox(
                       width: 130, height: 130,
                       child: CircularProgressIndicator(value: 0.75, strokeWidth: 24, backgroundColor: const Color(0xFF0F4C81), color: Colors.teal.shade500),
                    )
                 )
              ),
              const SizedBox(height: 24),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Meds', style: TextStyle(fontSize: 10))]), const Text('45%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.teal.shade500, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Assessments', style: TextStyle(fontSize: 10))]), const Text('30%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [PrimeCareResponsiveKpiGrid(
 children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF1B6A9C), shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Procedures', style: TextStyle(fontSize: 10))]), const Text('25%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                 ]
              ),
              const SizedBox(height: 16),
              PrimeCareResponsiveKpiGrid(
 children: [
                    SizedBox(child: Container(height: 4, decoration: const BoxDecoration(color: Color(0xFF0F4C81), borderRadius: BorderRadius.horizontal(left: Radius.circular(2))))),
                    const SizedBox(width: 4),
                    SizedBox(child: Container(height: 4, decoration: BoxDecoration(color: Colors.teal.shade500))),
                    const SizedBox(width: 4),
                    SizedBox(child: Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: const BorderRadius.horizontal(right: Radius.circular(2))))),
                 ]
              )
           ]
        ),
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
              const SizedBox(height: 16),
              SizedBox(child: Stack(
                    children: [
                       Positioned(top: 16, bottom: 20, left: 16, child: Container(width: 1, color: Colors.grey.shade300)),
                       Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             _buildTimelineRow(Icons.calendar_today, 'Oct 27', 'Care Plan Updated for Liam C.', '8:45 AM', true),
                             _buildTimelineRow(Icons.calendar_today, 'Oct 27', 'Care Plan Updated for Liam C.', '8:45 AM', false),
                             _buildTimelineRow(Icons.edit, 'Care Plan Updated', 'Care Plan Updated for Liam C.', '8:45 AM', false),
                          ]
                       )
                    ]
                 )
              )
           ]
        ),
     );
  }

  Widget _buildTimelineRow(IconData icon, String title, String sub, String time, bool isSelected) {
     return PrimeCareResponsiveKpiGrid(
 children: [
           Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isSelected ? const Color(0xFF0F4C81) : Colors.grey.shade100, shape: BoxShape.circle), child: Icon(icon, color: isSelected ? Colors.white : Colors.black87, size: 16)),
           const SizedBox(width: 16),
           SizedBox(child: Container(
                 padding: EdgeInsets.all(isSelected ? 12 : 0),
                 decoration: BoxDecoration(color: isSelected ? Colors.blue.shade50 : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(height: 4), Text(sub, style: const TextStyle(color: Colors.black87, fontSize: 10))]),
                       Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                    ]
                 )
              )
           )
        ]
     );
  }

  Widget _buildFranchiseUpdatesCard() {
     return PrimeCareCard(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: const [
                    Text('Franchise Updates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Icon(Icons.more_horiz, color: Colors.grey),
                 ]
              ),
              const SizedBox(height: 8),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
           ]
        )
     );
  }
}

extension on Widget {
   Widget withHeight(double h) => SizedBox(height: h, child: this);
}
