import 'package:primecare_models/primecare_models.dart';

class ChiropractorTreatmentNotesModel extends BaseScreenState<ChiropractorTreatmentNotesModel> {
  const ChiropractorTreatmentNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorTreatmentNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorTreatmentNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
