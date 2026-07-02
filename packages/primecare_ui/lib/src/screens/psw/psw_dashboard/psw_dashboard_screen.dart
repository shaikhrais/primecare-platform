/* 
PRIME:SCREEN=psw_dashboard
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_CONNECTED
PRIME:VALIDATION=VALIDATION_DONE
PRIME:QA=QA_STARTED
PRIME:FINAL=FINAL_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the PswDashboardScreen workspace interface with active databinding and interactive workflows.
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_dashboard_header_section.dart';
import 'sections/psw_dashboard_summary_section.dart';
import 'sections/psw_dashboard_actions_section.dart';
import 'sections/psw_dashboard_data_list_section.dart';

export 'psw_dashboard_controller.dart';

class PswDashboardScreen extends GovernedConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenProvider);
    final theme = context.theme;

    return Cy(
      id: 'psw_dashboard-screen',
      child: Scaffold(
        key: const Key('psw_dashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: const PswDashboardHeaderSection(),
          actions: [
            IconButton(
              key: const Key('psw_dashboard-refresh-btn'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => ref.read(pswDashboardScreenProvider.notifier).refreshData(),
            ),
          ],
        ),
        body: Cy(
          id: 'psw_dashboard-content',
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Operational Status'.tr(),
                value: state.isShiftActive ? 'ACTIVE'.tr() : 'OFF DUTY'.tr(),
                trendLabel: 'Shift Tracking'.tr(),
                progress: state.isShiftActive ? state.shiftProgress : 0.0,
                icon: LucideIcons.activity,
                brandColor: state.isShiftActive ? const Color(0xFF0D9488) : Colors.grey,
              ),
              GovMetricCard(
                title: 'Completed Tasks'.tr(),
                value: '${state.tasks.where((t) => t.isCompleted).length}/${state.tasks.length}',
                trendLabel: 'Today Progress'.tr(),
                progress: state.tasks.isEmpty ? 0.0 : state.tasks.where((t) => t.isCompleted).length / state.tasks.length,
                icon: LucideIcons.checkCircle2,
                brandColor: const Color(0xFF0284C7),
              ),
            ],
            mainContent: const PswDashboardDataListSection(),
            defaultSidebarWidgets: [
              const PswDashboardSummarySection(),
              const PswDashboardActionsSection(),
              // Operational logs panel
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Operational Action Logs'.tr(), style: theme.typography.h4.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 12),
                    ...state.logs.map((log) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ', style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                          Expanded(child: Text(log.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant))),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
