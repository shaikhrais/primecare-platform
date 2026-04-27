// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_ui/src/screens/dashboards/compliance/export_reports_dialog.dart';

class ComplianceManagerDashboard extends ConsumerWidget {
  ComplianceManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(complianceManagerDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_compliance_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regulatory_compliance_and_audit_overview
          .tr(),
      actions: [
        PrimeCareButton(
          onPressed: () => ExportReportsDialog.show(context),
          text: 'Export Reports',
          icon: Icons.download_rounded,
          isPrimary: true,
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => PrimeCareResponsiveKpiGrid(
            children: data.kpis
                .map(
                  (kpi) => PrimeCareKpiCard(
                    title: kpi.title,
                    value: kpi.value,
                    subtitle: kpi.subtitle ?? '',
                    icon: _getIconForMetric(kpi.title),
                    onPinToggle: () {},
                  ),
                )
                .toList(),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient')) return Icons.people_outline;
    if (t.contains('claim') || t.contains('revenue') || t.contains('price'))
      return Icons.payments_outlined;
    if (t.contains('staff') || t.contains('capacity'))
      return Icons.badge_outlined;
    if (t.contains('alert') || t.contains('incident'))
      return Icons.notification_important_outlined;
    if (t.contains('task') || t.contains('todo'))
      return Icons.assignment_outlined;
    if (t.contains('message') || t.contains('chat'))
      return Icons.forum_outlined;
    if (t.contains('file') || t.contains('doc') || t.contains('vault'))
      return Icons.inventory_2_outlined;
    return Icons.analytics_outlined;
  }
}
