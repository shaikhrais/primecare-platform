import 'package:primecare_models/primecare_models.dart';

class ClinicalReferenceModel extends BaseScreenState<ClinicalReferenceModel> {
  const ClinicalReferenceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalReferenceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalReferenceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
