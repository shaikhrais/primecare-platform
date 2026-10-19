import 'package:primecare_models/primecare_models.dart';

class SystemVerificationComplianceModel extends BaseScreenState<SystemVerificationComplianceModel> {
  const SystemVerificationComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemVerificationComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemVerificationComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
