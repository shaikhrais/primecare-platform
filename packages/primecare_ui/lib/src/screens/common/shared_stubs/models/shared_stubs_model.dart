import 'package:primecare_models/primecare_models.dart';

class SharedStubsModel extends BaseScreenState<SharedStubsModel> {
  const SharedStubsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SharedStubsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SharedStubsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
