/// Defines the required security level for a sensitive action.
enum SecurityRequirement {
  /// Basic authentication is sufficient.
  authenticated,

  /// Device must be trusted (MFA completed once).
  trustedDevice,

  /// Active MFA session required (just completed).
  activeMfa,

  /// Full Bank-Grade: Authenticated, Trusted, Secure Environment, and Fresh Biometric.
  bankGrade,
}
