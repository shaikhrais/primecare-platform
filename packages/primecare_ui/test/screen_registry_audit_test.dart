import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/registry/screen_registry.dart';

void main() {
  final originalScreens = Map.of(ScreenRegistry.screens);

  setUp(() {
    ScreenRegistry.screens.clear();
  });

  tearDown(() {
    ScreenRegistry.screens
      ..clear()
      ..addAll(originalScreens);
  });

  // These are isolated metadata keys, not production registrations. The audit
  // only needs the key; reuse an existing metadata object without changing it.
  void include(String id) {
    ScreenRegistry.screens[id] = originalScreens.values.first;
  }

  test('empty metadata produces no audit reports', () {
    expect(ScreenRegistry.auditRegistry(), isEmpty);
  });

  test('metadata alone is unhealthy and preserves the navigation fallback', () {
    const id = 'AUDIT_TEST_UNREGISTERED_SCREEN';
    include(id);

    final report = ScreenRegistry.auditRegistry().single;
    expect(report.id, id);
    expect(report.isHealthy, isFalse);
    expect(report.message, contains('no widget binding'));
    final widget = ScreenRegistry.getWidget(id);
    expect(widget, isA<ScreenNotImplementedView>());
    expect((widget as ScreenNotImplementedView).screenName, id);
  });

  test('registered placeholders are unhealthy through both alias forms', () {
    for (final id in ['PSW_SHIFT_TRACKER', 'SCREEN_PSW_SHIFT_TRACKER']) {
      include(id);
      expect(ScreenRegistry.getWidget(id), isA<ScreenNotImplementedView>());
    }

    final reports = ScreenRegistry.auditRegistry();
    expect(reports, hasLength(2));
    for (final report in reports) {
      expect(report.isHealthy, isFalse);
      expect(report.message, contains('placeholder widget'));
      expect(report.message, isNot(contains('no widget binding')));
    }
    expect(
      identical(
        ScreenRegistry.getWidget('PSW_SHIFT_TRACKER'),
        ScreenRegistry.getWidget('SCREEN_PSW_SHIFT_TRACKER'),
      ),
      isTrue,
    );
  });

  test('unprefixed binding wins over a prefixed placeholder', () {
    // The registry intentionally retains both entries. Navigation has always
    // preferred RN_DASHBOARD, even when called with SCREEN_RN_DASHBOARD.
    for (final id in ['RN_DASHBOARD', 'SCREEN_RN_DASHBOARD']) {
      include(id);
      expect(ScreenRegistry.getWidget(id), isNot(isA<ScreenNotImplementedView>()));
    }
    for (final report in ScreenRegistry.auditRegistry()) {
      expect(report.isHealthy, isTrue);
      expect(report.message, contains('has a widget binding'));
    }
    expect(
      identical(
        ScreenRegistry.getWidget('RN_DASHBOARD'),
        ScreenRegistry.getWidget('SCREEN_RN_DASHBOARD'),
      ),
      isTrue,
    );
  });

  test('mapped aliases only establish static binding health', () {
    for (final id in ['COO_DASHBOARD', 'SCREEN_COO_DASHBOARD']) {
      include(id);
    }

    final reports = ScreenRegistry.auditRegistry();
    expect(reports.map((r) => r.id), ['COO_DASHBOARD', 'SCREEN_COO_DASHBOARD']);
    for (final report in reports) {
      expect(report.isHealthy, isTrue);
      expect(report.message, contains('has a widget binding'));
      expect(report.message, contains('runtime behavior are not verified'));
    }
    expect(
      identical(
        ScreenRegistry.getWidget('COO_DASHBOARD'),
        ScreenRegistry.getWidget('SCREEN_COO_DASHBOARD'),
      ),
      isTrue,
    );
  });

  test('audit does not mutate metadata or widget resolution', () {
    ScreenRegistry.screens.addAll(originalScreens);
    final widgetsBefore = {
      for (final id in ScreenRegistry.screens.keys) id: ScreenRegistry.getWidget(id),
    };
    final reports = ScreenRegistry.auditRegistry();

    expect(reports.map((r) => r.id), originalScreens.keys);
    expect(ScreenRegistry.screens, originalScreens);
    for (final entry in widgetsBefore.entries) {
      final widgetAfter = ScreenRegistry.getWidget(entry.key);
      expect(widgetAfter.runtimeType, entry.value.runtimeType);
      if (entry.value is! ScreenNotImplementedView) {
        expect(identical(widgetAfter, entry.value), isTrue);
      }
    }
  });
}
