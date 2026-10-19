import 'package:primecare_models/primecare_models.dart';

class CertificatesModel extends BaseScreenState<CertificatesModel> {
  const CertificatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CertificatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CertificatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
