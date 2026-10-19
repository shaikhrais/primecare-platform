import 'package:primecare_models/primecare_models.dart';

class OwnerDashboardModel extends BaseScreenState<OwnerDashboardModel> {
  const OwnerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OwnerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OwnerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
