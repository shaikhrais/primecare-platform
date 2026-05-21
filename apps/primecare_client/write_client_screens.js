const fs = require('fs');

const patientDashboard = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<PatientDashboardScreen> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Health Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back, Sarah!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF0284C7))),
            const SizedBox(height: 8),
            const Text('Here is what is happening with your care today.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 32),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle),
                      child: const Icon(LucideIcons.calendar, size: 32, color: Color(0xFF0284C7)),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Next Appointment', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Tomorrow at 10:00 AM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const Text('Physiotherapy with Dr. Adams', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                      onPressed: () {},
                      child: const Text('Reschedule'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.users, color: Color(0xFF0284C7)),
                              SizedBox(width: 8),
                              Text('My Care Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _TeamMemberRow(name: 'Dr. Michael Adams', role: 'Primary Physician'),
                          _TeamMemberRow(name: 'Nurse Jessica Lee', role: 'Care Coordinator'),
                          _TeamMemberRow(name: 'David Smith', role: 'Physiotherapist'),
                          const SizedBox(height: 12),
                          TextButton(onPressed: () {}, child: const Text('View All Providers')),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.bell, color: Colors.orange),
                              SizedBox(width: 8),
                              Text('Action Needed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.orange.shade200)),
                            child: const Row(
                              children: [
                                Icon(LucideIcons.fileText, color: Colors.orange),
                                SizedBox(width: 12),
                                Expanded(child: Text('You have 1 pending intake form to complete before your next visit.')),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red.shade200)),
                            child: const Row(
                              children: [
                                Icon(LucideIcons.creditCard, color: Colors.red),
                                SizedBox(width: 12),
                                Expanded(child: Text('Outstanding invoice of $45.00 is due.')),
                              ],
                            ),
                          ),
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

class _TeamMemberRow extends StatelessWidget {
  final String name;
  final String role;
  const _TeamMemberRow({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(LucideIcons.user, color: Colors.black54)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(role, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Spacer(),
          IconButton(icon: const Icon(LucideIcons.messageCircle, color: Color(0xFF0284C7)), onPressed: () {}),
        ],
      ),
    );
  }
}
`;

const patientBookAppointment = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PatientBookAppointmentScreen extends StatefulWidget {
  const PatientBookAppointmentScreen({super.key});

  @override
  State<PatientBookAppointmentScreen> createState() => _PatientBookAppointmentScreenState();
}

class _PatientBookAppointmentScreenState extends State<PatientBookAppointmentScreen> {
  String selectedService = 'Physiotherapy';
  String selectedDate = 'Tomorrow';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment'), backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Schedule a Visit', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Choose a service and select an available time slot.', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('1. Select Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _ServiceTile(title: 'Physiotherapy', icon: LucideIcons.activity, isSelected: selectedService == 'Physiotherapy', onTap: () => setState(() => selectedService = 'Physiotherapy')),
                          _ServiceTile(title: 'Massage Therapy', icon: LucideIcons.heart, isSelected: selectedService == 'Massage Therapy', onTap: () => setState(() => selectedService = 'Massage Therapy')),
                          _ServiceTile(title: 'Home Care Visit', icon: LucideIcons.home, isSelected: selectedService == 'Home Care Visit', onTap: () => setState(() => selectedService = 'Home Care Visit')),
                          _ServiceTile(title: 'Virtual Consultation', icon: LucideIcons.video, isSelected: selectedService == 'Virtual Consultation', onTap: () => setState(() => selectedService = 'Virtual Consultation')),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('2. Select Date & Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _DateChip(label: 'Today', isSelected: selectedDate == 'Today', onTap: () => setState(() => selectedDate = 'Today')),
                              const SizedBox(width: 12),
                              _DateChip(label: 'Tomorrow', isSelected: selectedDate == 'Tomorrow', onTap: () => setState(() => selectedDate = 'Tomorrow')),
                              const SizedBox(width: 12),
                              _DateChip(label: 'Next Week', isSelected: selectedDate == 'Next Week', onTap: () => setState(() => selectedDate = 'Next Week')),
                              const SizedBox(width: 12),
                              OutlinedButton.icon(onPressed: () {}, icon: const Icon(LucideIcons.calendar), label: const Text('Pick Date')),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text('Available Times:', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _TimeSlot(time: '09:00 AM'),
                              _TimeSlot(time: '09:30 AM'),
                              _TimeSlot(time: '11:00 AM', isSelected: true),
                              _TimeSlot(time: '01:00 PM'),
                              _TimeSlot(time: '02:30 PM'),
                              _TimeSlot(time: '04:00 PM'),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: () {}, child: const Text('Cancel')),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                                onPressed: () {},
                                child: const Text('Confirm Appointment'),
                              )
                            ],
                          )
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

class _ServiceTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  const _ServiceTile({required this.title, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          border: Border.all(color: isSelected ? const Color(0xFF0284C7) : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF0284C7) : Colors.grey),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? const Color(0xFF0284C7) : Colors.black87)),
          ],
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _DateChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFF0284C7),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final String time;
  final bool isSelected;
  const _TimeSlot({required this.time, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0284C7) : Colors.white,
        border: Border.all(color: isSelected ? const Color(0xFF0284C7) : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(time, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
    );
  }
}
`;

const patientPayments = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PatientPaymentsScreen extends StatefulWidget {
  const PatientPaymentsScreen({super.key});

  @override
  State<PatientPaymentsScreen> createState() => _PatientPaymentsScreenState();
}

class _PatientPaymentsScreenState extends State<PatientPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing & Payments'), backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.alertCircle, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Amount Due', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('\$45.00', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                            onPressed: () {},
                            child: const Text('Pay Now'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.shieldCheck, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Insurance Coverage', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('SunLife Financial - Group Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('Policy: #987654321', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          TextButton(onPressed: () {}, child: const Text('Update Insurance Information')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Transaction History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _TransactionRow(date: 'Oct 15, 2023', description: 'Physiotherapy Session (Copay)', amount: '\$45.00', status: 'Unpaid'),
                  const Divider(height: 1),
                  _TransactionRow(date: 'Sep 28, 2023', description: 'Massage Therapy', amount: '\$90.00', status: 'Paid'),
                  const Divider(height: 1),
                  _TransactionRow(date: 'Sep 10, 2023', description: 'Physiotherapy Session (Copay)', amount: '\$45.00', status: 'Paid'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final String date;
  final String description;
  final String amount;
  final String status;
  const _TransactionRow({required this.date, required this.description, required this.amount, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
        child: Icon(status == 'Paid' ? LucideIcons.check : LucideIcons.clock, color: status == 'Paid' ? Colors.green : Colors.orange),
      ),
      title: Text(description, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(status, style: TextStyle(color: status == 'Paid' ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
`;

const familyDashboard = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FamilyDashboardScreen extends StatefulWidget {
  const FamilyDashboardScreen({super.key});

  @override
  State<FamilyDashboardScreen> createState() => _FamilyDashboardScreenState();
}

class _FamilyDashboardScreenState extends State<FamilyDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family Care Overview'), backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Caring for Eleanor', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Upcoming Care Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('View Full Calendar', style: TextStyle(color: Color(0xFF6366F1))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _ScheduleItem(date: 'Today, 10:00 AM', event: 'PSW Home Visit', provider: 'Amanda Brooks (PSW)'),
                          _ScheduleItem(date: 'Tomorrow, 02:00 PM', event: 'RN Assessment', provider: 'Nurse Tom Riley'),
                          _ScheduleItem(date: 'Friday, 11:30 AM', event: 'Physiotherapy', provider: 'David Smith (PT)'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: Colors.indigo[50],
                        child: const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(LucideIcons.heartPulse, color: Color(0xFF6366F1)),
                                  SizedBox(width: 8),
                                  Text('Overall Status', style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text('Stable', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                              SizedBox(height: 8),
                              Text('All vitals normal from last RN visit.'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Emergency Contacts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(LucideIcons.phoneCall, color: Colors.red),
                                title: const Text('Primary Care Clinic'),
                                subtitle: const Text('555-0199'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(LucideIcons.phoneCall, color: Colors.blue),
                                title: const Text('Dr. Michael Adams'),
                                subtitle: const Text('555-0200'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class _ScheduleItem extends StatelessWidget {
  final String date;
  final String event;
  final String provider;
  const _ScheduleItem({required this.date, required this.event, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo[50], shape: BoxShape.circle),
            child: const Icon(LucideIcons.calendarClock, color: Color(0xFF6366F1)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(provider, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
`;

const familyCareUpdates = `import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FamilyCareUpdatesScreen extends StatefulWidget {
  const FamilyCareUpdatesScreen({super.key});

  @override
  State<FamilyCareUpdatesScreen> createState() => _FamilyCareUpdatesScreenState();
}

class _FamilyCareUpdatesScreenState extends State<FamilyCareUpdatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Care Updates & Logs'), backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Care Activity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            _TimelineUpdate(
              date: 'Today, 11:30 AM',
              title: 'PSW Visit Completed',
              provider: 'Amanda Brooks',
              notes: 'Eleanor was in good spirits. Assisted with breakfast and light mobility exercises. Administered morning medications without issue.',
              icon: LucideIcons.checkCircle,
              color: Colors.green,
            ),
            _TimelineUpdate(
              date: 'Yesterday, 04:00 PM',
              title: 'Medication Update',
              provider: 'Dr. Michael Adams',
              notes: 'Prescription for Lisinopril adjusted to 20mg daily based on recent blood pressure readings.',
              icon: LucideIcons.pill,
              color: Colors.orange,
            ),
            _TimelineUpdate(
              date: 'Oct 15, 10:00 AM',
              title: 'RN Assessment Completed',
              provider: 'Nurse Tom Riley',
              notes: 'Vitals stable. BP: 120/80, HR: 72. Wound dressing changed on left leg. Healing well.',
              icon: LucideIcons.activity,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineUpdate extends StatelessWidget {
  final String date;
  final String title;
  final String provider;
  final String notes;
  final IconData icon;
  final Color color;

  const _TimelineUpdate({required this.date, required this.title, required this.provider, required this.notes, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color),
              ),
              Container(
                width: 2,
                height: 80,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.only(top: 8),
              )
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(date, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Provider: $provider', style: const TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text(notes, style: const TextStyle(height: 1.5)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/patient/screens/patient_dashboard_screen.dart', patientDashboard);
fs.writeFileSync('lib/features/patient/screens/patient_book_appointment_screen.dart', patientBookAppointment);
fs.writeFileSync('lib/features/patient/screens/patient_payments_screen.dart', patientPayments);
fs.writeFileSync('lib/features/family/screens/family_dashboard_screen.dart', familyDashboard);
fs.writeFileSync('lib/features/family/screens/family_care_updates_screen.dart', familyCareUpdates);
