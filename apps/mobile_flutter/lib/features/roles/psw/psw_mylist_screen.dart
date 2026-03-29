import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswMyListScreen extends StatelessWidget {
  const PswMyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: const PrimeCareAppBar(title: 'My List (To-Do)'),
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(),
        tablet: _buildDesktopLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildTaskCard(String title, String subtitle, String status, Color statusColor, IconData icon) {
    return PrimeCareCardContainer(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: statusColor.withOpacity(0.1), child: Icon(icon, color: statusColor)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(16)),
            child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTaskCard('Medication Reminder', 'Mary Davies - 11:30 AM', 'Overdue', Colors.red, Icons.warning),
        const SizedBox(height: 16),
        _buildTaskCard('Bathing Assistance', 'Robert Lee - 2:00 PM', 'Due Today', Colors.orange, Icons.shower),
        const SizedBox(height: 16),
        _buildTaskCard('Complete Visit Notes', 'John Smith', 'Pending', Colors.blue, Icons.edit_note),
        const SizedBox(height: 16),
        _buildTaskCard('Submit Weekly Timesheet', 'Due by Friday', 'Completed', Colors.green, Icons.check_circle),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('Today\'s Prioritized Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        const SizedBox(height: 24),
        _buildTasksList(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        const Text('Today\'s Prioritized Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        const SizedBox(height: 32),
        // On desktop, we could do a grid view for tasks or just keep a constrained list
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: _buildTasksList(),
          ),
        )
      ],
    );
  }
}
