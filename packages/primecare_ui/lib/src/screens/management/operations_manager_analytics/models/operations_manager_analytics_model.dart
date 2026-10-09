import 'package:primecare_models/primecare_models.dart';

class OperationsManagerAnalyticsModel extends BaseScreenState<OperationsManagerAnalyticsModel> {
  const OperationsManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
