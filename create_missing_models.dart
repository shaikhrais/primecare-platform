import 'dart:io';

void main() {
  final featuresDir = Directory('packages/flutter_core/lib/features');

  for (final entity in featuresDir.listSync()) {
    if (entity is! Directory) continue;

    final featureName = entity.uri.pathSegments[entity.uri.pathSegments.length - 2];
    if (featureName == 'common' || featureName.isEmpty) continue;

    final camelFeatureName = featureName.split('_').map((w) {
      if (w.isEmpty) return '';
      return w[0].toUpperCase() + w.substring(1);
    }).join('');

    final structName = camelFeatureName.replaceAll('Dashboard', '');
    final snakeFeatureName = featureName.replaceAll('_dashboard', '');
    
    final modelsDir = Directory('${entity.path}/domain/models');
    if (!modelsDir.existsSync()) {
      modelsDir.createSync(recursive: true);
    }
    
    final dataFile = File('${modelsDir.path}/${snakeFeatureName}_data.dart');
    if (!dataFile.existsSync()) {
      dataFile.writeAsStringSync('''import 'package:freezed_annotation/freezed_annotation.dart';

part '${snakeFeatureName}_data.freezed.dart';
part '${snakeFeatureName}_data.g.dart';

@freezed
class ${structName}Data with _\$${structName}Data {
  const factory ${structName}Data({
    required Map<String, dynamic> metrics,
  }) = _${structName}Data;

  factory ${structName}Data.fromJson(Map<String, dynamic> json) =>
      _\$${structName}DataFromJson(json);

  factory ${structName}Data.mock() => const ${structName}Data(
        metrics: {},
      );
}
''');
      print('Created ${dataFile.path}');
    }
    
    final stateFile = File('${modelsDir.path}/${snakeFeatureName}_state.dart');
    if (!stateFile.existsSync()) {
      stateFile.writeAsStringSync('''import 'package:freezed_annotation/freezed_annotation.dart';
import '${snakeFeatureName}_data.dart';

part '${snakeFeatureName}_state.freezed.dart';

@freezed
class ${structName}State with _\$${structName}State {
  const factory ${structName}State.initial() = _Initial;
  const factory ${structName}State.loading() = _Loading;
  const factory ${structName}State.loaded({required ${structName}Data data}) = _Loaded;
  const factory ${structName}State.error(String message) = _Error;
}
''');
      print('Created ${stateFile.path}');
    }
  }
}
