import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';
class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  Widget _buildUpcomingVisits(BuildContext context) {
    return PrimeCareCardContainer(
      Column(
        children: [
          PrimeCareSectionHeader(title: 'Upcoming Visits'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2.5),
                2: FlexColumnWidth(2.5),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(1.5),
              },
              children: [
                const TableRow(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Client', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)))),
                    Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)))),
                    Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Service', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)))),
                    Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)))),
                    Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)))),
                  ],
                ),
                _buildTableRow(context, 'John Smith', '9:00 AM - 11:00 AM', 'Personal Care', '123 Maple St.', 'Scheduled', Colors.teal),
                _buildTableRow(context, 'Mary Davies', '11:30 AM - 1:00 PM', 'Meal Assistance', '45 Elm Rd.', 'Scheduled', Colors.teal),
                _buildTableRow(context, 'Robert Lee', '2:00 PM - 3:30 PM', 'Medication Support', '78 Oak Ave.', 'Scheduled', Colors.teal),
                _buildTableRow(context, 'Emily Brown', '4:00 PM - 5:30 PM', 'Companionship', '56 Pine Ln.', 'Scheduled', Colors.teal),
              ],
            ),
          ),
        ],
      )
    );
  }

  TableRow _buildTableRow(BuildContext context, String client, String time, String service, String location, String status, Color statusColor) {
    return TableRow(
      children: [
        GestureDetector(
          onTap: () => context.push(AppRoutes.pswLiveVisit),
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(client, style: const TextStyle(color: Color(0xFF1E5BB2), fontWeight: FontWeight.bold, decoration: TextDecoration.underline))),
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(time, style: const TextStyle(color: Color(0xFF333333)))),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(service, style: const TextStyle(color: Color(0xFF333333)))),
        Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(location, style: const TextStyle(color: Color(0xFF333333)))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(4)),
              child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          )
        ),
      ],
    );
  }

  Widget _buildTodaysTasks(BuildContext context) {
    return PrimeCareCardContainer(
      Column(
        children: [
          PrimeCareSectionHeader(title: "Today's Tasks", isWhite: true),
          _buildTaskItem(context, Icons.check, 'Medication Reminder', 'Overdue', Colors.red, AppRoutes.pswMar),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _buildTaskItem(context, Icons.check, 'Bathing Assistance', 'Due Today', Colors.teal, AppRoutes.pswDailyEntry),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _buildTaskItem(context, Icons.check, 'Complete Visit Notes', '', Colors.transparent, AppRoutes.pswProgressNotes),
          const SizedBox(height: 8),
        ],
      )
    );
  }
  
  Widget _buildTaskItem(BuildContext context, IconData icon, String title, String badge, Color badgeColor, String routePath) {
    return InkWell(
      onTap: () => context.push(routePath),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1E88E5), size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600, fontSize: 14))),
            if (badge.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildClientAlerts(BuildContext context) {
    return PrimeCareCardContainer(
      Column(
        children: [
          PrimeCareSectionHeader(title: "Client Alerts", isWhite: true),
          _buildAlertItem(context, Icons.warning, 'Falls Risk:', 'Mary Davies'),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _buildAlertItem(context, Icons.warning, 'Allergies:', 'Robert Lee'),
          const SizedBox(height: 8),
        ],
      )
    );
  }

  Widget _buildAlertItem(BuildContext context, IconData icon, String boldText, String normalText) {
    return InkWell(
      onTap: () => context.push(AppRoutes.pswIncidentReport),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '$boldText ',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), fontSize: 14),
                  children: [
                    TextSpan(text: normalText, style: const TextStyle(fontWeight: FontWeight.normal)),
                  ]
                )
              ),
            ),
            const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyOverview() {
    return PrimeCareCardContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareSectionHeader(title: "Daily Overview", isWhite: true),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              height: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildGraphBar('Mon', 4, 10, 0.4),
                  _buildGraphBar('Tue', 3, 10, 0.3),
                  _buildGraphBar('Wed', 4, 10, 0.4),
                  _buildGraphBar('Thu', 8, 10, 0.8),
                  _buildGraphBar('Fri', 5, 10, 0.5),
                  _buildGraphBar('Sat', 7, 10, 0.7),
                  _buildGraphBar('Sun', 5, 10, 0.5),
                  _buildGraphBar('Mon', 9, 10, 0.9),
                  _buildGraphBar('Tue', 4, 10, 0.4),
                  _buildGraphBar('Wed', 6, 10, 0.6),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildGraphBar(String label, int value, int max, double ratio) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 120 * ratio,
          color: const Color(0xFF1E88E5), // Base blue
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
      ],
    );
  }

  Widget _buildRecentNotes(BuildContext context) {
    return PrimeCareCardContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareSectionHeader(title: "Recent Notes", isWhite: true),
          const SizedBox(height: 8),
          _buildNoteItem(context, Icons.add_box, 'Mary Davies', 'Assisted with Lunch prep.', const Color(0xFF1E88E5)),
          _buildNoteItem(context, Icons.add_box, 'Robert Lee', 'Administered medication, noted dizziness.', const Color(0xFF1E88E5)),
          _buildNoteItem(context, Icons.check_box, 'John Smith', 'Helped with mobility exercises.', const Color(0xFF1E88E5)),
          const SizedBox(height: 8),
        ],
      )
    );
  }

  Widget _buildNoteItem(BuildContext context, IconData icon, String name, String note, Color iconColor) {
    return InkWell(
      onTap: () => context.push(AppRoutes.pswProgressNotes),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: '$name - ',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), fontSize: 13),
                  children: [
                    TextSpan(text: note, style: const TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF333333))),
                  ]
                )
              ),
            ),
            const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildClientLocations() {
    return PrimeCareCardContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareSectionHeader(title: "Client Locations", isWhite: true),
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap'), // generic placeholder map
                fit: BoxFit.cover,
              )
            ),
            child: Stack(
              children: const [
                Positioned(left: 40, top: 20, child: Icon(Icons.location_on, color: Color(0xFF1E3A8A), size: 32)),
                Positioned(left: 120, top: 80, child: Icon(Icons.location_on, color: Colors.red, size: 32)),
                Positioned(left: 200, top: 40, child: Icon(Icons.location_on, color: const Color(0xFF1E3A8A), size: 32)),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildTrainingResources() {
    return PrimeCareCardContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareSectionHeader(title: "Training & Resources", isWhite: true),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: _buildResourceBox(Icons.warning, 'Safety\nProcedures')),
                const SizedBox(width: 12),
                Expanded(child: _buildResourceBox(Icons.health_and_safety, 'Dementia\nCare Tips')),
                const SizedBox(width: 12),
                Expanded(child: _buildResourceBox(Icons.menu_book, 'New Policy\nUpdates')),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildResourceBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: const Color(0xFF1E74C5), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildShiftReportSummary(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.pswTimesheets),
      child: PrimeCareCardContainer(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareSectionHeader(title: "Shift Report Summary", isWhite: true),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildReportMetric('12', 'Visits Completed'),
                  Container(height: 50, width: 1, color: const Color(0xFFE2E8F0)),
                  _buildReportMetric('5 hrs', 'Total Travel Time'),
                  Container(height: 50, width: 1, color: const Color(0xFFE2E8F0)),
                  _buildReportMetric('3', 'Incidents Reported'),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildReportMetric(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // Implementing LayoutBuilder wrapper for safety
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        titleSpacing: 24,
        backgroundColor: const Color(0xFF1453A3), // V3 deep blue
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.add_box, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Text('PSW Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'), // Match wireframe woman
                ),
                SizedBox(width: 12),
                Text('Welcome, Sarah Johnson', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                SizedBox(width: 6),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
              ],
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;
          
          if (!isDesktop) {
            // Simplified mobile wrapper for compilation safety
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildUpcomingVisits(context), 
                  const SizedBox(height: 16),
                  _buildTodaysTasks(context),
                  const SizedBox(height: 16),
                  _buildClientAlerts(context),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showContactDirectory(context),
                      icon: const Icon(Icons.contacts, color: Colors.white),
                      label: const Text('Contact Directory', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Top KPI Row
                Row(
                  children: [
                    PrimeCareKpiCard(title: 'Today\'s Visits', value: '8', icon: Icons.calendar_month, subtitle: ''),
                    const SizedBox(width: 20),
                    PrimeCareKpiCard(title: 'Clients Assigned', value: '18', icon: Icons.people, subtitle: ''),
                    const SizedBox(width: 20),
                    PrimeCareKpiCard(title: 'Hours Worked This Week', value: '32', icon: Icons.access_time, subtitle: 'hrs'),
                    const SizedBox(width: 20),
                    PrimeCareKpiCard(title: 'Upcoming Shifts', value: '4', icon: Icons.assignment_turned_in, subtitle: ''),
                  ],
                ),
                const SizedBox(height: 24),
                // Main Grid Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Wide Column
                    Expanded(
                      flex: 13,
                      child: Column(
                        children: [
                          _buildUpcomingVisits(context),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 10, child: _buildDailyOverview()),
                              const SizedBox(width: 24),
                              Expanded(flex: 8, child: _buildRecentNotes(context)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 10, child: _buildClientLocations()),
                              const SizedBox(width: 24),
                              Expanded(flex: 12, child: _buildTrainingResources()),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right Narrow Column
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTodaysTasks(context),
                          const SizedBox(height: 24),
                          _buildClientAlerts(context),
                          const SizedBox(height: 24),
                          _buildShiftReportSummary(context),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => _showContactDirectory(context),
                            icon: const Icon(Icons.contacts, color: Colors.white),
                            label: const Text('View Contact Directory', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E88E5),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showContactDirectory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('PrimeCare Roles & Email Directory', style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SizedBox(
            width: 600,
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactSection('Corporate / Head Office', {
                    'Founder / CEO': 'ceo@primecare.com',
                    'COO (Operations Head)': 'operations@primecare.com',
                    'CFO (Finance Head)': 'finance@primecare.com',
                    'CTO (Tech Head)': 'tech@primecare.com',
                    'Compliance Manager': 'compliance@primecare.com',
                    'Head of Business Development': 'growth@primecare.com',
                    'Head of Marketing': 'marketing@primecare.com',
                    'Training Director': 'training@primecare.com',
                  }),
                  _buildContactSection('Business Development Team', {
                    'Regional BD Manager (ON)': 'bd.ontario@primecare.com',
                    'Regional BD Manager (USA)': 'bd.usa@primecare.com',
                    'Franchise Sales Manager': 'franchise@primecare.com',
                    'Partnership Manager': 'partnerships@primecare.com',
                    'Territory Expansion Manager': 'expansion@primecare.com',
                  }),
                  _buildContactSection('Franchise Level (Hamilton)', {
                    'Franchise Owner': 'owner@hamilton.primecare.com',
                    'Operations Manager': 'ops@hamilton.primecare.com',
                    'Scheduler / Coordinator': 'schedule@hamilton.primecare.com',
                    'Billing / Admin': 'billing@hamilton.primecare.com',
                    'HR / Hiring': 'hr@hamilton.primecare.com',
                  }),
                  _buildContactSection('Clinical Team', {
                    'RN (Registered Nurse)': 'rn1@hamilton.primecare.com',
                    'RPN': 'rpn1@hamilton.primecare.com',
                    'RMT': 'rmt1@hamilton.primecare.com',
                    'PSW': 'psw1@hamilton.primecare.com',
                  }),
                  _buildContactSection('Support Team', {
                    'Customer Support': 'support@primecare.com',
                    'Intake Coordinator': 'intake@primecare.com',
                    'Quality Assurance': 'qa@primecare.com',
                    'Training Coordinator': 'training.support@primecare.com',
                  }),
                  _buildContactSection('Marketing and Local Growth', {
                    'Local Marketing Manager': 'marketing@hamilton.primecare.com',
                    'Community Outreach': 'outreach@hamilton.primecare.com',
                    'Territory Sales Manager': 'sales@hamilton.primecare.com',
                  }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close', style: TextStyle(color: Color(0xFF1E5BB2))),
            )
          ],
        );
      }
    );
  }

  Widget _buildContactSection(String title, Map<String, String> contacts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FB),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F4C81))),
        ),
        const SizedBox(height: 8),
        ...contacts.entries.map((e) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(e.key, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF333333)))),
              Text(e.value, style: const TextStyle(color: Color(0xFF1D72B8))),
            ],
          ),
        )).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}
