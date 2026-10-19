import 'package:primecare_models/primecare_models.dart';

class SchedulerCoordinatorBookingRequestsModel extends BaseScreenState<SchedulerCoordinatorBookingRequestsModel> {
  const SchedulerCoordinatorBookingRequestsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerCoordinatorBookingRequestsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerCoordinatorBookingRequestsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
