class SharedStubsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SharedStubsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SharedStubsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SharedStubsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
