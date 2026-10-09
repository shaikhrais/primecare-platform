import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorSchedulingModel extends BaseScreenState<IntakeCoordinatorSchedulingModel> {
  const IntakeCoordinatorSchedulingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorSchedulingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorSchedulingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
