import 'package:primecare_models/primecare_models.dart';

class OperationsManagerReportsModel extends BaseScreenState<OperationsManagerReportsModel> {
  const OperationsManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
