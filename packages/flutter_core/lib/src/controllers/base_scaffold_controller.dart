import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Non-executable scaffold. No simulated business completion or storage writes.
abstract class BaseScaffoldController
    extends Notifier<AsyncValue<Map<String, dynamic>>> {
  @override
  AsyncValue<Map<String, dynamic>> build() => const AsyncValue.data({
    'status': 'not_implemented',
    'featuresEnabled': false,
    'dataLoaded': false,
  });

  Future<void> performAction() async {
    if (!ref.mounted) return;
    state = AsyncValue.error(
      UnsupportedError('This workflow is not implemented.'),
      StackTrace.current,
    );
  }
}
