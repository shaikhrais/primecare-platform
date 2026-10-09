import 'package:primecare_models/primecare_models.dart';

class UnknownDashboardModel extends BaseScreenState<UnknownDashboardModel> {
  const UnknownDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  UnknownDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => UnknownDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
