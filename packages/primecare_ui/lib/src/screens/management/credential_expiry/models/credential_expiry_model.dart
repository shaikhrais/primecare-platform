import 'package:primecare_models/primecare_models.dart';

class CredentialExpiryModel extends BaseScreenState<CredentialExpiryModel> {
  const CredentialExpiryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CredentialExpiryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CredentialExpiryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
