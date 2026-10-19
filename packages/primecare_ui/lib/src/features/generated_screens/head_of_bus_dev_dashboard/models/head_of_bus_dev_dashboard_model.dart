import 'package:primecare_models/primecare_models.dart';

class HeadOfBusDevDashboardModel extends BaseScreenState<HeadOfBusDevDashboardModel> {
  const HeadOfBusDevDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfBusDevDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
