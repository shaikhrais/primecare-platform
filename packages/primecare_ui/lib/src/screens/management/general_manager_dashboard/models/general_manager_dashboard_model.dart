import 'package:primecare_models/primecare_models.dart';

class GeneralManagerDashboardModel extends BaseScreenState<GeneralManagerDashboardModel> {
  const GeneralManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GeneralManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GeneralManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
