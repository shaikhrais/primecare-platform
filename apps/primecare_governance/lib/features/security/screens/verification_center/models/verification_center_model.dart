import 'package:primecare_models/primecare_models.dart';

class VerificationCenterModel extends BaseScreenState<VerificationCenterModel> {
  const VerificationCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VerificationCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VerificationCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
