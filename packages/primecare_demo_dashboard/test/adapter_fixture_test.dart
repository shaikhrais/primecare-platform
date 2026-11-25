import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/primecare_models.dart';
import 'package:primecare_demo_dashboard/primecare_demo_dashboard.dart';

void main() {
  test('legacy dashboard aliases retain the same provider identity', () {
    expect(genericDashboardProvider, same(dashboardMetricsProvider));
    expect(commonFeatureDataProvider, same(dashboardMetricsProvider));
  });
  test('every form uses the existing synthetic dashboard adapter', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    for (final form in PrimeCareForm.values) {
      final adapter = container.read(primecareFormProvider(form));
      expect(adapter, same(container.read(genericDashboardAdapterProvider(form))));
      expect(adapter.form, form);
      expect(adapter.watchData().value?.getOrThrow(), isNotNull);
    }
  });
}
