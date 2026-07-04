class BookingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BookingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BookingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BookingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
