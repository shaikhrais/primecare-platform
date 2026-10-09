import 'package:primecare_models/primecare_models.dart';

class DriftFindingsModel extends BaseScreenState<DriftFindingsModel> {
  const DriftFindingsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DriftFindingsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DriftFindingsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
