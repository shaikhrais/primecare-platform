import 'package:primecare_models/primecare_models.dart';

class RegionalBdmWorkflowModel extends BaseScreenState<RegionalBdmWorkflowModel> {
  const RegionalBdmWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
