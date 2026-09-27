import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty || args.length < 2) {
    print('Usage: dart generate_screen.dart <AppName> <ScreenName>');
    print(
      'Example: dart generate_screen.dart primecare_governance ProposalInbox',
    );
    exit(1);
  }

  final appName = args[0];
  final screenName = args[1]; // e.g., ProposalInbox

  final snakeCaseName = _toSnakeCase(screenName);
  final targetDir = Directory('apps/$appName/lib/features/${snakeCaseName}');

  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  // Generate Model
  final modelFile = File('${targetDir.path}/${snakeCaseName}_model.dart');
  modelFile.writeAsStringSync(_generateModelContent(screenName));

  // Generate Controller
  final controllerFile = File(
    '${targetDir.path}/${snakeCaseName}_controller.dart',
  );
  controllerFile.writeAsStringSync(
    _generateControllerContent(screenName, snakeCaseName),
  );

  // Generate View
  final viewFile = File('${targetDir.path}/${snakeCaseName}_view.dart');
  viewFile.writeAsStringSync(_generateViewContent(screenName, snakeCaseName));

  print(
    'Successfully generated MVC structure for $screenName in apps/$appName/lib/features/$snakeCaseName',
  );
}

String _toSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (Match m) {
    return m.start == 0 ? m[0]!.toLowerCase() : '_${m[0]!.toLowerCase()}';
  });
}

String _generateModelContent(String screenName) {
  return '''
class ${screenName}Model {
  final bool isLoading;
  final String? error;
  // Add more state fields here

  const ${screenName}Model({
    this.isLoading = false,
    this.error,
  });

  ${screenName}Model copyWith({
    bool? isLoading,
    String? error,
  }) {
    return ${screenName}Model(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
''';
}

String _generateControllerContent(String screenName, String snakeCaseName) {
  final lowerCamel = screenName[0].toLowerCase() + screenName.substring(1);
  return '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '${snakeCaseName}_model.dart';

final ${lowerCamel}ControllerProvider = StateNotifierProvider<${screenName}Controller, ${screenName}Model>((ref) {
  return ${screenName}Controller();
});

class ${screenName}Controller extends StateNotifier<${screenName}Model> {
  ${screenName}Controller() : super(const ${screenName}Model()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 1));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Add business logic methods here
}
''';
}

String _generateViewContent(String screenName, String snakeCaseName) {
  final lowerCamel = screenName[0].toLowerCase() + screenName.substring(1);
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import '${snakeCaseName}_controller.dart';

class ${screenName}View extends ConsumerWidget {
  const ${screenName}View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(${lowerCamel}ControllerProvider);

    return Scaffold(
      backgroundColor: theme.colors.surfaceContainerLowest,
      appBar: AppBar(
        title: Text('$screenName'),
        backgroundColor: theme.colors.surface,
        elevation: 0,
      ),
      body: _buildBody(context, state, theme),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state, PrimeThemeData theme) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: theme.colors.primary));
    }

    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          style: theme.typography.bodyLarge.copyWith(color: theme.colors.error),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to $screenName',
            style: theme.typography.h2,
          ),
          const SizedBox(height: 16),
          // Content goes here
        ],
      ),
    );
  }
}
''';
}
