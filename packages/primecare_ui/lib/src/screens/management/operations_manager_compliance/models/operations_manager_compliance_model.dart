import 'package:primecare_models/primecare_models.dart';

class OperationsManagerComplianceModel extends BaseScreenState<OperationsManagerComplianceModel> {
  const OperationsManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
