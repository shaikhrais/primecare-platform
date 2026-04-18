import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

import '../theme/design_system.dart';

class PrimeCareGanttTask {
  final String id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final Color? color;

  const PrimeCareGanttTask({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.color,
  });
}

class PrimeCareGanttChart extends StatelessWidget {
  final List<PrimeCareGanttTask> tasks;
  final double height;
  final String title;

  const PrimeCareGanttChart({
    super.key,
    required this.tasks,
    this.height = 300,
    this.title = 'Resource Gantt Schedule',
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox();
    final primary = Theme.of(context).primaryColor;

    // Determine min start and max end to scale timeline
    DateTime minDate = tasks.first.startTime;
    DateTime maxDate = tasks.first.endTime;

    for (var task in tasks) {
      if (task.startTime.isBefore(minDate)) minDate = task.startTime;
      if (task.endTime.isAfter(maxDate)) maxDate = task.endTime;
    }

    final totalDuration = maxDate.difference(minDate).inMinutes;
    if (totalDuration == 0) return const SizedBox();

    return Container(
      height: height,
      padding: const EdgeInsets.all(PrimeCareSpacing.md),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PrimeCareSpacing.md),
          ],
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(tasks.length, (index) {
                  final task = tasks[index];
                  final taskDuration = task.endTime
                      .difference(task.startTime)
                      .inMinutes;
                  final startOffset = task.startTime
                      .difference(minDate)
                      .inMinutes;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: PrimeCareSpacing.md),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final widthPerMinute =
                            constraints.maxWidth / totalDuration;
                        final startLeft = startOffset * widthPerMinute;
                        final taskWidth = (taskDuration * widthPerMinute).clamp(
                          4.0,
                          double.infinity,
                        );

                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: PrimeCareDesignSystem.borderSubtle
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(width: constraints.maxWidth, height: 32),
                              Positioned(
                                left: startLeft,
                                child: Container(
                                  width: taskWidth,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: task.color ?? primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    task.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: PrimeCareColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          // Simple timeline axis
          Container(
            height: 24,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: PrimeCareDesignSystem.borderSubtle),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${minDate.month}/${minDate.day}',
                  style: TextStyle(
                    fontSize: 10,
                    color: PrimeCareDesignSystem.textMuted,
                  ),
                ),
                Text(
                  '${maxDate.month}/${maxDate.day}',
                  style: TextStyle(
                    fontSize: 10,
                    color: PrimeCareDesignSystem.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
