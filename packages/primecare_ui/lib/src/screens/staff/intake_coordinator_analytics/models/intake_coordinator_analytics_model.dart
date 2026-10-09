import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorAnalyticsModel extends BaseScreenState<IntakeCoordinatorAnalyticsModel> {
  const IntakeCoordinatorAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
