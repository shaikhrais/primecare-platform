import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistDashboardModel extends BaseScreenState<PhysiotherapistDashboardModel> {
  const PhysiotherapistDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
