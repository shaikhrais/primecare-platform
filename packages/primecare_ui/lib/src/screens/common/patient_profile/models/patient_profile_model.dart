import 'package:primecare_models/primecare_models.dart';

class PatientProfileModel extends BaseScreenState<PatientProfileModel> {
  const PatientProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
