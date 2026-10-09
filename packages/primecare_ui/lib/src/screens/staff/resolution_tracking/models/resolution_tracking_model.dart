import 'package:primecare_models/primecare_models.dart';

class ResolutionTrackingModel extends BaseScreenState<ResolutionTrackingModel> {
  const ResolutionTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResolutionTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResolutionTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
