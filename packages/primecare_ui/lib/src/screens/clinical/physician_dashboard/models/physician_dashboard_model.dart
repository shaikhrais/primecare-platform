import 'package:primecare_models/primecare_models.dart';

class PhysicianDashboardModel extends BaseScreenState<PhysicianDashboardModel> {
  const PhysicianDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysicianDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysicianDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
