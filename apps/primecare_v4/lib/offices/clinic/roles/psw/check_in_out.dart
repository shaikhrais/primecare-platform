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
      subtitle: 'Log arrival and departure times for EVV compliance.',
      kpiCards: [
        KPICardData(title: 'Hours Logged', value: '24', icon: LucideIcons.clock, trend: 0.0, trendLabel: 'this week'),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Icon(LucideIcons.checkCircle, color: PrimeCareTheme.colors.emeraldTeal),
                    const SizedBox(width: 8),
                    Text('Clocked In', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.emeraldTeal, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
               const SizedBox(height: 16),
               Text('Since: 08:00 AM', style: PrimeCareTheme.typography.body),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(LucideIcons.mapPin, size: 64, color: PrimeCareTheme.colors.navyIndigo),
                 const SizedBox(height: 24),
                 Text('Electronic Visit Verification', style: PrimeCareTheme.typography.h2),
                 const SizedBox(height: 8),
                 Text('Please ensure location services are enabled on your device.', textAlign: TextAlign.center, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.logIn),
                        label: const Text('Check In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareTheme.colors.emeraldTeal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.logOut),
                        label: const Text('Check Out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareTheme.colors.coralBlush,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  )
               ],
             )
          )
        ),
      ],
    );
  }
}
