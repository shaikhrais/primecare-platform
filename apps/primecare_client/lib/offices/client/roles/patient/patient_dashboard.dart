import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PatientDashboardScreen extends ConsumerWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'My Care Dashboard',
      subtitle: 'Welcome to your digital health sanctuary',
      icon: LucideIcons.userCircle,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.bell),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Hero Area
            Container(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    PrimeCareTheme.primary,
                    PrimeCareTheme.primaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: PrimeCareTheme.primary.withOpacity(0.15),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Eleanor.',
                          style: PrimeCareTheme.displaySmall.copyWith(
                            color: PrimeCareTheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing3),
                        Text(
                          'Your overall health score is trending positively. You have an upcoming appointment in 3 days.',
                          style: PrimeCareTheme.titleMedium.copyWith(
                            color: PrimeCareTheme.onPrimaryContainer
                                .withOpacity(0.9),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: PrimeCareTheme.spacing6),
                  // Upcoming Appointment Card inside Hero
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.surfaceContainerLowest
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(
                          PrimeCareTheme.radiusLg,
                        ),
                        border: Border.all(
                          color: PrimeCareTheme.surfaceContainerLowest
                              .withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: PrimeCareTheme.surfaceContainerLowest,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.calendarClock,
                              color: PrimeCareTheme.primary,
                            ),
                          ),
                          const SizedBox(width: PrimeCareTheme.spacing4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Physiotherapy Session',
                                  style: PrimeCareTheme.titleSmall.copyWith(
                                    color: PrimeCareTheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'Thursday, Oct 12 • 2:00 PM',
                                  style: PrimeCareTheme.labelMedium.copyWith(
                                    color: PrimeCareTheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Quick Actions & Health Summary
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quick Actions', style: PrimeCareTheme.titleLarge),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        Row(
                          children: [
                            Expanded(
                              child: _buildQuickAction(
                                LucideIcons.calendarPlus,
                                'Book Visit',
                                PrimeCareTheme.primaryFixed,
                              ),
                            ),
                            const SizedBox(width: PrimeCareTheme.spacing3),
                            Expanded(
                              child: _buildQuickAction(
                                LucideIcons.pill,
                                'Refill Meds',
                                PrimeCareTheme.secondaryFixed,
                              ),
                            ),
                            const SizedBox(width: PrimeCareTheme.spacing3),
                            Expanded(
                              child: _buildQuickAction(
                                LucideIcons.fileText,
                                'Test Results',
                                PrimeCareTheme.tertiaryFixed,
                              ),
                            ),
                            const SizedBox(width: PrimeCareTheme.spacing3),
                            Expanded(
                              child: _buildQuickAction(
                                LucideIcons.receipt,
                                'Billing',
                                PrimeCareTheme.surfaceContainerHigh,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Daily Goals', style: PrimeCareTheme.titleLarge),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildGoalRing(
                              'Mobility',
                              0.8,
                              PrimeCareTheme.primary,
                            ),
                            _buildGoalRing(
                              'Hydration',
                              0.4,
                              PrimeCareTheme.secondary,
                            ),
                            _buildGoalRing(
                              'Rest',
                              0.9,
                              PrimeCareTheme.tertiary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Messages & Updates
            Text('From Your Care Team', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildMessageCard(
                    'Nurse Sarah',
                    'Your latest blood work results are in and looking great. Ensure you keep up with the new iron supplement.',
                    '2 hours ago',
                    true,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildMessageCard(
                    'Dr. Chen',
                    'Please remember to complete your pre-appointment questionnaire before Thursday.',
                    'Yesterday',
                    false,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildMessageCard(
                    'Billing Ops',
                    'Your recent session invoice has been processed and submitted to insurance.',
                    'Oct 1',
                    false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: PrimeCareTheme.onSurface),
          const SizedBox(height: PrimeCareTheme.spacing2),
          Text(
            label,
            style: PrimeCareTheme.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRing(String label, double percent, Color activeColor) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation(
                  PrimeCareTheme.surfaceContainerHigh,
                ),
              ),
              CircularProgressIndicator(
                value: percent,
                strokeWidth: 6,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation(activeColor),
              ),
              Center(
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: PrimeCareTheme.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: PrimeCareTheme.spacing2),
        Text(label, style: PrimeCareTheme.labelSmall),
      ],
    );
  }

  Widget _buildMessageCard(
    String sender,
    String message,
    String time,
    bool unread,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: PrimeCareTheme.primaryContainer,
                        child: Text(
                          sender[0],
                          style: PrimeCareTheme.labelSmall.copyWith(
                            color: PrimeCareTheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing2),
                      Text(
                        sender,
                        style: PrimeCareTheme.titleSmall.copyWith(
                          fontWeight: unread
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    time,
                    style: PrimeCareTheme.labelSmall.copyWith(
                      color: PrimeCareTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PrimeCareTheme.spacing3),
              Text(
                message,
                style: PrimeCareTheme.bodyMedium.copyWith(
                  color: unread
                      ? PrimeCareTheme.onSurface
                      : PrimeCareTheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: PrimeCareTheme.spacing3),
              Text(
                'Read More',
                style: PrimeCareTheme.labelMedium.copyWith(
                  color: PrimeCareTheme.primary,
                ),
              ),
            ],
          ),
          if (unread)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: PrimeCareTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
