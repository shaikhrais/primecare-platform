import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorNewIntakesModel extends BaseScreenState<IntakeCoordinatorNewIntakesModel> {
  const IntakeCoordinatorNewIntakesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorNewIntakesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorNewIntakesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
