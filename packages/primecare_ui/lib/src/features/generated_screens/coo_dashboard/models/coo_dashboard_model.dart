import 'package:primecare_models/primecare_models.dart';

class CooDashboardModel extends BaseScreenState<CooDashboardModel> {
  const CooDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
