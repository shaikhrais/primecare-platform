import 'package:primecare_models/primecare_models.dart';

class OperationsCommandCenterModel extends BaseScreenState<OperationsCommandCenterModel> {
  const OperationsCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
