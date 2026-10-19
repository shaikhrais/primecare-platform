import 'package:primecare_models/primecare_models.dart';

class AttendanceModel extends BaseScreenState<AttendanceModel> {
  const AttendanceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AttendanceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AttendanceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
