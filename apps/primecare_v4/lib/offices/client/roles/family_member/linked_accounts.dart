import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class FamilyLinkedAccountsScreen extends ConsumerWidget {
  const FamilyLinkedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Linked Accounts & Privacy',
      subtitle: 'Manage who has access to Eleanor\'s care data',
      icon: LucideIcons.shieldCheck,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.primaryContainer,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
          ),
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing5, vertical: PrimeCareTheme.spacing3),
            ),
            icon: const Icon(LucideIcons.userPlus, color: PrimeCareTheme.primary),
            label: Text('Invite Member', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             // Privacy Banner
             Container(
               padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
               decoration: BoxDecoration(
                 color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.4),
                 borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                 border: Border.all(color: PrimeCareTheme.primary.withOpacity(0.3), width: 1.5),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    Row(
                      children: [
                         Container(
                           padding: const EdgeInsets.all(12),
                           decoration: BoxDecoration(
                             color: PrimeCareTheme.primary.withOpacity(0.1),
                             shape: BoxShape.circle,
                           ),
                           child: const Icon(LucideIcons.lock, color: PrimeCareTheme.primary),
                         ),
                         const SizedBox(width: PrimeCareTheme.spacing4),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Text('Protected Health Information', style: PrimeCareTheme.titleMedium),
                              const SizedBox(height: PrimeCareTheme.spacing1),
                              Text('All data sharing complies with strict HIPAA/PHIPA regulations.', style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                           ],
                         )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Learn More', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
                    )
                 ],
               ),
             ),
             const SizedBox(height: PrimeCareTheme.spacing6),

             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Left side: Active Links
                 Expanded(
                   flex: 6,
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Authorized Access', style: PrimeCareTheme.titleLarge),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildAccessCard(
                           name: 'Arthur M.',
                           relation: 'Primary Contact (Spouse)',
                           accessLevel: 'Full Access',
                           email: 'arthur.m***@gmail.com',
                           isSelf: true,
                           avatarColor: PrimeCareTheme.primaryContainer,
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildAccessCard(
                           name: 'Elizabeth K.',
                           relation: 'Daughter',
                           accessLevel: 'View Only (Schedules & Vitals)',
                           email: 'lizzy.k***@gmail.com',
                           isSelf: false,
                           avatarColor: PrimeCareTheme.tertiaryContainer,
                        ),
                      ],
                   ),
                 ),
                 const SizedBox(width: PrimeCareTheme.spacing6),
                 
                 // Right side: Pending Invites & Audit
                 Expanded(
                   flex: 4,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Pending Invitations', style: PrimeCareTheme.titleLarge),
                       const SizedBox(height: PrimeCareTheme.spacing4),
                       _buildPendingInviteRow('Robert M.', 'Son', 'Sent Oct 2, 2026'),
                       const SizedBox(height: PrimeCareTheme.spacing6),
                       
                       Text('Recent Access Logs', style: PrimeCareTheme.titleLarge),
                       const SizedBox(height: PrimeCareTheme.spacing4),
                       ClinicalGlassPanel(
                         padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
                         child: Column(
                           children: [
                              _buildAuditLogRow('Elizabeth K. viewed care schedule.', '2 hrs ago'),
                              const Divider(),
                              _buildAuditLogRow('Arthur M. reviewed clinical notes.', 'Yesterday'),
                              const SizedBox(height: PrimeCareTheme.spacing3),
                              TextButton(
                                onPressed: () {},
                                child: Text('View Complete Audit Log', style: PrimeCareTheme.labelLarge.copyWith(color: PrimeCareTheme.primary)),
                              )
                           ],
                         ),
                       )
                     ],
                   ),
                 )
               ],
             )
          ],
        ),
      ),
    );
  }

  Widget _buildAccessCard({
    required String name,
    required String relation,
    required String accessLevel,
    required String email,
    required bool isSelf,
    required Color avatarColor,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: avatarColor,
                      child: Text(name[0], style: PrimeCareTheme.titleMedium.copyWith(color: PrimeCareTheme.onSurface)),
                    ),
                    const SizedBox(width: PrimeCareTheme.spacing4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Text(name, style: PrimeCareTheme.titleLarge),
                             if (isSelf) ...[
                               const SizedBox(width: PrimeCareTheme.spacing2),
                               Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                 decoration: BoxDecoration(
                                    color: PrimeCareTheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(4),
                                 ),
                                 child: Text('You', style: PrimeCareTheme.labelSmall),
                               )
                             ]
                          ],
                        ),
                        Text(relation, style: PrimeCareTheme.labelMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
                if (!isSelf)
                  PopupMenuButton(
                    icon: const Icon(LucideIcons.moreVertical, color: PrimeCareTheme.onSurfaceVariant),
                    itemBuilder: (context) => [
                       const PopupMenuItem(child: Text('Edit Access Level')),
                       const PopupMenuItem(child: Text('Revoke Access', style: TextStyle(color: PrimeCareTheme.error))),
                    ],
                  )
             ],
           ),
           const SizedBox(height: PrimeCareTheme.spacing5),
           Container(
             padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
             decoration: BoxDecoration(
                color: PrimeCareTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     const Icon(LucideIcons.key, size: 16, color: PrimeCareTheme.primary),
                     const SizedBox(width: PrimeCareTheme.spacing2),
                     Text('Access Level:', style: PrimeCareTheme.labelMedium),
                   ],
                 ),
                 Text(accessLevel, style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
               ],
             ),
           ),
           const SizedBox(height: PrimeCareTheme.spacing4),
           Row(
             children: [
               const Icon(LucideIcons.mail, size: 16, color: PrimeCareTheme.onSurfaceVariant),
               const SizedBox(width: PrimeCareTheme.spacing2),
               Text(email, style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
             ],
           )
        ],
      ),
    );
  }

  Widget _buildPendingInviteRow(String name, String relation, String status) {
     return ClinicalGlassPanel(
       padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               Container(
                 padding: const EdgeInsets.all(8),
                 decoration: const BoxDecoration(
                   color: PrimeCareTheme.surfaceContainerHigh,
                   shape: BoxShape.circle,
                 ),
                 child: const Icon(LucideIcons.clock, size: 16, color: PrimeCareTheme.onSurfaceVariant),
               ),
               const SizedBox(width: PrimeCareTheme.spacing3),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(name, style: PrimeCareTheme.titleMedium),
                   Text('$relation • $status', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                 ],
               ),
             ],
           ),
           TextButton(
             onPressed: () {},
             child: Text('Resend', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
           )
         ],
       ),
     );
  }

  Widget _buildAuditLogRow(String log, String time) {
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing2),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             margin: const EdgeInsets.only(top: 4),
             width: 6,
             height: 6,
             decoration: const BoxDecoration(
               color: PrimeCareTheme.primaryContainer,
               shape: BoxShape.circle,
             ),
           ),
           const SizedBox(width: PrimeCareTheme.spacing3),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(log, style: PrimeCareTheme.bodyMedium),
                 Text(time, style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
               ],
             ),
           )
         ],
       ),
     );
  }
}
