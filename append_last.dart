import 'dart:io';

void main() {
  File('packages/flutter_core/lib/primecare_core.dart').writeAsStringSync('''
export 'features/speech_pathologist/domain/models/speech_pathologist_state.dart';
export 'features/speech_pathologist/presentation/providers/providers.dart';
export 'features/speech_pathologist/presentation/view_models/speech_pathologist_view_model.dart';
''', mode: FileMode.append);
  print('Done');
}
