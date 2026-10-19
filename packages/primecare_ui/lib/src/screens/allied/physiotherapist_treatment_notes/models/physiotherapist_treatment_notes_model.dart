import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistTreatmentNotesModel extends BaseScreenState<PhysiotherapistTreatmentNotesModel> {
  const PhysiotherapistTreatmentNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistTreatmentNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistTreatmentNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
