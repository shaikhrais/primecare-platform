import 'package:primecare_models/primecare_models.dart';

class PatientCarePlanModel extends BaseScreenState<PatientCarePlanModel> {
  const PatientCarePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientCarePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientCarePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
