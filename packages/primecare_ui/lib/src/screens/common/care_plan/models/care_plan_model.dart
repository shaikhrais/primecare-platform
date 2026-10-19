import 'package:primecare_models/primecare_models.dart';

class CarePlanModel extends BaseScreenState<CarePlanModel> {
  const CarePlanModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CarePlanModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CarePlanModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
