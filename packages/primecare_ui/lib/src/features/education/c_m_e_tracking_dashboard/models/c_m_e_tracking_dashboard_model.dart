import 'package:primecare_models/primecare_models.dart';

class CMETrackingDashboardModel extends BaseScreenState<CMETrackingDashboardModel> {
  const CMETrackingDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CMETrackingDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CMETrackingDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
