const fs = require('fs');
const path = require('path');

const screens = [
  { file: 'client_profile.dart', name: 'ClientProfileScreen', title: 'Client Profile', sub: 'View and manage client details.' },
  { file: 'care_plan.dart', name: 'CarePlanScreen', title: 'Care Plan', sub: 'Review and update client care plans.' },
  { file: 'history_logs.dart', name: 'HistoryLogsScreen', title: 'History & Logs', sub: 'Audit logs and past interactions.' },
  { file: 'profile_settings.dart', name: 'ProfileSettingsScreen', title: 'Profile & Settings', sub: 'Manage user preferences.' },
  { file: 'messaging.dart', name: 'MessagingScreen', title: 'Messaging', sub: 'Secure communications.' },
  { file: 'incident_report.dart', name: 'IncidentReportScreen', title: 'Incident Report', sub: 'File reports for any incidents.' },
  { file: 'check_in_out.dart', name: 'CheckInOutScreen', title: 'Check-In / Out', sub: 'Log time and attendance.' },
  { file: 'master_app_shell.dart', name: 'MasterAppShellScreen', title: 'Master App Shell', sub: 'Global navigation context.' },
  { file: 'daily_notes.dart', name: 'DailyNotesScreen', title: 'Daily Notes', sub: 'Document daily observations.' },
  { file: 'shift_details.dart', name: 'ShiftDetailsScreen', title: 'Shift Details', sub: 'View upcoming and active shifts.' },
  { file: 'dashboard.dart', name: 'DashboardScreen', title: 'Dashboard', sub: 'Clinic overview and key metrics.' },
  { file: 'my_shifts.dart', name: 'MyShiftsScreen', title: 'My Shifts', sub: 'Manage your assigned shifts.' }
];

const dir = path.join(__dirname, '..', 'apps', 'primecare_clinic', 'lib', 'screens');
fs.mkdirSync(dir, { recursive: true });

screens.forEach(s => {
  const code = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ${s.name} extends ConsumerWidget {
  const ${s.name}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: '${s.title}',
      subtitle: '${s.sub}',
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              '${s.title} Content',
              style: PrimeCareTheme.typography.h2,
            ),
          ),
        ),
      ],
    );
  }
}
`;
  fs.writeFileSync(path.join(dir, s.file), code);
});
console.log('Screens generated successfully.');
