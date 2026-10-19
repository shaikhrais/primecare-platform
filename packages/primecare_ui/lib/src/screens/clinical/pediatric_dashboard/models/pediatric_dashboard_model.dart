import 'package:primecare_models/primecare_models.dart';

class PediatricDashboardModel extends BaseScreenState<PediatricDashboardModel> {
  const PediatricDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PediatricDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PediatricDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
