import 'package:primecare_models/primecare_models.dart';

class ChiropracticProgressTrackingModel extends BaseScreenState<ChiropracticProgressTrackingModel> {
  const ChiropracticProgressTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropracticProgressTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropracticProgressTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
