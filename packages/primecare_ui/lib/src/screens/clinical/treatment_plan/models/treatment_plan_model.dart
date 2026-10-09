import 'package:primecare_models/primecare_models.dart';

class TreatmentPlanModel extends BaseScreenState<TreatmentPlanModel> {
  const TreatmentPlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TreatmentPlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TreatmentPlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
