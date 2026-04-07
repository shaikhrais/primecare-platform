import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class LovedOneScheduleScreen extends ConsumerWidget {
  const LovedOneScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Schedule',
      subtitle: 'Upcoming visits and appointments for Eleanor',
      icon: LucideIcons.calendarDays,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
            boxShadow: [
              BoxShadow(
                color: PrimeCareTheme.primary.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildViewToggle('Daily', true),
              _buildViewToggle('Weekly', false),
            ],
          ),
        ),
      ],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Calendar/Days list
          Expanded(
            flex: 3,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
              child: Column(
                children: [
                  _buildDaySelector('Mon', 'Oct 16', false),
                  const SizedBox(height: PrimeCareTheme.spacing3),
                  _buildDaySelector('Tue', 'Oct 17', true),
                  const SizedBox(height: PrimeCareTheme.spacing3),
                  _buildDaySelector('Wed', 'Oct 18', false),
                  const SizedBox(height: PrimeCareTheme.spacing3),
                  _buildDaySelector('Thu', 'Oct 19', false),
                  const SizedBox(height: PrimeCareTheme.spacing3),
                  _buildDaySelector('Fri', 'Oct 20', false),
                ],
              ),
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing5),

          // Right: Schedule Details
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // Alert Banner
                Container(
                  padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(
                      PrimeCareTheme.radiusXl,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.onSecondaryContainer
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.clock,
                          color: PrimeCareTheme.onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schedule change requested',
                              style: PrimeCareTheme.titleMedium.copyWith(
                                color: PrimeCareTheme.onSecondaryContainer,
                              ),
                            ),
                            Text(
                              'A request to delay Thursday\'s nursing visit by 1 hour is pending approval.',
                              style: PrimeCareTheme.bodyMedium.copyWith(
                                color: PrimeCareTheme.onSecondaryContainer
                                    .withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: PrimeCareTheme.spacing5),

                // Items
                _buildScheduleCard(
                  timeStr: '09:00 AM',
                  duration: '1 hr',
                  provider: 'Nurse Mark Davies',
                  role: 'Morning Vitals & Meds',
                  avatarColor: PrimeCareTheme.primaryContainer,
                  avatarInitials: 'MD',
                  status: 'Confirmed',
                  statusColor: PrimeCareTheme.primary,
                ),
                const SizedBox(height: PrimeCareTheme.spacing4),
                _buildScheduleCard(
                  timeStr: '02:00 PM',
                  duration: '2 hrs',
                  provider: 'Physio Sarah Smith',
                  role: 'Mobility Rehab Protocol',
                  avatarColor: PrimeCareTheme.tertiaryContainer,
                  avatarInitials: 'SS',
                  status: 'Arriving Soon',
                  statusColor: PrimeCareTheme.tertiary,
                ),
                const SizedBox(height: PrimeCareTheme.spacing6),

                // Bottom Action
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.calendarClock, size: 18),
                    label: const Text('Request Schedule Change'),
                    style: TextButton.styleFrom(
                      foregroundColor: PrimeCareTheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: PrimeCareTheme.spacing5,
                        vertical: PrimeCareTheme.spacing4,
                      ),
                      backgroundColor: PrimeCareTheme.surfaceContainerLowest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          PrimeCareTheme.radiusXl,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PrimeCareTheme.spacing5,
        vertical: PrimeCareTheme.spacing3,
      ),
      decoration: BoxDecoration(
        color: isActive ? PrimeCareTheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Text(
        label,
        style: PrimeCareTheme.titleSmall.copyWith(
          color: isActive
              ? PrimeCareTheme.primary
              : PrimeCareTheme.onSurfaceVariant,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDaySelector(String day, String date, bool isSelected) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PrimeCareTheme.primary,
                  PrimeCareTheme.primaryContainer,
                ],
              )
            : null,
        color: isSelected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: PrimeCareTheme.labelMedium.copyWith(
              color: isSelected
                  ? PrimeCareTheme.onPrimaryContainer.withOpacity(0.8)
                  : PrimeCareTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing1),
          Text(
            date,
            style: PrimeCareTheme.titleMedium.copyWith(
              color: isSelected
                  ? PrimeCareTheme.onPrimary
                  : PrimeCareTheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard({
    required String timeStr,
    required String duration,
    required String provider,
    required String role,
    required Color avatarColor,
    required String avatarInitials,
    required String status,
    required Color statusColor,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeStr,
                  style: PrimeCareTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: PrimeCareTheme.spacing1),
                Text(
                  duration,
                  style: PrimeCareTheme.labelSmall.copyWith(
                    color: PrimeCareTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            width: 4,
            height: 60,
            margin: const EdgeInsets.symmetric(
              horizontal: PrimeCareTheme.spacing4,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(role, style: PrimeCareTheme.titleLarge),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          PrimeCareTheme.radiusFull,
                        ),
                      ),
                      child: Text(
                        status,
                        style: PrimeCareTheme.labelSmall.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PrimeCareTheme.spacing4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: avatarColor,
                      child: Text(
                        avatarInitials,
                        style: PrimeCareTheme.titleSmall.copyWith(
                          color: PrimeCareTheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: PrimeCareTheme.spacing3),
                    Text(
                      provider,
                      style: PrimeCareTheme.bodyMedium.copyWith(
                        color: PrimeCareTheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(LucideIcons.messageSquare, size: 20),
                      onPressed: () {},
                      color: PrimeCareTheme.primary,
                      tooltip: 'Message Provider',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
