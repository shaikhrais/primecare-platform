import 'package:primecare_models/primecare_models.dart';

class StaffingOverviewModel extends BaseScreenState<StaffingOverviewModel> {
  const StaffingOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  StaffingOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => StaffingOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
