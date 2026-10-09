import 'package:primecare_models/primecare_models.dart';

class ExecutiveCommandCenterModel extends BaseScreenState<ExecutiveCommandCenterModel> {
  const ExecutiveCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ExecutiveCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ExecutiveCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
