import 'package:primecare_models/primecare_models.dart';

class PaymentTrackingModel extends BaseScreenState<PaymentTrackingModel> {
  const PaymentTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PaymentTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PaymentTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
