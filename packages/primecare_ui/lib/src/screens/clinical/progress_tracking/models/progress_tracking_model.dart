import 'package:primecare_models/primecare_models.dart';

class ProgressTrackingModel extends BaseScreenState<ProgressTrackingModel> {
  const ProgressTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ProgressTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ProgressTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
