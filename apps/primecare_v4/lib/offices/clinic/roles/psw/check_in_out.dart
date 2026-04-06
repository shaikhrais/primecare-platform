import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CheckInOutScreen extends ConsumerWidget {
  const CheckInOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Shift Check In / Out',
                style: PrimeCareTheme.typography.heroTitle.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Log your time and GPS location for current visit.',
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 48),
              ClinicalGlassPanel(
                padding: const EdgeInsets.all(40),
                width: 400,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.mapPin,
                        size: 40,
                        color: PrimeCareTheme.colors.emeraldTeal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Eleanor Vance',
                      style: PrimeCareTheme.typography.h2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '142 Maplewood Dr, Apt 4B',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.clock, size: 16, color: PrimeCareTheme.colors.slateGray),
                        const SizedBox(width: 8),
                        Text(
                          'Current Time: 09:14 AM',
                          style: PrimeCareTheme.typography.label.copyWith(
                            fontWeight: FontWeight.bold,
                            color: PrimeCareTheme.colors.navyIndigo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ClinicalGlassButton(
                      onPressed: () {},
                      label: 'Swipe to Check-In',
                      isFullWidth: true,
                      icon: LucideIcons.arrowRight,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: PrimeCareTheme.colors.surfaceContainerHighest),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Unable to access location?',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
