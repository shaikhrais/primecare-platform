import 'package:primecare_models/primecare_models.dart';

class RnCarePlanReviewModel extends BaseScreenState<RnCarePlanReviewModel> {
  const RnCarePlanReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnCarePlanReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnCarePlanReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
