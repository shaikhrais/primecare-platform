import 'package:primecare_models/primecare_models.dart';

class CalendarManagementModel extends BaseScreenState<CalendarManagementModel> {
  const CalendarManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CalendarManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CalendarManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
