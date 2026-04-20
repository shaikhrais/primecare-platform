import 'dart:io';

void main() {
  File('packages/flutter_core/lib/primecare_core.dart').writeAsStringSync('''
export 'features/patient_dashboard/domain/models/patient_data.dart';
export 'features/regional_manager_ontario_dashboard/domain/models/regional_manager_ontario_data.dart';
export 'features/regional_manager_usa_dashboard/domain/models/regional_manager_usa_data.dart';
''', mode: FileMode.append);
  print('Done');
}
