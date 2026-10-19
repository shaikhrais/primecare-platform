import 'package:primecare_models/primecare_models.dart';

class TicketCenterModel extends BaseScreenState<TicketCenterModel> {
  const TicketCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TicketCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TicketCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
