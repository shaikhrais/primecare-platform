class CtoAccessControlModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CtoAccessControlModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CtoAccessControlModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CtoAccessControlModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
