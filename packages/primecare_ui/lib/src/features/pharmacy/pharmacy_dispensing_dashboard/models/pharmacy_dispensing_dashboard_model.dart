import 'package:primecare_models/primecare_models.dart';

class PharmacyDispensingDashboardModel extends BaseScreenState<PharmacyDispensingDashboardModel> {
  const PharmacyDispensingDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PharmacyDispensingDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PharmacyDispensingDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
