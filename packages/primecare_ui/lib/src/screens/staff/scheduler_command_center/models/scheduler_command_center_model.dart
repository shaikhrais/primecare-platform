import 'package:primecare_models/primecare_models.dart';

class SchedulerCommandCenterModel extends BaseScreenState<SchedulerCommandCenterModel> {
  const SchedulerCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
