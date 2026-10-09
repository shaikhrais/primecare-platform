import 'package:primecare_models/primecare_models.dart';

class HrDirectorTrainingModel extends BaseScreenState<HrDirectorTrainingModel> {
  const HrDirectorTrainingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorTrainingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorTrainingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
