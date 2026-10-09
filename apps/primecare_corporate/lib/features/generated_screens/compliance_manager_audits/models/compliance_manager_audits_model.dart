import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerAuditsModel extends BaseScreenState<ComplianceManagerAuditsModel> {
  const ComplianceManagerAuditsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerAuditsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerAuditsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
