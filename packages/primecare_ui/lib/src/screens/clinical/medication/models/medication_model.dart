import 'package:primecare_models/primecare_models.dart';

class MedicationModel extends BaseScreenState<MedicationModel> {
  const MedicationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MedicationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MedicationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
