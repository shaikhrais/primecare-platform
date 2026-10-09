import 'package:primecare_models/primecare_models.dart';

class ResidencyProgramTrackerModel extends BaseScreenState<ResidencyProgramTrackerModel> {
  const ResidencyProgramTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResidencyProgramTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResidencyProgramTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
