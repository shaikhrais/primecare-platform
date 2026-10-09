import 'package:primecare_models/primecare_models.dart';

class FamilyMemberBillingModel extends BaseScreenState<FamilyMemberBillingModel> {
  const FamilyMemberBillingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberBillingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberBillingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
