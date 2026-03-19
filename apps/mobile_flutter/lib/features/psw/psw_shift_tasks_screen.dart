import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswShiftTasksScreen extends StatefulWidget {
  const PswShiftTasksScreen({super.key});

  @override
  State<PswShiftTasksScreen> createState() => _PswShiftTasksScreenState();
}

class _PswShiftTasksScreenState extends State<PswShiftTasksScreen> {
  // SwipeToAction natively simulated ADL tasks
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Check Blood Pressure', 'completed': false, 'mandatory': true},
    {'title': 'Administer Morning Meds', 'completed': false, 'mandatory': true},
    {'title': 'Assist with Bathing', 'completed': false, 'mandatory': false},
    {'title': 'Prepare Breakfast', 'completed': true, 'mandatory': false},
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((t) => t['completed']).length;
    double progress = _tasks.isEmpty ? 0 : completedCount / _tasks.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const PrimeCareAppBar(title: 'Schedule Tasks'),
      body: CustomScrollView(
        slivers: [
          // Apple Watch Style Completion Rings Tracker
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: const Color(0xFFE2E8F0),
                          color: const Color(0xFF10B981),
                          strokeCap: StrokeCap.round,
                        ),
                        Center(
                          child: Text(
                            '${(progress * 100).toInt()}%', 
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ADL Progress', style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        Text(
                          '$completedCount of ${_tasks.length} tasks completed', 
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // High-Fidelity Swipe-to-Action Checklist
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final task = _tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Dismissible(
                    key: Key(task['title']),
                    onDismissed: (_) {
                       HapticFeedback.mediumImpact();
                       setState(() {
                         task['completed'] = !task['completed'];
                         _tasks.add(_tasks.removeAt(index)); // Push to bottom temporarily for visualization
                       });
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: task['completed'] ? const Color(0xFFE11D48) : const Color(0xFF10B981), 
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: task['completed'] ? Alignment.centerRight : Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Icon(task['completed'] ? Icons.undo : Icons.check, color: Colors.white, size: 32),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        value: task['completed'],
                        onChanged: (val) {
                          HapticFeedback.selectionClick();
                          setState(() => task['completed'] = val);
                        },
                        activeColor: const Color(0xFF10B981),
                        side: const BorderSide(color: Color(0xFFCBD5E1), width: 2),
                        title: Text(
                          task['title'], 
                          style: TextStyle(
                            decoration: task['completed'] ? TextDecoration.lineThrough : null,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: task['completed'] ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
                          ),
                        ),
                        subtitle: task['mandatory'] 
                          ? const Padding(padding: EdgeInsets.only(top: 4.0), child: Text('Mandatory for Checkout', style: TextStyle(color: Color(0xFFE11D48), fontSize: 13, fontWeight: FontWeight.w600))) 
                          : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: _tasks.length,
            ),
          )
        ],
      ),
    );
  }
}
