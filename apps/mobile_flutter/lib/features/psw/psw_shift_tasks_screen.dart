import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';

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

    return PrimeCareScaffold(
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: CustomScrollView(
            slivers: [
              // Apple Watch Style Completion Rings Tracker
              SliverToBoxAdapter(
                child: PrimeCarePadding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: PrimeCareRow(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: PrimeCareStack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 10,
                              backgroundColor: PrimeCareColors.slate200,
                              color: PrimeCareColors.emerald,
                              strokeCap: StrokeCap.round,
                            ),
                            PrimeCareCenter(
                              child: PrimeCareText(
                                '${(progress * 100).toInt()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: PrimeCareColors.radarDark,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 32),
                      PrimeCareExpanded(
                        child: PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeCareText(
                              'ADL Progress',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(height: 8),
                            PrimeCareText(
                              '$completedCount of ${_tasks.length} tasks completed',
                              style: TextStyle(
                                color: PrimeCareColors.slate500,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // High-Fidelity Swipe-to-Action Checklist
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final task = _tasks[index];
                  return PrimeCarePadding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Dismissible(
                      key: Key(task['title']),
                      onDismissed: (_) {
                        HapticFeedback.mediumImpact();
                        setState(() {
                          task['completed'] = !task['completed'];
                          _tasks.add(
                            _tasks.removeAt(index),
                          ); // Push to bottom temporarily for visualization
                        });
                      },
                      background: Container(
                        color: PrimeCareColors.emerald,
                        alignment: task['completed']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: PrimeCareIcon(
                          task['completed'] ? Icons.undo : Icons.check,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      child: PrimeCareCard(
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          value: task['completed'],
                          onChanged: (val) {
                            HapticFeedback.selectionClick();
                            setState(() => task['completed'] = val);
                          },
                          activeColor: PrimeCareColors.emerald,
                          side: BorderSide(
                            color: PrimeCareColors.slate300,
                            width: 2,
                          ),
                          title: PrimeCareText(
                            task['title'],
                            style: TextStyle(
                              decoration: task['completed']
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: task['completed']
                                  ? PrimeCareColors.slate400
                                  : PrimeCareColors.radarDark,
                            ),
                          ),
                          subtitle: task['mandatory']
                              ? PrimeCarePadding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: PrimeCareText(
                                    'Mandatory for Checkout',
                                    style: TextStyle(
                                      color: PrimeCareColors.rose,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  );
                }, childCount: _tasks.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
