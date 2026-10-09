import 'package:primecare_models/primecare_models.dart';

class SchedulerConflictsModel extends BaseScreenState<SchedulerConflictsModel> {
  const SchedulerConflictsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerConflictsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerConflictsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
