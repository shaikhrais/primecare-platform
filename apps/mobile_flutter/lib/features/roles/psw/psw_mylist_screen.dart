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
    return const _InteractiveTaskList();
  }
}

class _InteractiveTaskList extends StatefulWidget {
  const _InteractiveTaskList();
  @override
  State<_InteractiveTaskList> createState() => _InteractiveTaskListState();
}

class _InteractiveTaskListState extends State<_InteractiveTaskList> {
  final List<Map<String, dynamic>> _tasks = [
    {'id': '1', 'title': 'Medication Reminder', 'subtitle': 'Mary Davies - 11:30 AM', 'status': 'Overdue', 'color': Colors.red, 'icon': Icons.warning},
    {'id': '2', 'title': 'Bathing Assistance', 'subtitle': 'Robert Lee - 2:00 PM', 'status': 'Due Today', 'color': Colors.orange, 'icon': Icons.shower},
    {'id': '3', 'title': 'Complete Visit Notes', 'subtitle': 'John Smith', 'status': 'Pending', 'color': Colors.blue, 'icon': Icons.edit_note},
    {'id': '4', 'title': 'Submit Weekly Timesheet', 'subtitle': 'Due by Friday', 'status': 'Completed', 'color': Colors.green, 'icon': Icons.check_circle},
  ];

  @override
  Widget build(BuildContext context) {
    if (_tasks.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('All tasks completed!')));
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tasks.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) newIndex -= 1;
          final item = _tasks.removeAt(oldIndex);
          _tasks.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Dismissible(
          key: Key(task['id']),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Icon(Icons.check, color: Colors.white, size: 32),
          ),
          onDismissed: (direction) {
            setState(() => _tasks.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${task['title']} marked complete')));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: PrimeCareCardContainer(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundColor: task['color'].withOpacity(0.1), child: Icon(task['icon'], color: task['color'])),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(task['subtitle'], style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: task['color'], borderRadius: BorderRadius.circular(16)),
                    child: Text(task['status'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.drag_indicator, color: Colors.grey)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('Today\'s Prioritized Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
        const SizedBox(height: 24),
        _buildTasksList(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        const Text('Today\'s Prioritized Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
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
