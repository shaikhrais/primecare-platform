import 'package:primecare_models/primecare_models.dart';

class FamilyMemberAnalyticsModel extends BaseScreenState<FamilyMemberAnalyticsModel> {
  const FamilyMemberAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
