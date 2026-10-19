import 'package:primecare_models/primecare_models.dart';

class SupportDashboardModel extends BaseScreenState<SupportDashboardModel> {
  const SupportDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SupportDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SupportDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
