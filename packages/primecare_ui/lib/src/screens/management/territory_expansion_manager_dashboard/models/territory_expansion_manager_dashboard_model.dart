import 'package:primecare_models/primecare_models.dart';

class TerritoryExpansionManagerDashboardModel extends BaseScreenState<TerritoryExpansionManagerDashboardModel> {
  const TerritoryExpansionManagerDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TerritoryExpansionManagerDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
