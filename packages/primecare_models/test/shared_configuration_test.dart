import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('feature flags retain defaults and mutable switches', () {
    expect(FeatureFlags.useApiForProviderDashboard, isTrue);
    expect(FeatureFlags.useApiForClientProfile, isTrue);
    expect(FeatureFlags.useApiForVisitDetails, isTrue);
    expect(FeatureFlags.useApiForBillingSummary, isTrue);
    expect(FeatureFlags.enableNewVisitFlow, isTrue);
    expect(FeatureFlags.useDashboardV2, isFalse);
    final original = FeatureFlags.useApiForClientProfile;
    addTearDown(() => FeatureFlags.useApiForClientProfile = original);
    FeatureFlags.useApiForClientProfile = false;
    expect(FeatureFlags.useApiForClientProfile, isFalse);
  });

  test('recovery configuration shares mutations without changing defaults', () {
    expect(ResilienceConfig.enableAutoHealing, isTrue);
    expect(ResilienceConfig.enableRecoveryModeUI, isTrue);
    expect(ResilienceConfig.showDebugDetailsInRecovery, isTrue);
    expect(ResilienceConfig.maxAutoResets, 3);
    final original = ResilienceConfig.maxAutoResets;
    addTearDown(() => ResilienceConfig.maxAutoResets = original);
    ResilienceConfig.maxAutoResets = 7;
    expect(ResilienceConfig.maxAutoResets, 7);
  });

  test('data mode retains API default, enum order and shared identity', () {
    expect(DataSourceType.values.map((mode) => mode.name), [
      'mock',
      'api',
      'hybrid',
    ]);
    expect(DataSourceConfig.currentMode, DataSourceType.api);
    final original = DataSourceConfig.currentMode;
    addTearDown(() => DataSourceConfig.currentMode = original);
    DataSourceConfig.currentMode = DataSourceType.hybrid;
    expect(DataSourceConfig.currentMode, same(DataSourceType.hybrid));
  });
}
