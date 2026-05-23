// Governance - Category: view | Purpose: UI Screen component rendering the Family Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
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
