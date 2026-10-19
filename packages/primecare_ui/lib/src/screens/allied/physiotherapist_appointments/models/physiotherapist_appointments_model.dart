import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistAppointmentsModel extends BaseScreenState<PhysiotherapistAppointmentsModel> {
  const PhysiotherapistAppointmentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistAppointmentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistAppointmentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
