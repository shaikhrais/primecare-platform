import 'package:primecare_models/primecare_models.dart';

class ReceptionistDashboardModel extends BaseScreenState<ReceptionistDashboardModel> {
  const ReceptionistDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
