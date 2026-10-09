import 'package:primecare_models/primecare_models.dart';

class ScrumMasterDashboardModel extends BaseScreenState<ScrumMasterDashboardModel> {
  const ScrumMasterDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScrumMasterDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScrumMasterDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
