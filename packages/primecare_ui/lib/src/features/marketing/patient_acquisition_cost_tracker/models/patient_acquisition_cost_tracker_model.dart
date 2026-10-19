import 'package:primecare_models/primecare_models.dart';

class PatientAcquisitionCostTrackerModel extends BaseScreenState<PatientAcquisitionCostTrackerModel> {
  const PatientAcquisitionCostTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientAcquisitionCostTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientAcquisitionCostTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
