import 'package:primecare_models/primecare_models.dart';

class OfferManagementModel extends BaseScreenState<OfferManagementModel> {
  const OfferManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OfferManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OfferManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
