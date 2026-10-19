import 'package:primecare_models/primecare_models.dart';

class TenantConfigurationModel extends BaseScreenState<TenantConfigurationModel> {
  const TenantConfigurationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TenantConfigurationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TenantConfigurationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
