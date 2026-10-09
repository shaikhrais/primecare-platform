import 'package:primecare_models/primecare_models.dart';

class GuestDashboardModel extends BaseScreenState<GuestDashboardModel> {
  const GuestDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GuestDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GuestDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
