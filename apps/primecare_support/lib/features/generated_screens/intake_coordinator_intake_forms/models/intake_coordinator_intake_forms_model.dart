import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorIntakeFormsModel extends BaseScreenState<IntakeCoordinatorIntakeFormsModel> {
  const IntakeCoordinatorIntakeFormsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorIntakeFormsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorIntakeFormsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
