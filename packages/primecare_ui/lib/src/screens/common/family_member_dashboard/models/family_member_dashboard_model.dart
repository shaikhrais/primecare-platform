import 'package:primecare_models/primecare_models.dart';

class FamilyMemberDashboardModel extends BaseScreenState<FamilyMemberDashboardModel> {
  const FamilyMemberDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
