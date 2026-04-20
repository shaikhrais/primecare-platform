import 'dart:io';

void main() {
  final file = File('packages/flutter_core/lib/primecare_core.dart');
  var content = file.readAsStringSync();

  final toAdd = [
    "export 'features/speech_pathologist/domain/models/speech_pathologist_data.dart';",
    "export 'features/compliance_manager_dashboard/domain/models/compliance_manager_dashboard_state.dart';",
    "export 'features/compliance_manager_dashboard/domain/models/compliance_manager_data.dart';",
    "export 'features/compliance_manager_dashboard/presentation/providers/providers.dart';",
    "export 'features/compliance_manager_dashboard/presentation/view_models/compliance_manager_notifier.dart';",
    "export 'features/general_manager_dashboard/domain/models/general_manager_data.dart';",
    "export 'features/general_manager_dashboard/domain/models/general_manager_state.dart';",
    "export 'features/scrum_master_dashboard/domain/models/scrum_master_data.dart';",
    "export 'features/customer_support/domain/models/customer_support_data.dart';",
    "export 'features/customer_support/domain/models/customer_support_state.dart';",
    "export 'features/customer_support/presentation/providers/providers.dart';",
    "export 'features/customer_support/presentation/view_models/customer_support_notifier.dart';",
    "export 'features/support_dashboard/domain/models/support_data.dart';",
    "export 'features/community_outreach_dashboard/domain/models/community_outreach_data.dart';",
    "export 'features/clinic_dashboard/domain/models/clinic_data.dart';",
    "export 'features/occupational_therapist/domain/models/occupational_therapist_data.dart';",
    "export 'features/occupational_therapist/domain/models/occupational_therapist_state.dart';",
    "export 'features/occupational_therapist/presentation/providers/providers.dart';",
    "export 'features/occupational_therapist/presentation/view_models/occupational_therapist_notifier.dart';",
  ];

  for (var line in toAdd) {
    if (!content.contains(line)) {
      content += '\n' + line;
    }
  }

  file.writeAsStringSync(content);
  print('Added missing exports.');
}
