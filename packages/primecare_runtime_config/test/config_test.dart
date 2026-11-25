import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime_config/primecare_runtime_config.dart';
import 'package:primecare_runtime_config/ui_feature_flags.dart' as ui;

void main() {
  test('configuration defaults and independent flags retain their behavior', () {
    expect(DataSourceConfig.currentMode, DataSourceType.api);
    expect(FeatureFlags.useApiForProviderDashboard, isTrue);
    expect(FeatureFlags.useApiForClientProfile, isTrue);
    expect(FeatureFlags.useApiForVisitDetails, isTrue);
    expect(FeatureFlags.useApiForBillingSummary, isTrue);
    expect(ui.FeatureFlags.enableNewVisitFlow, isTrue);
    expect(ui.FeatureFlags.useDashboardV2, isFalse);
    DataSourceConfig.currentMode = DataSourceType.hybrid;
    expect(DataSourceConfig.currentMode, DataSourceType.hybrid);
    DataSourceConfig.currentMode = DataSourceType.api;
  });
}
