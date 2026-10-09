import 'package:primecare_models/primecare_models.dart';

class CarePlanReviewModel extends BaseScreenState<CarePlanReviewModel> {
  const CarePlanReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CarePlanReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CarePlanReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
