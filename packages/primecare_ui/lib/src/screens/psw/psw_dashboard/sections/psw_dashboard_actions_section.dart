import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardActionsSection extends StatelessWidget {
  const PswDashboardActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    Widget unavailable(String id, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Cy(
          id: id,
          child: ElevatedButton(
            key: Key(id),
            onPressed: null,
            child: Text(title.tr()),
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
          const SizedBox(height: 12),
          unavailable('pswdashboard-btn-emergency', 'Emergency Action'),
          Text('This screen cannot save shifts, incidents, or vitals.'.tr()),
          const SizedBox(height: 12),
          unavailable('psw-start-shift-btn', 'Clock In / Out'),
          unavailable('psw-view-vitals-btn', 'Log Vitals'),
          unavailable('psw-report-incident-btn', 'Report Incident'),
        ],
      ),
    );
  }
}
