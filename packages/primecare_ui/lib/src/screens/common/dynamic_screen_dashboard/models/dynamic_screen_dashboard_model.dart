import 'package:primecare_models/primecare_models.dart';

class DynamicScreenDashboardModel extends BaseScreenState<DynamicScreenDashboardModel> {
  const DynamicScreenDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DynamicScreenDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DynamicScreenDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
