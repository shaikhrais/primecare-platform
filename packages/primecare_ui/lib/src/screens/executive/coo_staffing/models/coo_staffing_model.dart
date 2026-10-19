import 'package:primecare_models/primecare_models.dart';

class CooStaffingModel extends BaseScreenState<CooStaffingModel> {
  const CooStaffingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooStaffingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooStaffingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
