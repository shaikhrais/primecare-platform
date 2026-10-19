import 'package:primecare_models/primecare_models.dart';

class TrainingManagementModel extends BaseScreenState<TrainingManagementModel> {
  const TrainingManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
