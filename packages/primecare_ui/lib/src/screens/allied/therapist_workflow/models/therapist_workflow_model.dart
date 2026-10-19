import 'package:primecare_models/primecare_models.dart';

class TherapistWorkflowModel extends BaseScreenState<TherapistWorkflowModel> {
  const TherapistWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TherapistWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TherapistWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
