import 'package:primecare_models/primecare_models.dart';

class OperationalEfficiencyMetricsModel extends BaseScreenState<OperationalEfficiencyMetricsModel> {
  const OperationalEfficiencyMetricsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationalEfficiencyMetricsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationalEfficiencyMetricsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
