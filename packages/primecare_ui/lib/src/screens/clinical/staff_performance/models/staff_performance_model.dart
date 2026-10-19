import 'package:primecare_models/primecare_models.dart';

class StaffPerformanceModel extends BaseScreenState<StaffPerformanceModel> {
  const StaffPerformanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffPerformanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffPerformanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
