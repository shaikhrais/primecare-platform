import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardHeaderSection extends ConsumerWidget {
  const PswDashboardHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenProvider);
    final theme = context.theme;

    return Cy(
      id: 'section-psw_dashboard_header',
      child: Cy(
        id: 'psw_dashboard-title',
        child: Text(
          key: const Key('psw_dashboard-title'),
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
    );
  }
}
