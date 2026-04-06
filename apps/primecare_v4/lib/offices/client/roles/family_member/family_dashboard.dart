import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class FamilyDashboardScreen extends ConsumerWidget {
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Family Portal',
      subtitle: 'Monitoring Eleanor\'s Care Journey',
      icon: LucideIcons.heart,
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
            // Loved One Status Hero Card
            Container(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
              decoration: BoxDecoration(
                color: PrimeCareTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: PrimeCareTheme.primary.withOpacity(0.04),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  )
                ],
              ),
              child: Stack(
                children: [
                   // Atelier Glow Array
                   Positioned(
                     top: -50,
                     right: -50,
                     child: Container(
                       width: 150,
                       height: 150,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         gradient: RadialGradient(
                           colors: [
                             PrimeCareTheme.tertiary.withOpacity(0.2),
                             Colors.transparent,
                           ],
                         ),
                       ),
                     ),
                   ),
                   Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: PrimeCareTheme.surfaceContainerHighest,
                        child: Text(
                           'EM',
                           style: PrimeCareTheme.displaySmall.copyWith(color: PrimeCareTheme.onSurfaceVariant),
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Eleanor M.', style: PrimeCareTheme.displaySmall),
                            const SizedBox(height: PrimeCareTheme.spacing2),
                            Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                               decoration: BoxDecoration(
                                 color: PrimeCareTheme.tertiaryContainer,
                                 borderRadius: BorderRadius.circular(PrimeCareTheme.radiusFull),
                               ),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Icon(LucideIcons.smile, size: 16, color: PrimeCareTheme.onTertiaryContainer),
                                   const SizedBox(width: 8),
                                   Text('Resting Comfortably', style: PrimeCareTheme.labelMedium.copyWith(color: PrimeCareTheme.onTertiaryContainer, fontWeight: FontWeight.bold)),
                                 ],
                               ),
                            ),
                          ],
                        ),
                      ),
                      // Key Metric
                      Container(
                         padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
                         decoration: BoxDecoration(
                           color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.3),
                           borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
                         ),
                         child: Column(
                           children: [
                             Text('Last Update', style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                             const SizedBox(height: PrimeCareTheme.spacing1),
                             Text('20 mins ago', style: PrimeCareTheme.titleMedium),
                           ],
                         ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Today's Focus
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
                         Text('Today\'s Team & Schedule', style: PrimeCareTheme.titleLarge),
                         const SizedBox(height: PrimeCareTheme.spacing4),
                         _buildScheduleItem('Morning Medication', '09:00 AM', LucideIcons.pill, PrimeCareTheme.tertiary, true),
                         const SizedBox(height: PrimeCareTheme.spacing3),
                         _buildScheduleItem('Physical Therapy with Sarah Smith', '02:00 PM', LucideIcons.activity, PrimeCareTheme.primary, false),
                         const SizedBox(height: PrimeCareTheme.spacing3),
                         _buildScheduleItem('Evening Check-in with Mark Davies', '08:00 PM', LucideIcons.moon, PrimeCareTheme.secondary, false),
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
                        Text('Recent Care Updates', style: PrimeCareTheme.titleLarge),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        _buildUpdateItem('Nurse Mark', 'Vitals are stable. Eleanor ate a full breakfast.'),
                        const SizedBox(height: PrimeCareTheme.spacing3),
                        _buildUpdateItem('PT Sarah', 'Great progress on mobility exercises today!'),
                        const SizedBox(height: PrimeCareTheme.spacing5),
                        TextButton(
                           onPressed: () {},
                           child: Text('View Full History', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Quick Actions 
            Text('Family Actions', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            Row(
              children: [
                Expanded(child: _buildQuickAction(LucideIcons.messageSquare, 'Message Care Team', PrimeCareTheme.primaryFixed)),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(child: _buildQuickAction(LucideIcons.fileText, 'Review Care Plan', PrimeCareTheme.secondaryFixed)),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(child: _buildQuickAction(LucideIcons.image, 'Share Photos', PrimeCareTheme.tertiaryFixed)),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(child: _buildQuickAction(LucideIcons.users, 'Manage Permissions', PrimeCareTheme.surfaceContainerHigh)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String title, String time, IconData icon, Color color, bool completed) {
     return Container(
       padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
       decoration: BoxDecoration(
          color: completed ? PrimeCareTheme.surfaceContainerLowest : PrimeCareTheme.surfaceContainerHigh.withOpacity(0.3),
          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd),
       ),
       child: Row(
         children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                 color: completed ? color.withOpacity(0.1) : PrimeCareTheme.surfaceContainerLow,
                 shape: BoxShape.circle,
              ),
              child: Icon(completed ? LucideIcons.checkCircle2 : icon, color: completed ? color : PrimeCareTheme.onSurfaceVariant, size: 20),
            ),
            const SizedBox(width: PrimeCareTheme.spacing4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PrimeCareTheme.titleSmall.copyWith(
                     decoration: completed ? TextDecoration.lineThrough : null,
                     color: completed ? PrimeCareTheme.onSurfaceVariant : PrimeCareTheme.onSurface,
                  )),
                  Text(time, style: PrimeCareTheme.labelSmall.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                ],
              ),
            )
         ],
       ),
     );
  }

  Widget _buildUpdateItem(String sender, String message) {
    return Container(
      padding: const EdgeInsets.only(left: PrimeCareTheme.spacing3),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: PrimeCareTheme.primaryContainer, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.onSurfaceVariant),
               const SizedBox(width: 4),
               Text(sender, style: PrimeCareTheme.labelMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing1),
          Text(message, style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: PrimeCareTheme.onSurface),
          const SizedBox(height: PrimeCareTheme.spacing3),
          Text(label, style: PrimeCareTheme.titleSmall.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
