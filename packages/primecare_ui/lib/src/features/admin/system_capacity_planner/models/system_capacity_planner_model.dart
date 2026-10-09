import 'package:primecare_models/primecare_models.dart';

class SystemCapacityPlannerModel extends BaseScreenState<SystemCapacityPlannerModel> {
  const SystemCapacityPlannerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SystemCapacityPlannerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SystemCapacityPlannerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
