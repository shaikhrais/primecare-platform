import 'package:primecare_models/primecare_models.dart';

class FranchiseOwnerAppointmentsModel extends BaseScreenState<FranchiseOwnerAppointmentsModel> {
  const FranchiseOwnerAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FranchiseOwnerAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
