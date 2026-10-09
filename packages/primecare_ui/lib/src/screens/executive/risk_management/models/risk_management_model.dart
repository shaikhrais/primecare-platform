import 'package:primecare_models/primecare_models.dart';

class RiskManagementModel extends BaseScreenState<RiskManagementModel> {
  const RiskManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RiskManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RiskManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
