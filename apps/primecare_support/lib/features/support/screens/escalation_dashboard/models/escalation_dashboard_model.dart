import 'package:primecare_models/primecare_models.dart';

class EscalationDashboardModel extends BaseScreenState<EscalationDashboardModel> {
  const EscalationDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EscalationDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EscalationDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
