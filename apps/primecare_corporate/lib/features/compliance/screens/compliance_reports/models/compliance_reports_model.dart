import 'package:primecare_models/primecare_models.dart';

class ComplianceReportsModel extends BaseScreenState<ComplianceReportsModel> {
  const ComplianceReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
