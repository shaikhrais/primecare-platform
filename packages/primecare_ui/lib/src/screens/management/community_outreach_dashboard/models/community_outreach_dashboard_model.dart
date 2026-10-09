import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachDashboardModel extends BaseScreenState<CommunityOutreachDashboardModel> {
  const CommunityOutreachDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
