import 'package:primecare_models/primecare_models.dart';

class SocialWorkerComplianceModel extends BaseScreenState<SocialWorkerComplianceModel> {
  const SocialWorkerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialWorkerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialWorkerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
