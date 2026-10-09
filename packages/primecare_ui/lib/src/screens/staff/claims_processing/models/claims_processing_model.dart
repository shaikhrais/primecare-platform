import 'package:primecare_models/primecare_models.dart';

class ClaimsProcessingModel extends BaseScreenState<ClaimsProcessingModel> {
  const ClaimsProcessingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClaimsProcessingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClaimsProcessingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
