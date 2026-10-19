import 'package:primecare_models/primecare_models.dart';

class SchedulingDashboardModel extends BaseScreenState<SchedulingDashboardModel> {
  const SchedulingDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulingDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulingDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
