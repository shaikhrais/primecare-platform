import 'package:primecare_models/primecare_models.dart';

class InfrastructureAnalyticsModel extends BaseScreenState<InfrastructureAnalyticsModel> {
  const InfrastructureAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InfrastructureAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InfrastructureAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
