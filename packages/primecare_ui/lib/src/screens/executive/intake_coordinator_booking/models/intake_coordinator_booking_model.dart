import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorBookingModel extends BaseScreenState<IntakeCoordinatorBookingModel> {
  const IntakeCoordinatorBookingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorBookingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorBookingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
