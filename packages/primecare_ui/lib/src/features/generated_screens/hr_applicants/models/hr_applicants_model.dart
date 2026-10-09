import 'package:primecare_models/primecare_models.dart';

class HrApplicantsModel extends BaseScreenState<HrApplicantsModel> {
  const HrApplicantsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrApplicantsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrApplicantsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
