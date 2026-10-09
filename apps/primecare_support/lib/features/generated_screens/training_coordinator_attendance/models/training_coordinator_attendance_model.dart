import 'package:primecare_models/primecare_models.dart';

class TrainingCoordinatorAttendanceModel extends BaseScreenState<TrainingCoordinatorAttendanceModel> {
  const TrainingCoordinatorAttendanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingCoordinatorAttendanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorAttendanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
