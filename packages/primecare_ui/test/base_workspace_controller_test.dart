import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_models/primecare_models.dart';
import '../lib/src/application/base_workspace_controller.dart';

class WorkspaceState extends BaseWorkspaceState<WorkspaceState> {
  const WorkspaceState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
    required super.hasData,
  });

  @override
  WorkspaceState rebuild({
    required bool isLoading,
    required String? error,
    required String title,
    required List<String> logs,
    required bool hasData,
  }) => WorkspaceState(
    isLoading: isLoading,
    error: error,
    title: title,
    logs: logs,
    hasData: hasData,
  );
}

class WorkspaceController extends BaseWorkspaceController<WorkspaceState> {
  WorkspaceController()
    : super(
        const WorkspaceState(
          isLoading: false,
          error: 'previous',
          title: 'title',
          logs: ['old'],
          hasData: true,
        ),
      );
  WorkspaceState get snapshot => state;
}

class CustomController extends WorkspaceController {
  @override
  void toggleEmpty() {
    state = WorkspaceState(
      isLoading: false,
      error: null,
      title: state.title,
      logs: state.logs,
      hasData: false,
    );
  }
}

void main() {
  test('shared transitions preserve original null and log semantics', () {
    final controller = WorkspaceController();
    addTearDown(controller.dispose);
    final originalLogs = controller.snapshot.logs;
    controller.toggleLoading();
    expect(controller.snapshot.isLoading, isTrue);
    expect(controller.snapshot.error, 'previous');
    controller.toggleEmpty();
    expect(controller.snapshot.isLoading, isFalse);
    expect(controller.snapshot.hasData, isFalse);
    expect(controller.snapshot.error, 'previous');
    controller.toggleSuccess();
    expect(controller.snapshot.hasData, isTrue);
    controller.toggleError('failed');
    expect(controller.snapshot.isLoading, isFalse);
    expect(controller.snapshot.hasData, isFalse);
    expect(controller.snapshot.error, 'failed');
    controller.addLog('new');
    expect(controller.snapshot.logs, ['old', 'new']);
    expect(originalLogs, ['old']);
    expect(controller.snapshot.title, 'title');
  });
  test('custom transitions can preserve explicit error clearing', () {
    final controller = CustomController();
    addTearDown(controller.dispose);
    controller.toggleEmpty();
    expect(controller.snapshot.error, isNull);
    expect(controller.snapshot.hasData, isFalse);
  });
}
