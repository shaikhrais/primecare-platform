import 'package:primecare_models/primecare_models.dart';

class RpnIncidentReviewModel extends BaseScreenState<RpnIncidentReviewModel> {
  const RpnIncidentReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnIncidentReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnIncidentReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
