import 'package:primecare_models/primecare_models.dart';

class ChiropractorDashboardModel extends BaseScreenState<ChiropractorDashboardModel> {
  const ChiropractorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
