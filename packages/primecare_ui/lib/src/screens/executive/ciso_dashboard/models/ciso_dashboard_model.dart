import 'package:primecare_models/primecare_models.dart';

class CisoDashboardModel extends BaseScreenState<CisoDashboardModel> {
  const CisoDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CisoDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CisoDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
