import 'dart:io';

void main() {
  final featuresDir = Directory('packages/flutter_core/lib/features');
  for (final entity in featuresDir.listSync()) {
    if (entity is Directory) {
      final featureName =
          entity.uri.pathSegments[entity.uri.pathSegments.length - 2];
      final camelFeatureName = featureName
          .split('_')
          .map((w) {
            if (w.isEmpty) return '';
            return w[0].toUpperCase() + w.substring(1);
          })
          .join('');

      // Fix repo
      final repoFile = File(
        '${entity.path}/domain/repositories/${featureName}_repository.dart',
      );
      if (repoFile.existsSync()) {
        var content = repoFile.readAsStringSync();
        if (!content.contains('import \'../../../src/result/01_I_result.dart\';')) {
          content = 'import \'../../../src/result/01_I_result.dart\';\n' + content;
        }
        content = content.replaceAll(
          RegExp(r'Future<DashboardMetrics>'),
          'Future<Result<${camelFeatureName}Data>>',
        );
        content = content.replaceAll(
          RegExp(r'Future<${camelFeatureName}Data>'),
          'Future<Result<${camelFeatureName}Data>>',
        );

        // This is a rough replace, let's match metrics.data
        if (content.contains('metrics.data ??')) {
          content = content.replaceAll(
            RegExp(r'final data = metrics\.data \?\?[^;]+;'),
            'final data = ${camelFeatureName}Data.fromJson(metrics.toJson());',
          );
          content = content.replaceAll(
            RegExp(r'return data;'),
            'return Success(data);',
          );
        } else if (content.contains('return metrics;')) {
          content = content.replaceAll(
            r'return metrics;',
            'return Success(${camelFeatureName}Data.fromJson(metrics.toJson()));',
          );
        } else if (content.contains('return data;')) {
          content = content.replaceAll(
            r'return data;',
            'return Success(data);',
          );
        }

        repoFile.writeAsStringSync(content);
      }

      // Fix notifier
      final notifierName = featureName.replaceAll('_dashboard', '');
      final notifierFile = File(
        '${entity.path}/presentation/view_models/${notifierName}_notifier.dart',
      );
      final altNotifierFile = File(
        '${entity.path}/presentation/view_models/${featureName}_notifier.dart',
      );
      var targetNotifierFile = notifierFile.existsSync()
          ? notifierFile
          : (altNotifierFile.existsSync() ? altNotifierFile : null);

      if (targetNotifierFile != null) {
        var content = targetNotifierFile.readAsStringSync();
        content = content.replaceAll(
          RegExp(r'guardHydration<DashboardMetrics>'),
          'guardHydration<${camelFeatureName}Data>',
        );
        content = content.replaceAll(
          RegExp(r"Target of URI doesn't exist|Target of URI doesn't exist"),
          '',
        ); // just in case

        targetNotifierFile.writeAsStringSync(content);
      }
    }
  }
}
