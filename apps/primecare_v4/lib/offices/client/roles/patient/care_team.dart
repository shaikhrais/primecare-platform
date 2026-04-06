import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PatientCareTeamScreen extends ConsumerWidget {
  const PatientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'My Care Team',
      subtitle: 'The professionals dedicated to your wellbeing',
      icon: LucideIcons.users,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.search),
          onPressed: () {},
          tooltip: 'Search directory',
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Emergency / After Hours Banner
            Container(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              decoration: BoxDecoration(
                color: PrimeCareTheme.errorContainer,
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.phoneCall, color: PrimeCareTheme.error),
                  ),
                  const SizedBox(width: PrimeCareTheme.spacing4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need immediate assistance?', style: PrimeCareTheme.titleMedium.copyWith(color: PrimeCareTheme.onErrorContainer)),
                        Text('For emergencies, please call 911. For urgent, after-hours care, call our on-call line at 1-800-555-1234.', style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onErrorContainer)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Care Team Grid
            Text('Primary Team', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: PrimeCareTheme.spacing4,
              mainAxisSpacing: PrimeCareTheme.spacing4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTeamMemberCard(
                  name: 'Dr. Emily Chen',
                  role: 'Primary Care Physician',
                  avatarColor: PrimeCareTheme.primaryContainer,
                  avatarInitials: 'EC',
                  isLead: true,
                ),
                _buildTeamMemberCard(
                  name: 'Mark Davies',
                  role: 'Registered Nurse',
                  avatarColor: PrimeCareTheme.secondaryContainer,
                  avatarInitials: 'MD',
                  isLead: false,
                ),
                _buildTeamMemberCard(
                  name: 'Sarah Smith',
                  role: 'Physiotherapist',
                  avatarColor: PrimeCareTheme.tertiaryContainer,
                  avatarInitials: 'SS',
                  isLead: false,
                ),
                _buildTeamMemberCard(
                  name: 'Michael Chang',
                  role: 'Dietitian',
                  avatarColor: PrimeCareTheme.surfaceContainerHigh,
                  avatarInitials: 'MC',
                  isLead: false,
                ),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Specialists Section
            Text('Specialists & Referrals', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            _buildSpecialistRow('Dr. Nora Adams', 'Cardiology', 'Last seen: Oct 2, 2026'),
            const SizedBox(height: PrimeCareTheme.spacing3),
            _buildSpecialistRow('Dr. Robert Klein', 'Dermatology', 'Last seen: Jul 15, 2026'),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String role,
    required Color avatarColor,
    required String avatarInitials,
    required bool isLead,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: avatarColor,
                child: Text(
                  avatarInitials,
                  style: PrimeCareTheme.titleLarge.copyWith(
                    color: PrimeCareTheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isLead)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: PrimeCareTheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.star, size: 12, color: PrimeCareTheme.onTertiary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          Text(name, style: PrimeCareTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: PrimeCareTheme.spacing1),
          Text(
            role,
            style: PrimeCareTheme.labelMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PrimeCareTheme.spacing5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(LucideIcons.messageSquare, 'Message'),
              _buildActionButton(LucideIcons.calendarPlus, 'Book'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String tooltip) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: PrimeCareTheme.primary),
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: PrimeCareTheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd)),
      ),
    );
  }

  Widget _buildSpecialistRow(String name, String specialty, String lastSeen) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: PrimeCareTheme.primary.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
             radius: 20,
             backgroundColor: PrimeCareTheme.surfaceContainerHigh,
             child: Icon(LucideIcons.user, color: PrimeCareTheme.onSurfaceVariant),
          ),
          const SizedBox(width: PrimeCareTheme.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.titleMedium),
                Text('$specialty • $lastSeen', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Message', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
          )
        ],
      ),
    );
  }
}
