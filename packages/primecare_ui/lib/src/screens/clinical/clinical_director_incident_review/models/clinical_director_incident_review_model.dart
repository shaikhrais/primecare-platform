import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorIncidentReviewModel extends BaseScreenState<ClinicalDirectorIncidentReviewModel> {
  const ClinicalDirectorIncidentReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorIncidentReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorIncidentReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
