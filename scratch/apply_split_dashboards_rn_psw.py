import os
import re

files_to_refactor = {
    "apps/primecare_clinic/lib/features/psw/screens/psw_dashboard_screen.dart": {
        "role": "Psw",
        "title": "Psw Dashboard",
        "prefix": "pswdashboard",
        "insights_heading": "PSW Telemetry Insights",
        "insights_suggestions": [
            "Complete tasks checklist before closing shift.",
            "Ensure hydration protocols are recorded for all residents.",
            "Report any behavioral shifts directly to the shift supervisor.",
        ]
    },
    "apps/primecare_clinic/lib/features/rn/screens/rn_dashboard_screen.dart": {
        "role": "Rn",
        "title": "Rn Dashboard",
        "prefix": "rndashboard",
        "insights_heading": "RN Telemetry Insights",
        "insights_suggestions": [
            "Enforce active patient care documentation updates.",
            "Verify MAR medication sheets are signed off by end-of-shift.",
            "Last safety compliance sweep completed with 0 errors.",
        ]
    }
}

def refactor_file(file_path, info):
    print(f"Refactoring {file_path}...")
    
    role = info["role"]
    title = info["title"]
    prefix = info["prefix"]
    insights_heading = info["insights_heading"]
    suggestions_str = ", ".join([f"'{s}'" for s in info["insights_suggestions"]])
    
    # We will replace from "body: Semantics(" or "body: Cy(" down to the end of the widget build method.
    # Let's write the code content directly.
    new_code = f"""import 'package:primecare_ui/primecare_ui.dart';

class {role}DashboardScreen extends ConsumerWidget {{
  const {role}DashboardScreen({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    final theme = context.theme;
    final roleBase = '{role}';

    return Cy(
      id: '{prefix}-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            label: 'data-cy:{prefix}-title',
            child: Text(
              key: const Key('{prefix}-title'),
              '{title}',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
        ),
        body: ResponsiveSplitDashboard(
          metrics: const [
            GovMetricCard(
              title: 'Active Operations',
              value: 'Active',
              trendLabel: 'Optimal',
              progress: 0.92,
              icon: LucideIcons.activity,
              brandColor: Color(0xFF0D9488),
            ),
            GovMetricCard(
              title: 'Security Clearance',
              value: 'Level 4',
              trendLabel: 'Approved',
              progress: 1.0,
              icon: LucideIcons.shieldCheck,
              brandColor: Color(0xFF16A34A),
            ),
            GovMetricCard(
              title: 'System Latency',
              value: '18ms',
              trendLabel: 'Optimal',
              progress: 0.98,
              icon: LucideIcons.zap,
              brandColor: Color(0xFFEAB308),
            ),
            GovMetricCard(
              title: 'Data Integrity',
              value: '99.9%',
              trendLabel: 'Secure',
              progress: 0.99,
              icon: LucideIcons.database,
              brandColor: Color(0xFF2563EB),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'data-cy:{prefix}-title',
                child: GovDashboardHero(
                  title: '{title}',
                  roleName: '$roleBase Dashboard',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () {{}},
                ),
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Core Telemetry',
                dataPoints: const [75, 82, 80, 94, 91, 98],
                labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                accentColor: theme.colors.primary,
              ),
            ],
          ),
          defaultSidebarWidgets: const [
            AiInsightsCard(
              heading: '{insights_heading}',
              suggestions: [{suggestions_str}],
            ),
          ],
        ),
      ),
    );
  }}
}}
"""

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_code)
    print(f"  Successfully refactored {file_path}")

for path, info in files_to_refactor.items():
    refactor_file(os.path.join(os.getcwd(), path), info)
