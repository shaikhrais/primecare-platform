import 'package:primecare_models/primecare_models.dart';

class MedicationAdministrationModel extends BaseScreenState<MedicationAdministrationModel> {
  const MedicationAdministrationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MedicationAdministrationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MedicationAdministrationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
