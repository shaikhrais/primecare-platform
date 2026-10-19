import 'package:primecare_models/primecare_models.dart';

class PatientPaymentsModel extends BaseScreenState<PatientPaymentsModel> {
  const PatientPaymentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientPaymentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientPaymentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
