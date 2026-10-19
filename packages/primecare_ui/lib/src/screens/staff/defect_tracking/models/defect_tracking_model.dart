import 'package:primecare_models/primecare_models.dart';

class DefectTrackingModel extends BaseScreenState<DefectTrackingModel> {
  const DefectTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DefectTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DefectTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
