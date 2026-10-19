import 'package:primecare_models/primecare_models.dart';

class ApiHealthDashboardModel extends BaseScreenState<ApiHealthDashboardModel> {
  const ApiHealthDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ApiHealthDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ApiHealthDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
