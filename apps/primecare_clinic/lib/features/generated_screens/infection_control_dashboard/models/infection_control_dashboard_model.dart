import 'package:primecare_models/primecare_models.dart';

class InfectionControlDashboardModel extends BaseScreenState<InfectionControlDashboardModel> {
  const InfectionControlDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InfectionControlDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InfectionControlDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
