import 'package:primecare_models/primecare_models.dart';

class InfrastructureComplianceModel extends BaseScreenState<InfrastructureComplianceModel> {
  const InfrastructureComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InfrastructureComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InfrastructureComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
