import 'package:primecare_models/primecare_models.dart';

class OperationsManagerStaffCoordinationModel extends BaseScreenState<OperationsManagerStaffCoordinationModel> {
  const OperationsManagerStaffCoordinationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OperationsManagerStaffCoordinationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OperationsManagerStaffCoordinationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
