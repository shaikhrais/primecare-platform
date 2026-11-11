import 'package:primecare_ui/primecare_ui.dart';

// Exact migrated heading expressions, one from each former role palette.
final targetRoleHeadingBuilders = <WidgetBuilder>[
  (context) {
    final theme = context.theme;
    return Text(
                        'Target Role: Governance Officer',
                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: 14),
                      );
  },
  (context) {
    final theme = context.theme;
    return Text(
                        'Target Role: Patient',
                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: 14),
                      );
  },
  (context) {
    final theme = context.theme;
    return Text(
                        'Target Role: Head of Marketing',
                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: 14),
                      );
  },
  (context) {
    final theme = context.theme;
    return Text(
                        'Target Role: Registered Nurse (RN)',
                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: 14),
                      );
  },
  (context) {
    final theme = context.theme;
    return Text(
                        'Target Role: Chief Financial Officer (CFO)',
                        style: TextStyle(fontWeight: FontWeight.bold, color: theme.colors.onSurface, fontSize: 14),
                      );
  },
];
