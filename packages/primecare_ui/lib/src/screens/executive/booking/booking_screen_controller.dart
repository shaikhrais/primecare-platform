import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingScreenState extends DashboardState<BookingScreenState> {
  BookingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BookingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BookingScreenState(isLoading: isLoading, error: error, data: data);
}

class BookingScreenController
    extends BaseDashboardController<BookingScreenState> {
  BookingScreenController(Ref ref)
    : super(
        ref,
        initialState: BookingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/booking',
      );
}

final bookingControllerProvider =
    StateNotifierProvider<BookingScreenController, BookingScreenState>((ref) {
      return BookingScreenController(ref);
    });
