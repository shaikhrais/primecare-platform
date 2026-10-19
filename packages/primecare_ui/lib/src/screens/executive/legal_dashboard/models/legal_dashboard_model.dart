import 'package:primecare_models/primecare_models.dart';

class LegalDashboardModel extends BaseScreenState<LegalDashboardModel> {
  const LegalDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LegalDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LegalDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
