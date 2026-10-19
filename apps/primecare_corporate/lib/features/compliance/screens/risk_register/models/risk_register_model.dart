import 'package:primecare_models/primecare_models.dart';

class RiskRegisterModel extends BaseScreenState<RiskRegisterModel> {
  const RiskRegisterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RiskRegisterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RiskRegisterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
