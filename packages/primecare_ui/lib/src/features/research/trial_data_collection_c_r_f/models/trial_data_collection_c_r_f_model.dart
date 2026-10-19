import 'package:primecare_models/primecare_models.dart';

class TrialDataCollectionCRFModel extends BaseScreenState<TrialDataCollectionCRFModel> {
  const TrialDataCollectionCRFModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrialDataCollectionCRFModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrialDataCollectionCRFModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
