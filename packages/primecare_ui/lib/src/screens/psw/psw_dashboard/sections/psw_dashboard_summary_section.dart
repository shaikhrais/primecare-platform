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
            padding: EdgeInsets.all(theme.spacing.md),
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
