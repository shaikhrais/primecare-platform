part of '../../aura_providers.dart';

/// Global toggle state to engage Aura predictive visualizations deeply within charts/dashboards.
class AuraActiveVisualizationNotifier extends BaseValueNotifier<bool> {
  @override
  bool get initialValue => false;
}
