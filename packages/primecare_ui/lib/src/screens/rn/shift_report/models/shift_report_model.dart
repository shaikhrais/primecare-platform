import 'package:primecare_models/primecare_models.dart';

class ShiftReportModel extends BaseScreenState<ShiftReportModel> {
  const ShiftReportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShiftReportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShiftReportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
