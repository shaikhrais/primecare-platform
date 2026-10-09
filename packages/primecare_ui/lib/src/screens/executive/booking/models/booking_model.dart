import 'package:primecare_models/primecare_models.dart';

class BookingModel extends BaseScreenState<BookingModel> {
  const BookingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BookingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BookingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
