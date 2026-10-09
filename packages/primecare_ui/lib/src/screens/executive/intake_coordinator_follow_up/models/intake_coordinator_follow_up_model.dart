import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorFollowUpModel extends BaseScreenState<IntakeCoordinatorFollowUpModel> {
  const IntakeCoordinatorFollowUpModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorFollowUpModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorFollowUpModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
