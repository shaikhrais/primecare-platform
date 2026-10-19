import 'package:primecare_models/primecare_models.dart';

class ClinicalOperations4KModel extends BaseScreenState<ClinicalOperations4KModel> {
  const ClinicalOperations4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalOperations4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalOperations4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
