import 'package:primecare_models/primecare_models.dart';

class CaregiverVisitNotesModel extends BaseScreenState<CaregiverVisitNotesModel> {
  const CaregiverVisitNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverVisitNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverVisitNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
