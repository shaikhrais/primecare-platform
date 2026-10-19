import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorEligibilityModel extends BaseScreenState<IntakeCoordinatorEligibilityModel> {
  const IntakeCoordinatorEligibilityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorEligibilityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorEligibilityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
