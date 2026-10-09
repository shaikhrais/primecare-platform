import 'package:primecare_models/primecare_models.dart';

class FamilyMemberProfileModel extends BaseScreenState<FamilyMemberProfileModel> {
  const FamilyMemberProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
