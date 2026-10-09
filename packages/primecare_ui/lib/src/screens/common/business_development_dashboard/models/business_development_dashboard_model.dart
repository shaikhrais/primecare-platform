import 'package:primecare_models/primecare_models.dart';

class BusinessDevelopmentDashboardModel extends BaseScreenState<BusinessDevelopmentDashboardModel> {
  const BusinessDevelopmentDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BusinessDevelopmentDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
