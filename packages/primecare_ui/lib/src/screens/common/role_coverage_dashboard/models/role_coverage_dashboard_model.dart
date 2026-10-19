import 'package:primecare_models/primecare_models.dart';

class RoleCoverageDashboardModel extends BaseScreenState<RoleCoverageDashboardModel> {
  const RoleCoverageDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RoleCoverageDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RoleCoverageDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
