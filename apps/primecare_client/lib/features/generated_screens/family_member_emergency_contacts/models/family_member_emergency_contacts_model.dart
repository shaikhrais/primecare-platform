import 'package:primecare_models/primecare_models.dart';

class FamilyMemberEmergencyContactsModel extends BaseScreenState<FamilyMemberEmergencyContactsModel> {
  const FamilyMemberEmergencyContactsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberEmergencyContactsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberEmergencyContactsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
