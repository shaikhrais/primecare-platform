import 'package:primecare_models/primecare_models.dart';

class CfoProfitabilityModel extends BaseScreenState<CfoProfitabilityModel> {
  const CfoProfitabilityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoProfitabilityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoProfitabilityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
