import 'package:primecare_models/primecare_models.dart';

class OutpatientPrescriptionTrackerModel extends BaseScreenState<OutpatientPrescriptionTrackerModel> {
  const OutpatientPrescriptionTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OutpatientPrescriptionTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OutpatientPrescriptionTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
