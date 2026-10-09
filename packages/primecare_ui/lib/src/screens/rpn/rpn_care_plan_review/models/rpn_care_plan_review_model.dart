import 'package:primecare_models/primecare_models.dart';

class RpnCarePlanReviewModel extends BaseScreenState<RpnCarePlanReviewModel> {
  const RpnCarePlanReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnCarePlanReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnCarePlanReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
