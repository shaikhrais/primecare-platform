import 'package:primecare_models/primecare_models.dart';

class OnboardingModel extends BaseScreenState<OnboardingModel> {
  const OnboardingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OnboardingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OnboardingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
