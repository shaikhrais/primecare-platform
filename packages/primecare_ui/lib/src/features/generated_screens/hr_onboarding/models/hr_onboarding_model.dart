import 'package:primecare_models/primecare_models.dart';

class HrOnboardingModel extends BaseScreenState<HrOnboardingModel> {
  const HrOnboardingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrOnboardingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrOnboardingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
