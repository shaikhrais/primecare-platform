import 'package:primecare_models/primecare_models.dart';

class FinanceDirectorDashboardModel extends BaseScreenState<FinanceDirectorDashboardModel> {
  const FinanceDirectorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinanceDirectorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinanceDirectorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
