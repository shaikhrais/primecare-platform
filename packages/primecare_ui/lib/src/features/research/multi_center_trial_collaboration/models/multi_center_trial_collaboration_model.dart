import 'package:primecare_models/primecare_models.dart';

class MultiCenterTrialCollaborationModel extends BaseScreenState<MultiCenterTrialCollaborationModel> {
  const MultiCenterTrialCollaborationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MultiCenterTrialCollaborationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MultiCenterTrialCollaborationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
