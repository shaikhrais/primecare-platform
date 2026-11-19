import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardSummarySection extends StatelessWidget {
  const PswDashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Cy(
      id: 'section-psw_dashboard_summary',
      child: Cy(
        id: 'psw-shift-status-card',
        child: PrimeCareCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Shift status unavailable'.tr(),
              style: theme.typography.h4,
            ),
          ),
        ),
      ),
    );
  }
}
