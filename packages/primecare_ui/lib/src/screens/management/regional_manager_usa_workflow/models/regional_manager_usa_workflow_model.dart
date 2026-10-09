import 'package:primecare_models/primecare_models.dart';

class RegionalManagerUsaWorkflowModel extends BaseScreenState<RegionalManagerUsaWorkflowModel> {
  const RegionalManagerUsaWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalManagerUsaWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
