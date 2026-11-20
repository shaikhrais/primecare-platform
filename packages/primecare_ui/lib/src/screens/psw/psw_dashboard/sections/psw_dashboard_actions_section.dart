import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardActionsSection extends StatelessWidget {
  const PswDashboardActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    Widget unavailable(String id, String title) => Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.cardGap),
      child: SizedBox(
        width: double.infinity,
        height: theme.spacing.xxl,
        child: Cy(
          id: id,
          child: PrimeButton(
            key: Key(id),
            onPressed: null,
            isFullWidth: true,
            label: title.tr(),
          ),
        ),
      ),
    );

    return Cy(
      id: 'section-psw_dashboard_actions',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            liveRegion: true,
            child: Text(
              'Emergency dispatch is not connected here. Use your workplace emergency procedure.'
                  .tr(),
            ),
          ),
          SizedBox(height: theme.spacing.cardGap),
          unavailable('pswdashboard-btn-emergency', 'Emergency Action'),
          Text('This screen cannot save shifts, incidents, or vitals.'.tr()),
          SizedBox(height: theme.spacing.cardGap),
          unavailable('psw-start-shift-btn', 'Clock In / Out'),
          unavailable('psw-view-vitals-btn', 'Log Vitals'),
          unavailable('psw-report-incident-btn', 'Report Incident'),
        ],
      ),
    );
  }
}
