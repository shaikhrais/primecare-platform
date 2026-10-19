import 'package:primecare_models/primecare_models.dart';

class SocialWorkerDashboardModel extends BaseScreenState<SocialWorkerDashboardModel> {
  const SocialWorkerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialWorkerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialWorkerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
