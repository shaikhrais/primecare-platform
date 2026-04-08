import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ClientDashboardScreen extends ConsumerWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Client Portal',
      subtitle: 'Account Management & Service Oversight',
      icon: LucideIcons.building,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.settings),
          onPressed: () {},
          tooltip: 'Account Settings',
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Financial Hero Banner
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
                          'Current Account Balance',
                          style: PrimeCareTheme.titleMedium.copyWith(
                            color: PrimeCareTheme.onPrimaryContainer
                                .withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing2),
                        Text(
                          '\$450.00',
                          style: PrimeCareTheme.displayMedium.copyWith(
                            color: PrimeCareTheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: PrimeCareTheme.spacing4),
                        Row(
                          children: [
                            Text(
                              'Due: Oct 15, 2026',
                              style: PrimeCareTheme.labelLarge.copyWith(
                                color: PrimeCareTheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: PrimeCareTheme.spacing4),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                LucideIcons.creditCard,
                                size: 16,
                              ),
                              label: const Text('Make Payment'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PrimeCareTheme.onPrimary,
                                foregroundColor: PrimeCareTheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PrimeCareTheme.spacing4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    PrimeCareTheme.radiusLg,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: PrimeCareTheme.spacing6),
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
                              LucideIcons.shieldCheck,
                              color: PrimeCareTheme.primary,
                            ),
                          ),
                          const SizedBox(width: PrimeCareTheme.spacing4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Insurance Status',
                                  style: PrimeCareTheme.titleSmall.copyWith(
                                    color: PrimeCareTheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'Verified • BlueCross',
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

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    LucideIcons.receipt,
                    'View Invoices',
                    PrimeCareTheme.primaryFixed,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildQuickAction(
                    LucideIcons.fileSignature,
                    'Agreements',
                    PrimeCareTheme.secondaryFixed,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildQuickAction(
                    LucideIcons.users,
                    'Dependents',
                    PrimeCareTheme.tertiaryFixed,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildQuickAction(
                    LucideIcons.fileClock,
                    'Tax Receipts',
                    PrimeCareTheme.surfaceContainerHigh,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Active Contracts / Services
            Text('Active Service Agreements', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildContractCard(
                    'Nursing Care - Eleanor M.',
                    'Registered Nursing • 3x Weekly',
                    'Active through Dec 2026',
                    true,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildContractCard(
                    'Physiotherapy - Eleanor M.',
                    'Post-Op Rehab',
                    'Active through Nov 2026',
                    true,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildContractCard(
                    'Personal Support - Arthur M.',
                    'Daily Assistance',
                    'Pending Renewal',
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
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: PrimeCareTheme.onSurface),
          const SizedBox(height: PrimeCareTheme.spacing2),
          Text(
            label,
            style: PrimeCareTheme.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractCard(
    String title,
    String subtitle,
    String status,
    bool isActive,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.fileText,
                  color: PrimeCareTheme.primary,
                  size: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? PrimeCareTheme.primaryContainer
                      : PrimeCareTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isActive ? 'Active' : 'Pending',
                  style: PrimeCareTheme.labelSmall.copyWith(
                    color: isActive
                        ? PrimeCareTheme.primary
                        : PrimeCareTheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          Text(title, style: PrimeCareTheme.titleMedium),
          const SizedBox(height: PrimeCareTheme.spacing1),
          Text(
            subtitle,
            style: PrimeCareTheme.bodyMedium.copyWith(
              color: PrimeCareTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          Text(
            status,
            style: PrimeCareTheme.labelMedium.copyWith(
              color: PrimeCareTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing4),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'View Details',
              style: PrimeCareTheme.titleSmall.copyWith(
                color: PrimeCareTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
