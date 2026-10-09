import 'package:primecare_models/primecare_models.dart';

class RuntimeVerificationModel extends BaseScreenState<RuntimeVerificationModel> {
  const RuntimeVerificationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RuntimeVerificationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RuntimeVerificationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
