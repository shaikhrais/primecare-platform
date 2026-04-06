import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CareTasksScreen extends ConsumerStatefulWidget {
  const CareTasksScreen({super.key});

  @override
  ConsumerState<CareTasksScreen> createState() => _CareTasksScreenState();
}

class _CareTasksScreenState extends ConsumerState<CareTasksScreen> {
  final Map<String, bool> _tasks = {
    'Administer morning medications': true,
    'Assist with breakfast preparation': true,
    'Mobility exercises (15 mins)': false,
    'Check and record blood pressure': false,
    'Light housekeeping (kitchen area)': false,
    'Log out context shift': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Care Tasks',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage and track pending assignments for current shift.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: _tasks.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _tasks[entry.key] = !entry.value;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: entry.value ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.05) : PrimeCareTheme.colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: entry.value ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3) : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              entry.value ? LucideIcons.checkCircle2 : LucideIcons.circle,
                              color: entry.value ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.slateGray,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: PrimeCareTheme.typography.body.copyWith(
                                  decoration: entry.value ? TextDecoration.lineThrough : null,
                                  color: entry.value ? PrimeCareTheme.colors.slateGray : PrimeCareTheme.colors.navyIndigo,
                                  fontWeight: entry.value ? FontWeight.normal : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
