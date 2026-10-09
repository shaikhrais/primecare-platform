import 'package:primecare_models/primecare_models.dart';

class SystemDashboardModel extends BaseScreenState<SystemDashboardModel> {
  const SystemDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
