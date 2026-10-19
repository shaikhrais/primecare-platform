import 'package:primecare_models/primecare_models.dart';

class PremiumConciergeDashboardModel extends BaseScreenState<PremiumConciergeDashboardModel> {
  const PremiumConciergeDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PremiumConciergeDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PremiumConciergeDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
