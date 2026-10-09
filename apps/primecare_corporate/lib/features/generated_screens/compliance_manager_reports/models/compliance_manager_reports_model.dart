import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerReportsModel extends BaseScreenState<ComplianceManagerReportsModel> {
  const ComplianceManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
