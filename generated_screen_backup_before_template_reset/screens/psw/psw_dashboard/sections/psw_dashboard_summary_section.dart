import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardSummarySection extends ConsumerWidget {
  const PswDashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenProvider);
    final theme = context.theme;

    return Cy(
      id: 'section-psw_dashboard_summary',
      child: Cy(
        id: 'psw-shift-status-card',
        child: PrimeCareCard(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      state.isShiftActive ? LucideIcons.playCircle : LucideIcons.stopCircle,
                      color: state.isShiftActive ? theme.colors.success : theme.colors.onSurfaceVariant,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      state.isShiftActive ? 'Shift is Active'.tr() : 'No Active Shift'.tr(),
                      style: theme.typography.h4,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Active Session Logs and Operations tracking is active in this environment.'.tr(),
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
