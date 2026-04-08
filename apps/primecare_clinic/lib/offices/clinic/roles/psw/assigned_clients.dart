import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswAssignedClientsScreen extends ConsumerWidget {
  const PswAssignedClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Assigned Clients',
      subtitle: 'View your regular clients and key care plan highlights.',
      kpiCards: [
        KPICardData(
          title: 'Total Active',
          value: '12',
          icon: LucideIcons.users,
          trend: 0.0,
          trendLabel: 'this week',
        ),
        KPICardData(
          title: 'High Acuity',
          value: '3',
          icon: LucideIcons.alertCircle,
          trend: 0.0,
          trendLabel: 'requires attention',
        ),
        KPICardData(
          title: 'New Intakes',
          value: '1',
          icon: LucideIcons.userPlus,
          trend: 0.0,
          trendLabel: 'last 7 days',
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
                  Text('Client Directory', style: PrimeCareTheme.typography.h2),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search clients...',
                        prefixIcon: const Icon(LucideIcons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color:
                                PrimeCareTheme.colors.surfaceContainerHighest,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 1200
                    ? 3
                    : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildClientCard(
                    'Sonia Sotomayor',
                    'Dementia Care',
                    'High Fall Risk',
                    PrimeCareTheme.colors.brickRed,
                  ),
                  _buildClientCard(
                    'Thurgood Marshall',
                    'Post-Op Recovery',
                    'Mobility Assist',
                    PrimeCareTheme.colors.emeraldTeal,
                  ),
                  _buildClientCard(
                    'Elena Kagan',
                    'Companionship',
                    'Low Risk',
                    PrimeCareTheme.colors.slateGray,
                  ),
                  _buildClientCard(
                    'Ruth Bader Ginsburg',
                    'Hospice Support',
                    'Bedbound',
                    PrimeCareTheme.colors.navyIndigo,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClientCard(
    String name,
    String careType,
    String riskLevel,
    Color riskColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(
                  0.1,
                ),
                radius: 24,
                child: Text(
                  name.split(' ').map((e) => e[0]).take(2).join(),
                  style: TextStyle(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: PrimeCareTheme.typography.h3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      careType,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.alertTriangle, size: 14, color: riskColor),
                const SizedBox(width: 6),
                Text(
                  riskLevel,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: riskColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
