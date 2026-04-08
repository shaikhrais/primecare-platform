import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswCheckInOutScreen extends ConsumerWidget {
  const PswCheckInOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Time & Attendance',
      subtitle:
          'Clock in and out of patient visits using verified GPS location.',
      kpiCards: [
        KPICardData(
          title: 'Hours This Week',
          value: '32.5',
          icon: LucideIcons.calendarClock,
          trend: 0.0,
          trendLabel: 'total',
        ),
        KPICardData(
          title: 'Current Visit',
          value: '1h 15m',
          icon: LucideIcons.timer,
          trend: 0.0,
          trendLabel: 'elapsed',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Location Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.checkCircle2,
                      color: PrimeCareTheme.colors.emeraldTeal,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'GPS verified. You are at the approved patient address.',
                        style: TextStyle(
                          color: PrimeCareTheme.colors.emeraldTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.logOut),
                label: const Text('Clock Out (End Visit)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimeCareTheme.colors.amberWarning,
                  foregroundColor: PrimeCareTheme.colors.textPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                  border: Border.all(
                    color: PrimeCareTheme.colors.navyIndigo,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '11:45 AM',
                        style: PrimeCareTheme.typography.h1.copyWith(
                          fontSize: 32,
                          color: PrimeCareTheme.colors.navyIndigo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'CURRENT TIME',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatusPill(
                    'Clocked In: 10:30 AM',
                    PrimeCareTheme.colors.emeraldTeal,
                  ),
                  const SizedBox(width: 16),
                  _buildStatusPill(
                    'Client: Thurgood Marshall',
                    PrimeCareTheme.colors.slateGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
