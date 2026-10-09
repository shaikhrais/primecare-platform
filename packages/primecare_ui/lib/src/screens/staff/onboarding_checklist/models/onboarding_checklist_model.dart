import 'package:primecare_models/primecare_models.dart';

class OnboardingChecklistModel extends BaseScreenState<OnboardingChecklistModel> {
  const OnboardingChecklistModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OnboardingChecklistModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OnboardingChecklistModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
