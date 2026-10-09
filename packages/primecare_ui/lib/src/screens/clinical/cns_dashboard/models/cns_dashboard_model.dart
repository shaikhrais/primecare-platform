import 'package:primecare_models/primecare_models.dart';

class CnsDashboardModel extends BaseScreenState<CnsDashboardModel> {
  const CnsDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CnsDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CnsDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
