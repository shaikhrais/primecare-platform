import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswDailyLogsScreen extends ConsumerWidget {
  const PswDailyLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Daily Logs',
      subtitle:
          'Review and submit shift notes, observations, and care metrics.',
      kpiCards: [
        KPICardData(
          title: 'Notes Submitted',
          value: '4',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Drafts',
          value: '1',
          icon: LucideIcons.pencil,
          trend: 0.0,
          trendLabel: 'needs completion',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Quick Entry', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.plus),
                label: const Text('New Observation Log'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.navyIndigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.mic),
                label: const Text('Voice Dictation'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Logs', style: PrimeCareTheme.typography.h2),
                  DropdownButton<String>(
                    value: 'Today',
                    items: const [
                      DropdownMenuItem(value: 'Today', child: Text('Today')),
                      DropdownMenuItem(
                        value: 'Yesterday',
                        child: Text('Yesterday'),
                      ),
                      DropdownMenuItem(
                        value: 'Past Week',
                        child: Text('Past Week'),
                      ),
                    ],
                    onChanged: (val) {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLogEntry(
                'Thurgood Marshall',
                'Patient reported feeling dizzy after standing up. Blood pressure was slightly elevated. Informed RN on duty.',
                '11:45 AM',
                'Observation',
                PrimeCareTheme.colors.brickRed,
              ),
              _buildLogEntry(
                'Sonia Sotomayor',
                'Completed morning hygiene routine without issues. Patient was in good spirits and ate full breakfast.',
                '09:15 AM',
                'Routine',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildLogEntry(
                'Elena Kagan',
                'Arrived for shift. Patient resting comfortably in living room.',
                '08:00 AM',
                'Check-In',
                PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogEntry(
    String patientName,
    String note,
    String time,
    String type,
    Color typeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: typeColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.user,
                    size: 16,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 8),
                  Text(patientName, style: PrimeCareTheme.typography.h3),
                ],
              ),
              Text(
                time,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(note, style: PrimeCareTheme.typography.body),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              type,
              style: PrimeCareTheme.typography.label.copyWith(
                color: typeColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
