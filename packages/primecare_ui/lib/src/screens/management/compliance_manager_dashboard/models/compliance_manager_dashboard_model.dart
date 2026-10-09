import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerDashboardModel extends BaseScreenState<ComplianceManagerDashboardModel> {
  const ComplianceManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
