import 'package:flutter/material.dart';
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
