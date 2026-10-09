import 'package:primecare_models/primecare_models.dart';

class RegionalBdmLeadsModel extends BaseScreenState<RegionalBdmLeadsModel> {
  const RegionalBdmLeadsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmLeadsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmLeadsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
