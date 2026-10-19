import 'package:primecare_models/primecare_models.dart';

class PswCareDashboardModel extends BaseScreenState<PswCareDashboardModel> {
  const PswCareDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswCareDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswCareDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
