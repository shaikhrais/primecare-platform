import 'package:primecare_models/primecare_models.dart';

class HrHiringApplicantsModel extends BaseScreenState<HrHiringApplicantsModel> {
  const HrHiringApplicantsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringApplicantsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringApplicantsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
