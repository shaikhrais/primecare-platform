import 'package:primecare_models/primecare_models.dart';

class SchedulerBookingRequestsModel extends BaseScreenState<SchedulerBookingRequestsModel> {
  const SchedulerBookingRequestsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulerBookingRequestsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulerBookingRequestsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
