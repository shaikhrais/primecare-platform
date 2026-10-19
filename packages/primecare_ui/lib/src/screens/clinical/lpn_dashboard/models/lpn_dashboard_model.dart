import 'package:primecare_models/primecare_models.dart';

class LpnDashboardModel extends BaseScreenState<LpnDashboardModel> {
  const LpnDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LpnDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LpnDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
