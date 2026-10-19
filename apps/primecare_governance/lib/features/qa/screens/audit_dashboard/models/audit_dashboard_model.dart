import 'package:primecare_models/primecare_models.dart';

class AuditDashboardModel extends BaseScreenState<AuditDashboardModel> {
  const AuditDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
