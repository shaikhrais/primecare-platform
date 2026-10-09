import 'package:primecare_models/primecare_models.dart';

class HrHiringTrainingStatusModel extends BaseScreenState<HrHiringTrainingStatusModel> {
  const HrHiringTrainingStatusModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringTrainingStatusModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringTrainingStatusModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
