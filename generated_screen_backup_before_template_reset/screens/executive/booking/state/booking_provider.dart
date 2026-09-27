import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';

class BookingNotifier extends StateNotifier<BookingModel> {
  BookingNotifier() : super(const BookingModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingModel>((ref) {
  return BookingNotifier()..loadData();
});
