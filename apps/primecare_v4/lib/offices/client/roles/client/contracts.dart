import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ClientContractsScreen extends ConsumerWidget {
  const ClientContractsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Contracts & Agreements',
      subtitle: 'Review service parameters and manage legal agreements',
      icon: LucideIcons.fileSignature,
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.mail, size: 18),
          label: const Text('Contact Billing'),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pending Action Banner (if any)
            Container(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              decoration: BoxDecoration(
                color: PrimeCareTheme.secondaryContainer,
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: PrimeCareTheme.secondary.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: PrimeCareTheme.onSecondaryContainer
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.penTool,
                          color: PrimeCareTheme.onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Signature Required',
                            style: PrimeCareTheme.titleMedium.copyWith(
                              color: PrimeCareTheme.onSecondaryContainer,
                            ),
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing1),
                          Text(
                            'Annual Rate Adjustment Agreement 2027',
                            style: PrimeCareTheme.bodyMedium.copyWith(
                              color: PrimeCareTheme.onSecondaryContainer
                                  .withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.onSecondaryContainer,
                      foregroundColor: PrimeCareTheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          PrimeCareTheme.radiusLg,
                        ),
                      ),
                    ),
                    child: const Text('Review & Sign'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Summary Metrics
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    'Active Agreements',
                    '3',
                    LucideIcons.fileCheck,
                    PrimeCareTheme.primary,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildMetricCard(
                    'Total Authorized Hours',
                    '120 / month',
                    LucideIcons.clock,
                    PrimeCareTheme.tertiary,
                  ),
                ),
                const SizedBox(width: PrimeCareTheme.spacing4),
                Expanded(
                  child: _buildMetricCard(
                    'Next Renewal',
                    'Jan 15, 2027',
                    LucideIcons.calendarDays,
                    PrimeCareTheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Active Contracts List
            Text('Active Service Agreements', style: PrimeCareTheme.titleLarge),
            const SizedBox(height: PrimeCareTheme.spacing4),
            _buildContractDetailCard(
              title: 'Comprehensive Nursing Care',
              patient: 'Eleanor M.',
              status: 'Active',
              statusColor: PrimeCareTheme.primary,
              details: [
                {
                  'label': 'Service Provider',
                  'value': 'PrimeCare Nursing Division',
                },
                {'label': 'Frequency', 'value': '3x Weekly / 4 hr sessions'},
                {'label': 'Rate', 'value': '\$85.00 / hr'},
                {'label': 'Term Ends', 'value': 'Dec 31, 2026'},
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing4),
            _buildContractDetailCard(
              title: 'Post-Op Physiotherapy',
              patient: 'Eleanor M.',
              status: 'Active',
              statusColor: PrimeCareTheme.primary,
              details: [
                {'label': 'Service Provider', 'value': 'PrimeCare Rehab Staff'},
                {'label': 'Frequency', 'value': 'As scheduled (Max 10 / mo)'},
                {'label': 'Rate', 'value': '\$120.00 / session'},
                {'label': 'Term Ends', 'value': 'Nov 30, 2026'},
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing6),

            // Past/Expired
            Text(
              'Past Agreements',
              style: PrimeCareTheme.titleMedium.copyWith(
                color: PrimeCareTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: PrimeCareTheme.spacing4),
            _buildExpiredContractRow(
              'Temporary Support Worker',
              'Arthur M.',
              'Expired Sep 2026',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: 24),
          const SizedBox(height: PrimeCareTheme.spacing3),
          Text(
            title,
            style: PrimeCareTheme.labelMedium.copyWith(
              color: PrimeCareTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing1),
          Text(
            value,
            style: PrimeCareTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractDetailCard({
    required String title,
    required String patient,
    required String status,
    required Color statusColor,
    required List<Map<String, String>> details,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: PrimeCareTheme.primary.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(PrimeCareTheme.spacing6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.surfaceContainerHigh.withOpacity(
                          0.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.fileText,
                        color: PrimeCareTheme.primary,
                      ),
                    ),
                    const SizedBox(width: PrimeCareTheme.spacing4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: PrimeCareTheme.titleMedium),
                        Text(
                          'Patient: $patient',
                          style: PrimeCareTheme.labelMedium.copyWith(
                            color: PrimeCareTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
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
            const SizedBox(height: PrimeCareTheme.spacing5),
            Divider(
              color: PrimeCareTheme.surfaceContainerHighest.withOpacity(0.5),
            ),
            const SizedBox(height: PrimeCareTheme.spacing5),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    details[0]['label']!,
                    details[0]['value']!,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    details[1]['label']!,
                    details[1]['value']!,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    details[2]['label']!,
                    details[2]['value']!,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    details[3]['label']!,
                    details[3]['value']!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: PrimeCareTheme.spacing5),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.download, size: 16),
                label: const Text('Download PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: PrimeCareTheme.labelSmall.copyWith(
            color: PrimeCareTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: PrimeCareTheme.spacing1),
        Text(
          value,
          style: PrimeCareTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiredContractRow(String title, String patient, String status) {
    return Container(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.3),
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.fileArchive,
                size: 20,
                color: PrimeCareTheme.onSurfaceVariant,
              ),
              const SizedBox(width: PrimeCareTheme.spacing3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: PrimeCareTheme.titleSmall.copyWith(
                      color: PrimeCareTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'Patient: $patient',
                    style: PrimeCareTheme.labelSmall.copyWith(
                      color: PrimeCareTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            status,
            style: PrimeCareTheme.labelSmall.copyWith(
              color: PrimeCareTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
