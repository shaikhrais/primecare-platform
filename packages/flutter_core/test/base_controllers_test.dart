import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';

class TestState extends DashboardState<TestState> {
  TestState({required super.isLoading, super.error, required super.data});
  @override
  TestState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TestState(isLoading: isLoading, error: error, data: data);
}

class TestDashboard extends BaseDashboardController<TestState> {
  TestDashboard(Ref ref, DashboardLoader loader)
    : super(
        ref,
        endpoint: '/fixture',
        initialState: TestState(isLoading: true, data: {}),
        loader: loader,
      );
}

class TestScaffold extends BaseScaffoldController {}

void main() {
  test('copyWith can retain or explicitly clear errors', () {
    final state = TestState(
      isLoading: false,
      error: 'failed',
      data: {'value': 1},
    );
    expect(state.copyWith(isLoading: true).error, 'failed');
    expect(state.copyWith(error: null).error, isNull);
    expect(state.copyWith(error: null).data, {'value': 1});
  });

  test(
    'reload clears a previous error and preserves feature state type',
    () async {
      var calls = 0;
      final provider = StateNotifierProvider<TestDashboard, TestState>(
        (ref) => TestDashboard(
          ref,
          () async => ++calls == 1
              ? const DashboardLoadResult(isSuccess: false, error: 'failed')
              : const DashboardLoadResult(isSuccess: true, data: {'value': 2}),
        ),
      );
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final controller = container.read(provider.notifier);
      await Future<void>.delayed(Duration.zero);
      expect(container.read(provider).error, 'failed');
      await controller.syncData();
      expect(container.read(provider).error, isNull);
      expect(container.read(provider).data, {'value': 2});
    },
  );

  test('outdated responses cannot overwrite the latest refresh', () async {
    final first = Completer<DashboardLoadResult>();
    final second = Completer<DashboardLoadResult>();
    var calls = 0;
    final provider = StateNotifierProvider<TestDashboard, TestState>(
      (ref) =>
          TestDashboard(ref, () => ++calls == 1 ? first.future : second.future),
    );
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(provider.notifier);
    final refresh = controller.syncData();
    second.complete(
      const DashboardLoadResult(isSuccess: true, data: {'value': 2}),
    );
    await refresh;
    first.complete(
      const DashboardLoadResult(isSuccess: true, data: {'value': 1}),
    );
    await Future<void>.delayed(Duration.zero);
    expect(container.read(provider).data, {'value': 2});
  });

  test('disposed dashboard ignores late completion', () async {
    final pending = Completer<DashboardLoadResult>();
    final provider = StateNotifierProvider<TestDashboard, TestState>(
      (ref) => TestDashboard(ref, () => pending.future),
    );
    final container = ProviderContainer();
    container.read(provider);
    container.dispose();
    pending.complete(
      const DashboardLoadResult(isSuccess: true, data: {'value': 1}),
    );
    await Future<void>.delayed(Duration.zero);
  });

  test(
    'scaffold never claims that an unimplemented action completed',
    () async {
      final provider =
          NotifierProvider<TestScaffold, AsyncValue<Map<String, dynamic>>>(
            TestScaffold.new,
          );
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final initial = container.read(provider).requireValue;
      expect(initial['status'], 'not_implemented');
      expect(initial['featuresEnabled'], isFalse);
      expect(initial['dataLoaded'], isFalse);
      await container.read(provider.notifier).performAction();
      expect(container.read(provider).hasError, isTrue);
      expect(container.read(provider).error, isA<UnsupportedError>());
    },
  );
}
