class LoginModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LoginModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LoginModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LoginModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
