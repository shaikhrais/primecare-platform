import 'package:primecare_models/primecare_models.dart';

class FamilyEmergencyContactsModel extends BaseScreenState<FamilyEmergencyContactsModel> {
  const FamilyEmergencyContactsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyEmergencyContactsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyEmergencyContactsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
