import 'package:primecare_models/primecare_models.dart';

class DynamicDashboardModel extends BaseScreenState<DynamicDashboardModel> {
  const DynamicDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DynamicDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DynamicDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
