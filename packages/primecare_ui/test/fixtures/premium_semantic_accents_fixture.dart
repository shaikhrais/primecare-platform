// Exact migrated consumer expressions; private premium helpers renamed for tests.
import 'package:primecare_ui/primecare_ui.dart';
import 'premium_audit_panel_fixture.dart';
import 'premium_trend_card_fixture.dart';

Widget semanticAccentConsumer0(BuildContext context) {
  final theme = context.theme;
  return PremiumTrendCardFixture(
              title: 'API Request Latency', // .tr() LocaleKeys.
              value: '14.2 ms', // .tr() LocaleKeys.
              change: '-2.4 ms', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.speed,
              color: theme.colors.primary,
            );
}

Widget semanticAccentConsumer1(BuildContext context) {
  final theme = context.theme;
  return PremiumTrendCardFixture(
              title: 'Data Ingestion Rate', // .tr() LocaleKeys.
              value: '4,821 rps', // .tr() LocaleKeys.
              change: '+18.4%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.cloud_download,
              color: theme.colors.success,
            );
}

Widget semanticAccentConsumer2(BuildContext context) {
  final theme = context.theme;
  return PremiumTrendCardFixture(
              title: 'Governance Violations', // .tr() LocaleKeys.
              value: '0 entries', // .tr() LocaleKeys.
              change: '0.00%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.gavel,
              color: theme.colors.warning,
            );
}

Widget semanticAccentConsumer3(BuildContext context) {
  final theme = context.theme;
  return PremiumAuditPanelFixture(
                    modelName: 'AppNotification',
                    themeColor: theme.colors.warning,
                  );
}

Widget semanticAccentConsumer4(BuildContext context) {
  final theme = context.theme;
  return QuickActionsPanel(title: 'Operation Actions', actions: [QuickActionItem(
                  label: 'Trigger Audit', // .tr() LocaleKeys.
                  icon: Icons.shield,
                  color: theme.colors.primary,
                  onTap: () {},
                )]);
}

Widget semanticAccentConsumer5(BuildContext context) {
  final theme = context.theme;
  return QuickActionsPanel(title: 'Operation Actions', actions: [QuickActionItem(
                  label: 'Sync Schema', // .tr() LocaleKeys.
                  icon: Icons.sync,
                  color: theme.colors.success,
                  onTap: () {},
                )]);
}

Widget semanticAccentConsumer6(BuildContext context) {
  final theme = context.theme;
  return QuickActionsPanel(title: 'Operation Actions', actions: [QuickActionItem(
                  label: 'Export Logs', // .tr() LocaleKeys.
                  icon: Icons.download,
                  color: theme.colors.warning,
                  onTap: () {},
                )]);
}

Widget semanticAccentConsumer7(BuildContext context) {
  final theme = context.theme;
  return RecentActivityFeed(title: 'Governance Audit Trail', activities: [PortalActivityItem(
                  title: 'Prisma Client Hydration', // .tr() LocaleKeys.
                  description: 'Synchronized telemetry mapping against database node.', // .tr() LocaleKeys.
                  time: '2m ago', // .tr() LocaleKeys.
                  icon: Icons.cloud_done,
                  color: theme.colors.success,
                )]);
}

Widget semanticAccentConsumer8(BuildContext context) {
  final theme = context.theme;
  return RecentActivityFeed(title: 'Governance Audit Trail', activities: [PortalActivityItem(
                  title: 'Telemetry Session Start', // .tr() LocaleKeys.
                  description: 'Established active stream listener on /v1/premium/appnotification.', // .tr() LocaleKeys.
                  time: '3h ago', // .tr() LocaleKeys.
                  icon: Icons.play_arrow,
                  color: theme.colors.primary,
                )]);
}
