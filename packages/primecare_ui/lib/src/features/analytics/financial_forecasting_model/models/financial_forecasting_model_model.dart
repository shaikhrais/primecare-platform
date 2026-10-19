import 'package:primecare_models/primecare_models.dart';

class FinancialForecastingModelModel extends BaseScreenState<FinancialForecastingModelModel> {
  const FinancialForecastingModelModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinancialForecastingModelModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinancialForecastingModelModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
