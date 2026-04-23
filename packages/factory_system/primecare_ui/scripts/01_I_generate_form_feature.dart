// Layer: 01_INFRASTRUCTURE
import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    // print Statement Logged To Telemetry
    // print Statement Logged To Telemetry
    exit(1);
  }

  final featureName = args[0];
  final snakeCaseName = _toSnakeCase(featureName);

  final formFileName = '${snakeCaseName}_form.dart';
  final notifierFileName = '${snakeCaseName}_notifier.dart';

  final formsPath = 'lib/src/components/forms';
  final statePath = '$formsPath/state';

  // Ensure directories exist
  await Directory(formsPath).create(recursive: true);
  await Directory(statePath).create(recursive: true);

  // Generate Notifier
  final notifierFile = File('$statePath/$notifierFileName');
  await notifierFile.writeAsString(_generateNotifierContent(featureName));
  // print Statement Logged To Telemetry

  // Generate Form UI
  final formFile = File('$formsPath/$formFileName');
  await formFile.writeAsString(
    _generateFormContent(featureName, snakeCaseName),
  );
  // print Statement Logged To Telemetry

  // print Statement Logged To Telemetry
  // print Statement Logged To Telemetry
  // print Statement Logged To Telemetry
  // print Statement Logged To Telemetry
  // print Statement Logged To Telemetry
  print("   '${snakeCaseName}_form': () => const ${featureName}Form(),");
  // print Statement Logged To Telemetry
}

String _toSnakeCase(String camelCase) {
  RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
  return camelCase
      .replaceAllMapped(exp, (Match m) => '_${m.group(0)}')
      .toLowerCase();
}

String _toCamelCase(String pascalCase) {
  if (pascalCase.isEmpty) return pascalCase;
  return pascalCase[0].toLowerCase() + pascalCase.substring(1);
}

String _generateNotifierContent(String featureName) {
  return '''import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/primecare_core.dart'; // Result.guardFuture, AsyncValue, executionGateProvider

class ${featureName}Payload {
  final Map<String, dynamic> data;

  const ${featureName}Payload({
    required this.data,
  });
}

class ${featureName}Notifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initial state setup if loading from draft/api
    return null;
  }

  Future<void> submit(${featureName}Payload payload) async {
    // 1. Guard the future for global loading state
    state = const AsyncValue.loading();
    
    // 2. Perform the async operation globally via architecture pattern
    state = await AsyncValue.guard(() async {
      final result = await Result.guardFuture(
        () async {
          // NOTE: Replace with actual Provider API call
          await Future<void>.delayed(const Duration(seconds: 2));
        },
      );
      if (result.isFailure) {
        throw Exception('Failed to submit $featureName');
      }
    });

    // 3. Telemetry tracking
    if (!state.hasError) {
      ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.ui,
        '${featureName}Form submitted successfully',
      );
    }
  }
}

final ${_toCamelCase(featureName)}Provider = AsyncNotifierProvider<${featureName}Notifier, void>(
  () => ${featureName}Notifier(),
);
''';
}

String _generateFormContent(String featureName, String snakeCase) {
  String camelCase = _toCamelCase(featureName);
  return '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../layouts/01_I_responsive_grid_layout.dart';

import '01_I_base_form.dart';
import 'state/${snakeCase}_notifier.dart';

class ${featureName}Form extends ConsumerStatefulWidget {
  const ${featureName}Form({super.key});

  @override
  ConsumerState<${featureName}Form> createState() => _${featureName}FormState();
}

class _${featureName}FormState extends ConsumerState<${featureName}Form> {
  final _formKey = GlobalKey<FormState>();

  // Use base form controllers list for disposal loop
  final List<TextEditingController> _controllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final payload = ${featureName}Payload(data: {
        'field1': _controllers[0].text,
      });

      await ref.read(${camelCase}Provider.notifier).submit(payload);

      if (mounted && !ref.read(${camelCase}Provider).hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully submitted')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(${camelCase}Provider);

    return BaseForm(
      title: '$featureName Details',
      subtitle: 'Complete the form to submit $featureName information.',
      isLoading: state.isLoading,
      formKey: _formKey,
      onSubmit: _submit,
      onCancel: () {
        _formKey.currentState?.reset();
        for (var c in _controllers) {
          c.clear();
        }
      },
      children: [
        ResponsiveGridRow(
          children: [
          // Row 1
          ResponsiveGridCol(
            span: 6,
            child: _buildTextField(
              controller: _controllers[0],
              label: 'Field 1',
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
          ),
          ResponsiveGridCol(
            span: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Status'),
                 items: const [
                  DropdownMenuItem(value: 'draft', child: Text('Draft')),
                  DropdownMenuItem(value: 'publish', child: Text('Publish')),
                ],
                onChanged: (v) {},
                validator: (v) => v == null ? 'Required' : null,
              ),
            ),
          ),
        ],
      ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
''';
}
