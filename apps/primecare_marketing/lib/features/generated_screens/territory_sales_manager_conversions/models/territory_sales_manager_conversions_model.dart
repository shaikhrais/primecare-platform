class TerritorySalesManagerConversionsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritorySalesManagerConversionsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritorySalesManagerConversionsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritorySalesManagerConversionsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
