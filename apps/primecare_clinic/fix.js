// Governance - Category: service | Purpose: Core implementation file for the Fix platform logic.
const fs = require('fs');

const clinical = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ClinicalDirectorDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class ClinicalDirectorDashboardScreen extends StatefulWidget {
  const ClinicalDirectorDashboardScreen({super.key});

  @override
  State<ClinicalDirectorDashboardScreen> createState() => _ClinicalDirectorDashboardScreenState();
}

class _ClinicalDirectorDashboardScreenState extends State<ClinicalDirectorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinical Director Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Clinical Quality Outcomes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatTile(icon: LucideIcons.activity, label: 'Patient Satisfaction', value: '94%'),
                        _StatTile(icon: LucideIcons.alertTriangle, label: 'Incident Reports', value: '3 Active'),
                        _StatTile(icon: LucideIcons.checkCircle, label: 'Compliance Rate', value: '98%'),
                        _StatTile(icon: LucideIcons.users, label: 'Staffing Coverage', value: '100%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Provider Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ProviderRow(name: 'Dr. Sarah Jenkins', role: 'Physician', status: 'Excellent'),
                          _ProviderRow(name: 'Nurse Tom Riley', role: 'RN', status: 'Review Needed'),
                          _ProviderRow(name: 'Amanda Brooks', role: 'Physiotherapist', status: 'Good'),
                          _ProviderRow(name: 'Kevin Hart', role: 'PSW', status: 'Excellent'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Compliance Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _AlertRow(message: '3 CPR Certifications expiring this week.', isUrgent: true),
                          _AlertRow(message: 'Q2 Infection Control Audit pending.', isUrgent: false),
                          _AlertRow(message: 'Protocol update for COVID-19 required.', isUrgent: true),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color(0xFF0F766E)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _ProviderRow extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  const _ProviderRow({required this.name, required this.role, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(LucideIcons.user, color: Colors.black)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(role),
      trailing: Chip(
        label: Text(status, style: TextStyle(color: status == 'Review Needed' ? Colors.white : Colors.black)),
        backgroundColor: status == 'Review Needed' ? Colors.red : Colors.green[100],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  final String message;
  final bool isUrgent;
  const _AlertRow({required this.message, required this.isUrgent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUrgent ? Colors.red[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isUrgent ? Colors.red : Colors.orange),
      ),
      child: Row(
        children: [
          Icon(isUrgent ? LucideIcons.alertOctagon : LucideIcons.bell, color: isUrgent ? Colors.red : Colors.orange),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
`;

const physician = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PhysicianDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class PhysicianDashboardScreen extends StatefulWidget {
  const PhysicianDashboardScreen({super.key});

  @override
  State<PhysicianDashboardScreen> createState() => _PhysicianDashboardScreenState();
}

class _PhysicianDashboardScreenState extends State<PhysicianDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Physician Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.users, size: 40, color: Color(0xFF0F766E)),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Today\\'s Appointments', style: TextStyle(color: Colors.grey)),
                              Text('14 Patients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.microscope, size: 40, color: Colors.blue),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Pending Lab Results', style: TextStyle(color: Colors.grey)),
                              Text('6 Results', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.clipboardList, size: 40, color: Colors.orange),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Charts to Sign', style: TextStyle(color: Colors.grey)),
                              Text('9 Charts', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Upcoming Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ScheduleRow(time: '09:00 AM', patient: 'John Doe', reason: 'Annual Physical', status: 'Waiting'),
                          _ScheduleRow(time: '09:30 AM', patient: 'Mary Smith', reason: 'Hypertension Follow-up', status: 'Not Arrived'),
                          _ScheduleRow(time: '10:00 AM', patient: 'Robert Chen', reason: 'Back Pain', status: 'Not Arrived'),
                          _ScheduleRow(time: '10:45 AM', patient: 'Susan White', reason: 'Diabetes Check', status: 'Not Arrived'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Urgent Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _TaskItem(title: 'Review MRI - D. Johnson', isCritical: true),
                          _TaskItem(title: 'Prescription Refill - E. Davis', isCritical: false),
                          _TaskItem(title: 'Sign discharge papers', isCritical: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String time;
  final String patient;
  final String reason;
  final String status;
  const _ScheduleRow({required this.time, required this.patient, required this.reason, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      title: Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(reason),
      trailing: Chip(
        label: Text(status),
        backgroundColor: status == 'Waiting' ? Colors.orange[100] : Colors.grey[200],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final bool isCritical;
  const _TaskItem({required this.title, required this.isCritical});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(isCritical ? LucideIcons.alertCircle : LucideIcons.checkCircle, color: isCritical ? Colors.red : Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontWeight: isCritical ? FontWeight.bold : FontWeight.normal))),
        ],
      ),
    );
  }
}
`;

const rn = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide RnDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class RnDashboardScreen extends StatefulWidget {
  const RnDashboardScreen({super.key});

  @override
  State<RnDashboardScreen> createState() => _RnDashboardScreenState();
}

class _RnDashboardScreenState extends State<RnDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RN Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Ward: Post-Op Care', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('My Patients (Triage)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              _PatientTriageRow(room: 'Room 101', name: 'Alice Walker', status: 'Stable', vitals: 'BP 120/80, HR 72'),
                              _PatientTriageRow(room: 'Room 102', name: 'James Smith', status: 'Monitor', vitals: 'BP 145/90, HR 88'),
                              _PatientTriageRow(room: 'Room 105', name: 'Eva Brown', status: 'Stable', vitals: 'BP 118/76, HR 68'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Medication Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              _MedicationRow(time: '12:00 PM', patient: 'Alice Walker', med: 'Amoxicillin 500mg', isDue: true),
                              _MedicationRow(time: '14:00 PM', patient: 'James Smith', med: 'Lisinopril 10mg', isDue: false),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Shift Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _TaskCheckbox(task: 'Check vitals for Room 102', completed: false),
                          _TaskCheckbox(task: 'Update charting for Alice Walker', completed: true),
                          _TaskCheckbox(task: 'Change dressing - Room 105', completed: false),
                          _TaskCheckbox(task: 'Restock supply cart', completed: false),
                          const Divider(),
                          ElevatedButton(onPressed: () {}, child: const Text('View All Tasks')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientTriageRow extends StatelessWidget {
  final String room;
  final String name;
  final String status;
  final String vitals;
  const _PatientTriageRow({required this.room, required this.name, required this.status, required this.vitals});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: status == 'Stable' ? Colors.green[100] : Colors.orange[100],
        child: Text(room.replaceAll('Room ', ''), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Vitals: $vitals'),
      trailing: Chip(
        label: Text(status),
        backgroundColor: status == 'Stable' ? Colors.green[100] : Colors.orange[100],
      ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  final String time;
  final String patient;
  final String med;
  final bool isDue;
  const _MedicationRow({required this.time, required this.patient, required this.med, required this.isDue});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(LucideIcons.pill, color: isDue ? Colors.red : Colors.grey),
      title: Text(med, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$patient at $time'),
      trailing: isDue ? ElevatedButton(onPressed: () {}, child: const Text('Administer')) : const Text('Scheduled', style: TextStyle(color: Colors.grey)),
    );
  }
}

class _TaskCheckbox extends StatelessWidget {
  final String task;
  final bool completed;
  const _TaskCheckbox({required this.task, required this.completed});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: completed,
      onChanged: (val) {},
      title: Text(task, style: TextStyle(decoration: completed ? TextDecoration.lineThrough : null)),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
`;

const psw = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PswDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class PswDashboardScreen extends StatefulWidget {
  const PswDashboardScreen({super.key});

  @override
  State<PswDashboardScreen> createState() => _PswDashboardScreenState();
}

class _PswDashboardScreenState extends State<PswDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PSW Daily Schedule'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Status', style: TextStyle(color: Colors.white70)),
                      Text('Clocked In - On Route', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF0F766E)),
                    child: const Text('Clock Out'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\\'s Visits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _VisitCard(
                      time: '08:00 AM - 10:00 AM',
                      patient: 'Eleanor Rigby',
                      address: '123 Main St, Apt 4B',
                      tasks: const ['Assist with bathing', 'Prepare breakfast', 'Administer morning meds'],
                      status: 'Completed',
                    ),
                    _VisitCard(
                      time: '10:30 AM - 12:30 PM',
                      patient: 'Arthur Pendelton',
                      address: '456 Oak Ave',
                      tasks: const ['Light housekeeping', 'Mobility exercises', 'Prepare lunch'],
                      status: 'In Progress',
                    ),
                    _VisitCard(
                      time: '01:30 PM - 03:30 PM',
                      patient: 'Margaret Thatcher',
                      address: '789 Pine Rd',
                      tasks: const ['Grocery shopping', 'Companionship'],
                      status: 'Pending',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisitCard extends StatelessWidget {
  final String time;
  final String patient;
  final String address;
  final List<String> tasks;
  final String status;
  const _VisitCard({required this.time, required this.patient, required this.address, required this.tasks, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Completed') statusColor = Colors.green;
    else if (status == 'In Progress') statusColor = Colors.blue;
    else statusColor = Colors.orange;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Chip(label: Text(status, style: const TextStyle(color: Colors.white)), backgroundColor: statusColor),
              ],
            ),
            const SizedBox(height: 8),
            Text(patient, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(address, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 24),
            const Text('Required Tasks:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...tasks.map((t) => Row(
              children: [
                const Icon(LucideIcons.check, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Text(t),
              ],
            )).toList(),
            const SizedBox(height: 16),
            if (status == 'In Progress')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: const Text('Complete Visit & Add Notes')),
              )
          ],
        ),
      ),
    );
  }
}
`;

const intake = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart' hide IntakeCoordinatorDashboardScreen;
import 'package:lucide_icons/lucide_icons.dart';

class IntakeCoordinatorDashboardScreen extends StatefulWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  State<IntakeCoordinatorDashboardScreen> createState() => _IntakeCoordinatorDashboardScreenState();
}

class _IntakeCoordinatorDashboardScreenState extends State<IntakeCoordinatorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intake Coordinator Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _MetricCard(title: 'Pending Referrals', value: '12', icon: LucideIcons.fileText, color: Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _MetricCard(title: 'Insurance Verifications', value: '5', icon: LucideIcons.shieldCheck, color: Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _MetricCard(title: 'Intakes Scheduled Today', value: '8', icon: LucideIcons.calendar, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Patient Referrals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Patient Name')),
                        DataColumn(label: Text('Referred By')),
                        DataColumn(label: Text('Service Type')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: [
                        _referralRow('Michael Chang', 'Dr. Adams', 'Physiotherapy', 'Pending Review'),
                        _referralRow('Sarah Connor', 'City Hospital', 'Post-Op Care', 'Insurance Pending'),
                        _referralRow('David Miller', 'Dr. Adams', 'Home Care', 'Approved'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DataRow _referralRow(String name, String referrer, String service, String status) {
    return DataRow(cells: [
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text(referrer)),
      DataCell(Text(service)),
      DataCell(Chip(label: Text(status), backgroundColor: status == 'Approved' ? Colors.green[100] : Colors.orange[100])),
      DataCell(TextButton(onPressed: () {}, child: const Text('Process'))),
    ]);
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/shared/screens/clinical_director_dashboard_screen.dart', clinical);
fs.writeFileSync('lib/features/physician/screens/physician_dashboard_screen.dart', physician);
fs.writeFileSync('lib/features/rn/screens/rn_dashboard_screen.dart', rn);
fs.writeFileSync('lib/features/psw/screens/psw_dashboard_screen.dart', psw);
fs.writeFileSync('lib/features/shared/screens/intake_coordinator_dashboard_screen.dart', intake);
