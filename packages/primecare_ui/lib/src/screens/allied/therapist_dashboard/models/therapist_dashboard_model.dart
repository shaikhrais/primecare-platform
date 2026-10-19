import 'package:primecare_models/primecare_models.dart';

class TherapistDashboardModel extends BaseScreenState<TherapistDashboardModel> {
  const TherapistDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TherapistDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TherapistDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
