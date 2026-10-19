import 'package:primecare_models/primecare_models.dart';

class HrDirectorCredentialExpiryModel extends BaseScreenState<HrDirectorCredentialExpiryModel> {
  const HrDirectorCredentialExpiryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorCredentialExpiryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorCredentialExpiryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
