import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorReportsModel extends BaseScreenState<IntakeCoordinatorReportsModel> {
  const IntakeCoordinatorReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
