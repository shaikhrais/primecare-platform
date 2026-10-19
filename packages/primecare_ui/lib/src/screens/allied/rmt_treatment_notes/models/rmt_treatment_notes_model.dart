import 'package:primecare_models/primecare_models.dart';

class RmtTreatmentNotesModel extends BaseScreenState<RmtTreatmentNotesModel> {
  const RmtTreatmentNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtTreatmentNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtTreatmentNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
