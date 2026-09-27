import 'package:primecare_ui/primecare_ui.dart';
import '../psw_dashboard_controller.dart';

class PswDashboardActionsSection extends ConsumerWidget {
  const PswDashboardActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenProvider);
    final controller = ref.read(pswDashboardScreenProvider.notifier);
    final theme = context.theme;

    return Cy(
      id: 'section-psw_dashboard_actions',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Required Emergency Button
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Cy(
                id: 'pswdashboard-btn-emergency',
                child: ElevatedButton(
                  key: const Key('pswdashboard-btn-emergency'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => controller.addLog('EMERGENCY TRIGGERED: Care coordinator dispatched.'),
                  child: Text('Emergency Action'.tr(), style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),

          // Clock In / Clock Out Button
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Cy(
                id: 'psw-start-shift-btn',
                child: ElevatedButton.icon(
                  key: const Key('psw-start-shift-btn'),
                  icon: Icon(state.isShiftActive ? LucideIcons.logOut : LucideIcons.logIn),
                  label: Text(state.isShiftActive ? 'Clock Out'.tr() : 'Clock In'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isShiftActive ? theme.colors.error : theme.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => controller.toggleShift(),
                ),
              ),
            ),
          ),

          // Log Vitals Button
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Cy(
                id: 'psw-view-vitals-btn',
                child: ElevatedButton.icon(
                  key: const Key('psw-view-vitals-btn'),
                  icon: const Icon(LucideIcons.heart),
                  label: Text('Log Vitals'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        final sysController = TextEditingController();
                        final diaController = TextEditingController();
                        final pulseController = TextEditingController();
                        return AlertDialog(
                          title: Text('Log Client Vitals'.tr()),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: sysController,
                                decoration: const InputDecoration(labelText: 'Systolic BP (mmHg)'),
                                keyboardType: TextInputType.number,
                              ),
                              TextField(
                                controller: diaController,
                                decoration: const InputDecoration(labelText: 'Diastolic BP (mmHg)'),
                                keyboardType: TextInputType.number,
                              ),
                              TextField(
                                controller: pulseController,
                                decoration: const InputDecoration(labelText: 'Pulse (bpm)'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel'.tr()),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.logVitals(
                                  sysController.text,
                                  diaController.text,
                                  pulseController.text,
                                );
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'.tr()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // Report Incident Button
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Cy(
                id: 'psw-report-incident-btn',
                child: ElevatedButton.icon(
                  key: const Key('psw-report-incident-btn'),
                  icon: const Icon(LucideIcons.alertTriangle),
                  label: Text('Report Incident'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.warning,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        final detailsController = TextEditingController();
                        return AlertDialog(
                          title: Text('Report Security/Care Incident'.tr()),
                          content: TextField(
                            controller: detailsController,
                            decoration: const InputDecoration(labelText: 'Incident details...'),
                            maxLines: 3,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel'.tr()),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.reportIncident(detailsController.text);
                                Navigator.of(context).pop();
                              },
                              child: Text('Submit Report'.tr()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
