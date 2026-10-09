import 'package:primecare_models/primecare_models.dart';

class CrisisProtocolTriggerModel extends BaseScreenState<CrisisProtocolTriggerModel> {
  const CrisisProtocolTriggerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CrisisProtocolTriggerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CrisisProtocolTriggerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
