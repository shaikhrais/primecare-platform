import 'package:primecare_models/primecare_models.dart';

class RegionalManagerOntarioDashboardModel extends BaseScreenState<RegionalManagerOntarioDashboardModel> {
  const RegionalManagerOntarioDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalManagerOntarioDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalManagerOntarioDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
