import 'package:primecare_models/primecare_models.dart';

class ScheduleModel extends BaseScreenState<ScheduleModel> {
  const ScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
