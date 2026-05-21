import 'package:flutter/material.dart';
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
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
