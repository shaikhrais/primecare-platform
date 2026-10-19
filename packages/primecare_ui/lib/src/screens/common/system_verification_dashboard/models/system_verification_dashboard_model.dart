import 'package:primecare_models/primecare_models.dart';

class SystemVerificationDashboardModel extends BaseScreenState<SystemVerificationDashboardModel> {
  const SystemVerificationDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemVerificationDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemVerificationDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
