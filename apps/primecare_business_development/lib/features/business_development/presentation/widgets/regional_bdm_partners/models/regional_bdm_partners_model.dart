import 'package:primecare_models/primecare_models.dart';

class RegionalBdmPartnersModel extends BaseScreenState<RegionalBdmPartnersModel> {
  const RegionalBdmPartnersModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmPartnersModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmPartnersModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
