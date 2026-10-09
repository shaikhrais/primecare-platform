import 'package:primecare_models/primecare_models.dart';

class ComplianceReviewsModel extends BaseScreenState<ComplianceReviewsModel> {
  const ComplianceReviewsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceReviewsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceReviewsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
