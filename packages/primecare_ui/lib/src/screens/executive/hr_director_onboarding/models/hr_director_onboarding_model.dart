import 'package:primecare_models/primecare_models.dart';

class HrDirectorOnboardingModel extends BaseScreenState<HrDirectorOnboardingModel> {
  const HrDirectorOnboardingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorOnboardingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorOnboardingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
