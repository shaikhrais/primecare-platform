import 'package:primecare_models/primecare_models.dart';

class FamilyMemberWorkflowModel extends BaseScreenState<FamilyMemberWorkflowModel> {
  const FamilyMemberWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
