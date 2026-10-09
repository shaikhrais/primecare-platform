import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerAnalyticsModel extends BaseScreenState<ComplianceManagerAnalyticsModel> {
  const ComplianceManagerAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
