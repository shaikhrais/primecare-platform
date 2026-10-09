import 'package:primecare_models/primecare_models.dart';

class IncidentReviewModel extends BaseScreenState<IncidentReviewModel> {
  const IncidentReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IncidentReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IncidentReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
