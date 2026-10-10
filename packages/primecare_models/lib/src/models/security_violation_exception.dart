class SecurityViolationException implements Exception {
  final String message;
  SecurityViolationException(this.message);
  @override
  String toString() => 'SecurityViolationException: $message';
}
