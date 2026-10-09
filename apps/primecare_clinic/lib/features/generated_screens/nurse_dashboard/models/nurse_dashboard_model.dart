import 'package:primecare_models/primecare_models.dart';

class NurseDashboardModel extends BaseScreenState<NurseDashboardModel> {
  const NurseDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  NurseDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => NurseDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
