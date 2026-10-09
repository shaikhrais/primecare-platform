import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorNewClientIntakeModel extends BaseScreenState<IntakeCoordinatorNewClientIntakeModel> {
  const IntakeCoordinatorNewClientIntakeModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorNewClientIntakeModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorNewClientIntakeModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
