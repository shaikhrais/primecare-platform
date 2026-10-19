import 'package:primecare_models/primecare_models.dart';

class CeoOrganizationMapModel extends BaseScreenState<CeoOrganizationMapModel> {
  const CeoOrganizationMapModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoOrganizationMapModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoOrganizationMapModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
