import 'package:primecare_models/primecare_models.dart';

class SimulationLabSchedulerModel extends BaseScreenState<SimulationLabSchedulerModel> {
  const SimulationLabSchedulerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SimulationLabSchedulerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SimulationLabSchedulerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
