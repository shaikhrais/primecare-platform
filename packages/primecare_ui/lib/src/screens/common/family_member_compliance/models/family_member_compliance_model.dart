import 'package:primecare_models/primecare_models.dart';

class FamilyMemberComplianceModel extends BaseScreenState<FamilyMemberComplianceModel> {
  const FamilyMemberComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
