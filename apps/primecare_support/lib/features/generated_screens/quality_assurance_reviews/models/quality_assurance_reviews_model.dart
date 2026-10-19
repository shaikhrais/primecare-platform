import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceReviewsModel extends BaseScreenState<QualityAssuranceReviewsModel> {
  const QualityAssuranceReviewsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceReviewsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceReviewsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
