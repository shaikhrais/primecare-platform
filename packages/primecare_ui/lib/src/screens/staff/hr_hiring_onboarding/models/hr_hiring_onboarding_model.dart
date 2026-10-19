import 'package:primecare_models/primecare_models.dart';

class HrHiringOnboardingModel extends BaseScreenState<HrHiringOnboardingModel> {
  const HrHiringOnboardingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringOnboardingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringOnboardingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
