import 'package:primecare_models/primecare_models.dart';

class CtoFeatureAdoptionModel extends BaseScreenState<CtoFeatureAdoptionModel> {
  const CtoFeatureAdoptionModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoFeatureAdoptionModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoFeatureAdoptionModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
