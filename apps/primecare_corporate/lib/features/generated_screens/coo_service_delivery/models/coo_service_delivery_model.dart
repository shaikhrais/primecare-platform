import 'package:primecare_models/primecare_models.dart';

class CooServiceDeliveryModel extends BaseScreenState<CooServiceDeliveryModel> {
  const CooServiceDeliveryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooServiceDeliveryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooServiceDeliveryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
