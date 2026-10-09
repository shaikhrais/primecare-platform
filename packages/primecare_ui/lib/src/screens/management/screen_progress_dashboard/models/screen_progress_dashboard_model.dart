import 'package:primecare_models/primecare_models.dart';

class ScreenProgressDashboardModel extends BaseScreenState<ScreenProgressDashboardModel> {
  const ScreenProgressDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScreenProgressDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScreenProgressDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
