import 'package:primecare_models/primecare_models.dart';

class PatientDocumentsModel extends BaseScreenState<PatientDocumentsModel> {
  const PatientDocumentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientDocumentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientDocumentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
