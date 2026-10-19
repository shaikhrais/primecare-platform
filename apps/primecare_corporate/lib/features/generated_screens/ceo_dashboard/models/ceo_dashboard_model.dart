import 'package:primecare_models/primecare_models.dart';

class CeoDashboardModel extends BaseScreenState<CeoDashboardModel> {
  const CeoDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
