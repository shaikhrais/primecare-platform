import 'package:primecare_models/primecare_models.dart';

class RnAssessmentsModel extends BaseScreenState<RnAssessmentsModel> {
  const RnAssessmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnAssessmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnAssessmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
