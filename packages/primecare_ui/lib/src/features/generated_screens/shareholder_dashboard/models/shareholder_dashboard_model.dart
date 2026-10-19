import 'package:primecare_models/primecare_models.dart';

class ShareholderDashboardModel extends BaseScreenState<ShareholderDashboardModel> {
  const ShareholderDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShareholderDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShareholderDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
