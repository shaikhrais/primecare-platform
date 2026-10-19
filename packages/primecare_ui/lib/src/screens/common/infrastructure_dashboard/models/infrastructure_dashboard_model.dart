import 'package:primecare_models/primecare_models.dart';

class InfrastructureDashboardModel extends BaseScreenState<InfrastructureDashboardModel> {
  const InfrastructureDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InfrastructureDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InfrastructureDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
