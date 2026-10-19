import 'package:primecare_models/primecare_models.dart';

class CertificationTrackingModel extends BaseScreenState<CertificationTrackingModel> {
  const CertificationTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CertificationTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CertificationTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
