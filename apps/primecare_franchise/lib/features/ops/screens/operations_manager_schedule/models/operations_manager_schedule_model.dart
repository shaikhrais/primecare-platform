import 'package:primecare_models/primecare_models.dart';

class OperationsManagerScheduleModel extends BaseScreenState<OperationsManagerScheduleModel> {
  const OperationsManagerScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
