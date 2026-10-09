import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerIncidentReviewModel extends BaseScreenState<ComplianceManagerIncidentReviewModel> {
  const ComplianceManagerIncidentReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerIncidentReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerIncidentReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
