import 'package:primecare_models/primecare_models.dart';

class CtoIntegrationsModel extends BaseScreenState<CtoIntegrationsModel> {
  const CtoIntegrationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoIntegrationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoIntegrationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
