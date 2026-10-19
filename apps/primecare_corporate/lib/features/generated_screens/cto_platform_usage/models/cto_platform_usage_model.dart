import 'package:primecare_models/primecare_models.dart';

class CtoPlatformUsageModel extends BaseScreenState<CtoPlatformUsageModel> {
  const CtoPlatformUsageModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoPlatformUsageModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoPlatformUsageModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
