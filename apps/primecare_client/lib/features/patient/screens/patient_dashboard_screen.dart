import 'package:flutter/material.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: SingleChildScrollView(
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
                                Expanded(child: Text(r'Outstanding invoice of $45.00 is due.')),
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
