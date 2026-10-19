import 'package:primecare_models/primecare_models.dart';

class ServiceQualityModel extends BaseScreenState<ServiceQualityModel> {
  const ServiceQualityModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ServiceQualityModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ServiceQualityModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
