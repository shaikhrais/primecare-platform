import 'package:primecare_models/primecare_models.dart';

class FamilyMemberCareUpdatesModel extends BaseScreenState<FamilyMemberCareUpdatesModel> {
  const FamilyMemberCareUpdatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberCareUpdatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberCareUpdatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
