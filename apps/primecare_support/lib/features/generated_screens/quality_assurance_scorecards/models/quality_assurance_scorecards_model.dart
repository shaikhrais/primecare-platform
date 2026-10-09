import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceScorecardsModel extends BaseScreenState<QualityAssuranceScorecardsModel> {
  const QualityAssuranceScorecardsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceScorecardsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceScorecardsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
