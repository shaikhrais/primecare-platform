import 'package:primecare_models/primecare_models.dart';

class ComplianceReviewModel extends BaseScreenState<ComplianceReviewModel> {
  const ComplianceReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
