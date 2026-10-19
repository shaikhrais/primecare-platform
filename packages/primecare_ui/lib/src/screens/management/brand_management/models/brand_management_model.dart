import 'package:primecare_models/primecare_models.dart';

class BrandManagementModel extends BaseScreenState<BrandManagementModel> {
  const BrandManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BrandManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BrandManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
