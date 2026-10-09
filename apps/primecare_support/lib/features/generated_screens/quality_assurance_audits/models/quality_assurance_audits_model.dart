import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceAuditsModel extends BaseScreenState<QualityAssuranceAuditsModel> {
  const QualityAssuranceAuditsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceAuditsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceAuditsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
