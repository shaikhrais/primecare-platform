import 'package:primecare_models/primecare_models.dart';

class HipaaAuditDashboardModel extends BaseScreenState<HipaaAuditDashboardModel> {
  const HipaaAuditDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HipaaAuditDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HipaaAuditDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
