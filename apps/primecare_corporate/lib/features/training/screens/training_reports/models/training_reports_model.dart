import 'package:primecare_models/primecare_models.dart';

class TrainingReportsModel extends BaseScreenState<TrainingReportsModel> {
  const TrainingReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TrainingReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TrainingReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
