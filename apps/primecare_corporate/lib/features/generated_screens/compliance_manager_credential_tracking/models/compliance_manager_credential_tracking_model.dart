import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerCredentialTrackingModel extends BaseScreenState<ComplianceManagerCredentialTrackingModel> {
  const ComplianceManagerCredentialTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerCredentialTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerCredentialTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
