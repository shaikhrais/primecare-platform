import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorDocumentsModel extends BaseScreenState<IntakeCoordinatorDocumentsModel> {
  const IntakeCoordinatorDocumentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorDocumentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorDocumentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
