import 'package:primecare_models/primecare_models.dart';

class CaregiverScheduleModel extends BaseScreenState<CaregiverScheduleModel> {
  const CaregiverScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
