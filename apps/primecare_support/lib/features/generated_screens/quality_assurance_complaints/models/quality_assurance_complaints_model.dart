import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceComplaintsModel extends BaseScreenState<QualityAssuranceComplaintsModel> {
  const QualityAssuranceComplaintsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceComplaintsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceComplaintsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
