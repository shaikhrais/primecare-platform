/// Defines the integrity status of the application environment.
class AppIntegrityStatus {
  final bool isRooted;
  final bool isJailbroken;
  final bool isEmulator;
  final bool isDevelopmentMode;
  final bool isTampered;

  const AppIntegrityStatus({
    required this.isRooted,
    required this.isJailbroken,
    required this.isEmulator,
    required this.isDevelopmentMode,
    this.isTampered = false,
  });

  bool get isSecure => !isRooted && !isJailbroken && !isEmulator && !isTampered;

  @override
  String toString() {
    return 'Integrity(Secure: $isSecure, Rooted: $isRooted, Emulator: $isEmulator)';
  }
}
