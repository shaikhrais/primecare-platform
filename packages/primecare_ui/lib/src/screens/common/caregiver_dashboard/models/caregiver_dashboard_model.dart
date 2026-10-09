import 'package:primecare_models/primecare_models.dart';

class CaregiverDashboardModel extends BaseScreenState<CaregiverDashboardModel> {
  const CaregiverDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
