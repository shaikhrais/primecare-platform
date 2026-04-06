import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalEventsScreen extends ConsumerWidget {
  const LocalEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community Events',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage health fairs, sponsorships, and local pop-ups.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.plus, label: 'Add Event'),
              ],
            ),
            const SizedBox(height: 32),
            Text('Upcoming Events', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            _buildEventCard('Local Marathon Sponsorship', 'May 15, 2026', 'Centennial Park', 'Confirmed'),
            _buildEventCard('Corporate Wellness Fair @ TechHub', 'June 10, 2026', 'Downtown Office Campus', 'Planning'),
            const SizedBox(height: 32),
            Text('Past Events', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            _buildEventCard('Spring Health Expo Booth', 'April 5, 2026', 'Community Center', 'Post-Event Review'),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location, String status) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(title, style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                 decoration: BoxDecoration(
                   color: PrimeCareTheme.colors.surfaceContainerHighest,
                   borderRadius: BorderRadius.circular(16),
                 ),
                 child: Text(status, style: PrimeCareTheme.typography.label),
               )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 16, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 8),
              Text(date, style: PrimeCareTheme.typography.body),
              const SizedBox(width: 16),
              Icon(LucideIcons.mapPin, size: 16, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 8),
              Text(location, style: PrimeCareTheme.typography.body),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.chevronRight, label: 'View Details', isPrimary: false),
          )
        ],
      )
    );
  }
}
