import 'package:primecare_models/primecare_models.dart';

class CertificationRenewalAlertsModel extends BaseScreenState<CertificationRenewalAlertsModel> {
  const CertificationRenewalAlertsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CertificationRenewalAlertsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CertificationRenewalAlertsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
