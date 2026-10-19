import 'package:primecare_models/primecare_models.dart';

class InpatientPharmacyQueueModel extends BaseScreenState<InpatientPharmacyQueueModel> {
  const InpatientPharmacyQueueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  InpatientPharmacyQueueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => InpatientPharmacyQueueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
