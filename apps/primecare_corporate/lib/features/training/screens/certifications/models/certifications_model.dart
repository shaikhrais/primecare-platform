import 'package:primecare_models/primecare_models.dart';

class CertificationsModel extends BaseScreenState<CertificationsModel> {
  const CertificationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CertificationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CertificationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
