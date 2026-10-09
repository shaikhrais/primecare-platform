import 'package:primecare_models/primecare_models.dart';

class StaffTrainingMatrixModel extends BaseScreenState<StaffTrainingMatrixModel> {
  const StaffTrainingMatrixModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffTrainingMatrixModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffTrainingMatrixModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
