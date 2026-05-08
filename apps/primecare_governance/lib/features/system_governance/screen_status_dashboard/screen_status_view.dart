import 'package:primecare_ui/primecare_ui.dart';
import 'screen_status_controller.dart';

class ScreenStatusView extends GovernedConsumerWidget {
  const ScreenStatusView({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(screenStatusControllerProvider);

    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: theme.colors.primary),
      );
    }

    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          style: theme.typography.bodyLarge.copyWith(color: theme.colors.error),
        ),
      );
    }

    if (state.statusData == null) {
      return Center(child: Text('governance.screen_status.no_data'.tr()));
    }

    final summary = state.statusData!['summary'] as Map<String, dynamic>;
    final byApp = state.statusData!['byApp'] as Map<String, dynamic>;
    final screens = state.statusData!['screens'] as List<dynamic>? ?? [];

    return Container(
      color: theme.colors.surfaceContainerLowest,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'governance.screen_status.overall_summary'.tr(),
              style: theme.typography.h2,
            ),
            const SizedBox(height: 16),
            _buildSummaryCards(theme, summary),
            const SizedBox(height: 32),
            Text(
              'governance.screen_status.app_breakdown'.tr(),
              style: theme.typography.h2,
            ),
            const SizedBox(height: 16),
            _buildAppBreakdownGrid(theme, byApp),
            const SizedBox(height: 32),
            Text(
              '${'governance.screen_status.detailed_screen_list'.tr()} (${screens.length})',
              style: theme.typography.h2,
            ),
            const SizedBox(height: 16),
            _buildScreenList(theme, screens),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(
    PrimeThemeData theme,
    Map<String, dynamic> summary,
  ) {
    return GridView.extent(
      maxCrossAxisExtent: 280,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.0,
      children: [
        _buildStatCard(
          theme,
          'governance.screen_status.total_screens'.tr(),
          summary['total'].toString(),
          Icons.layers,
        ),
        _buildStatCard(
          theme,
          'governance.screen_status.implemented'.tr(),
          summary['implemented'].toString(),
          Icons.check_circle_outline,
          color: theme.colors.success,
        ),
        _buildStatCard(
          theme,
          'governance.screen_status.pending'.tr(),
          summary['pending'].toString(),
          Icons.pending_actions,
          color: theme.colors.warning,
        ),
        _buildStatCard(
          theme,
          'governance.screen_status.completion'.tr(),
          '${summary['implementedPercentage']}%',
          Icons.analytics_outlined,
          color: theme.colors.primary,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    PrimeThemeData theme,
    String title,
    String value,
    IconData icon, {
    Color? color,
  }) {
    final effectiveColor = color ?? theme.colors.onSurface;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: effectiveColor, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.typography.h1.copyWith(color: effectiveColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBreakdownGrid(
    PrimeThemeData theme,
    Map<String, dynamic> byApp,
  ) {
    final appNames = byApp.keys.toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: appNames.length,
      itemBuilder: (context, index) {
        final appName = appNames[index];
        final appData = byApp[appName] as Map<String, dynamic>;

        final double progress = appData['total'] > 0
            ? (appData['implemented'] / appData['total'])
            : 0;
        final metadata = _getAppMetadata(appName);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(theme.radiusLg),
            border: Border.all(color: theme.colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(metadata.$2, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      metadata.$1,
                      style: theme.typography.h3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appData['implemented']} / ${appData['total']}',
                    style: theme.typography.bodyMedium,
                  ),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: theme.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: theme.colors.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress == 1.0 ? theme.colors.success : theme.colors.primary,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScreenList(PrimeThemeData theme, List<dynamic> screens) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: screens.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: theme.colors.outlineVariant),
        itemBuilder: (context, index) {
          final screen = screens[index] as Map<String, dynamic>;
          final status = screen['status'] as String;
          final isImplemented = status == 'implemented';

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            leading: Icon(
              isImplemented ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isImplemented
                  ? theme.colors.success
                  : theme.colors.onSurfaceVariant,
            ),
            title: Text(
              screen['id'] ?? 'governance.screen_status.unknown_id'.tr(),
              style: theme.typography.h3,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  _buildBadge(
                    theme,
                    screen['app'] ??
                        'governance.screen_status.unknown_app'.tr(),
                  ),
                  const SizedBox(width: 8),
                  _buildBadge(
                    theme,
                    screen['office'] ??
                        'governance.screen_status.unknown_office'.tr(),
                    color: theme.colors.secondary,
                  ),
                  const SizedBox(width: 8),
                  _buildBadge(
                    theme,
                    screen['charter'] ??
                        'governance.screen_status.unknown_charter'.tr(),
                    color: theme.colors.tertiary,
                  ),
                ],
              ),
            ),
            trailing: Text(
              status.toUpperCase(),
              style: theme.typography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: isImplemented
                    ? theme.colors.success
                    : theme.colors.warning,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadge(PrimeThemeData theme, String text, {Color? color}) {
    final badgeColor = color ?? theme.colors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: theme.typography.bodySmall.copyWith(
          color: badgeColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  (String, IconData) _getAppMetadata(String rawName) {
    switch (rawName.toLowerCase()) {
      case 'primecare_governance':
        return ('Governance HUD', Icons.radar_outlined);
      case 'prime_corporate':
        return ('Corporate', Icons.business);
      case 'prime_clinical':
        return ('Clinical', Icons.medical_services);
      case 'prime_operational':
        return ('Operational', Icons.settings_applications);
      case 'prime_franchise':
        return ('Franchise', Icons.storefront);
      case 'primecare_admin':
        return ('Admin Panel', Icons.admin_panel_settings);
      case 'prime_finance':
        return ('Finance', Icons.account_balance_wallet);
      case 'prime_marketing':
        return ('Marketing', Icons.campaign);
      default:
        final name = rawName
            .replaceAll('prime_', '')
            .replaceAll('primecare_', '')
            .replaceAll('_', ' ');
        final displayName = name
            .split(' ')
            .map(
              (w) =>
                  w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
            )
            .join(' ');
        return (displayName, Icons.apps);
    }
  }
}
