import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorComplianceModel extends BaseScreenState<IntakeCoordinatorComplianceModel> {
  const IntakeCoordinatorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
