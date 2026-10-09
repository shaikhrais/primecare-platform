import 'package:primecare_models/primecare_models.dart';

class FinancialDashboardModel extends BaseScreenState<FinancialDashboardModel> {
  const FinancialDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinancialDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinancialDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
