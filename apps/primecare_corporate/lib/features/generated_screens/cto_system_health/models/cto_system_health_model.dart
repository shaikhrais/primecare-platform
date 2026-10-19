import 'package:primecare_models/primecare_models.dart';

class CtoSystemHealthModel extends BaseScreenState<CtoSystemHealthModel> {
  const CtoSystemHealthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoSystemHealthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoSystemHealthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
