import 'package:primecare_models/primecare_models.dart';

class OperationsManagerAttendanceModel extends BaseScreenState<OperationsManagerAttendanceModel> {
  const OperationsManagerAttendanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerAttendanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerAttendanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
