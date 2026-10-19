import 'package:primecare_models/primecare_models.dart';

class CareUpdatesModel extends BaseScreenState<CareUpdatesModel> {
  const CareUpdatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CareUpdatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CareUpdatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
