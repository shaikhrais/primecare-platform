import 'package:primecare_models/primecare_models.dart';

class IntakeDashboardModel extends BaseScreenState<IntakeDashboardModel> {
  const IntakeDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
