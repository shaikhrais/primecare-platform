import 'package:primecare_models/primecare_models.dart';

class OperationsManagerShiftsModel extends BaseScreenState<OperationsManagerShiftsModel> {
  const OperationsManagerShiftsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerShiftsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerShiftsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
