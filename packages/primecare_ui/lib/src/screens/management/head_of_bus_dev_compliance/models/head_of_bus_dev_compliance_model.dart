import 'package:primecare_models/primecare_models.dart';

class HeadOfBusDevComplianceModel extends BaseScreenState<HeadOfBusDevComplianceModel> {
  const HeadOfBusDevComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfBusDevComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
