import 'package:primecare_models/primecare_models.dart';

class RnFieldSupervisorAnalyticsModel extends BaseScreenState<RnFieldSupervisorAnalyticsModel> {
  const RnFieldSupervisorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnFieldSupervisorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnFieldSupervisorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
