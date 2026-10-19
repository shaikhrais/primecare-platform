import 'package:primecare_models/primecare_models.dart';

class MedicationReconciliationToolModel extends BaseScreenState<MedicationReconciliationToolModel> {
  const MedicationReconciliationToolModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MedicationReconciliationToolModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MedicationReconciliationToolModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
