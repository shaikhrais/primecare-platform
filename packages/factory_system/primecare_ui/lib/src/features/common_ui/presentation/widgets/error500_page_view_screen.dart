// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/routes/safe_navigation.dart';

class Error500PageViewScreen extends ConsumerWidget {
  final dynamic data;

  Error500PageViewScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimeCareScaffold(
      title: LocaleKeys.dashboards_common_labels_internal_server_error.tr(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.theme.colors.background,
              context.theme.colors.background.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // premium glowing icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.colors.error.withValues(alpha: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: context.theme.colors.error.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.shieldAlert,
                  size: 84,
                  color: context.theme.colors.error,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Critical System Interruption',
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'The self-healing registry has detected a hydration failure in a critical component. Our systems are actively rerouting services to maintain stability.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.theme.colors.slateGray.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.goSafe(AppRoute(CommonRoutes.clinicDashboard)),
                    icon: Icon(LucideIcons.home),
                    label: Text(LocaleKeys.dashboards_common_labels_return_to_safety.tr(),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                      backgroundColor: context.theme.colors.primary,
                      foregroundColor: context.theme.colors.surface,
                    ),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Trigger manual telemetry ping
                    },
                    icon: Icon(LucideIcons.refreshCw),
                    label: Text(LocaleKeys.dashboards_common_labels_retry_hydration.tr(),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
