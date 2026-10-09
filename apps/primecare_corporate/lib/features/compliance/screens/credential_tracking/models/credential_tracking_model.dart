import 'package:primecare_models/primecare_models.dart';

class CredentialTrackingModel extends BaseScreenState<CredentialTrackingModel> {
  const CredentialTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CredentialTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CredentialTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
