import 'package:primecare_models/primecare_models.dart';

class CooStaffingEfficiencyModel extends BaseScreenState<CooStaffingEfficiencyModel> {
  const CooStaffingEfficiencyModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooStaffingEfficiencyModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooStaffingEfficiencyModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
