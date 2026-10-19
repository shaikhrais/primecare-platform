import 'package:primecare_models/primecare_models.dart';

class CaregiverTasksModel extends BaseScreenState<CaregiverTasksModel> {
  const CaregiverTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CaregiverTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CaregiverTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
