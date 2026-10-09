import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerDashboardModel extends BaseScreenState<PartnershipManagerDashboardModel> {
  const PartnershipManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
