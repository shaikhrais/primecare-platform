// Exact migrated caller expressions; private helper classes renamed for testing.
import 'package:primecare_ui/primecare_ui.dart';
import 'premium_trend_card_fixture.dart';
import 'premium_health_panel_fixture.dart';

Widget primaryBrandConsumer0(BuildContext context) {
  final theme = context.theme;
  return PremiumTrendCardFixture(
              title: 'Telemetry Node Health', // .tr() LocaleKeys.
              value: '99.98%', // .tr() LocaleKeys.
              change: '+0.02%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.hub,
              color: theme.colors.primary,
            );
}

Widget primaryBrandConsumer1(BuildContext context) {
  final theme = context.theme;
  return PremiumHealthPanelFixture(
                    modelName: 'AppNotification',
                    data: const {},
                    themeColor: theme.colors.primary,
                  );
}

Widget primaryBrandConsumer2(BuildContext context) {
  final theme = context.theme;
  return QuickActionsPanel(title: 'Operation Actions', actions: [QuickActionItem(
                  label: 'Purge Buffers', // .tr() LocaleKeys.
                  icon: Icons.cleaning_services,
                  color: theme.colors.primary,
                  onTap: () {},
                )]);
}

Widget primaryBrandConsumer3(BuildContext context) {
  final theme = context.theme;
  return RecentActivityFeed(title: 'Governance Audit Trail', activities: [PortalActivityItem(
                  title: 'Zero-Trust Audit Log', // .tr() LocaleKeys.
                  description: 'Verified tenant credentials with secure authentication.', // .tr() LocaleKeys.
                  time: '1h ago', // .tr() LocaleKeys.
                  icon: Icons.lock,
                  color: theme.colors.primary,
                )]);
}
