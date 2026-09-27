// Governance - Category: test | Purpose: AppMode defines the current operational state of the PrimeCare platform. A rigid credential structure representing a ...
import 'package:flutter/foundation.dart';
import '../registry/platform_role.dart';

/// AppMode defines the current operational state of the PrimeCare platform.
enum AppMode {
  localTesting,
  staging,
  production,
}

/// A rigid credential structure representing a test user.
class TestCredential {
  final PlatformRole role;
  final String email;
  final String password;

  const TestCredential({
    required this.role,
    required this.email,
    required this.password,
  });
}

/// The TestCredentialsRegistry provides easy access to dummy accounts for local testing.
/// 
/// **SECURITY PROTOCOL (DO NOT BYPASS):**
/// 1. This registry throws a fatal exception if accessed in [kReleaseMode] (Production).
/// 2. NEVER add real credentials to this file. Use purely synthetic emails (e.g., '@test.com').
/// 3. The backend APIs MUST independently block these synthetic emails from being 
///    authenticated in production databases.
class TestCredentialsRegistry {
  /// Resolves the current AppMode based on compiler flags.
  static AppMode get currentMode {
    if (kReleaseMode) return AppMode.production;
    if (kProfileMode) return AppMode.staging;
    return AppMode.localTesting;
  }

  /// Retrieves the list of all test credentials.
  /// Throws a fatal SecurityError if accessed in a production build.
  static List<TestCredential> get allCredentials {
    if (currentMode == AppMode.production) {
      throw UnsupportedError(
        'SECURITY BREACH: TestCredentialsRegistry cannot be accessed in production mode. '
        'This prevents hardcoded credentials from leaking into the live app.',
      );
    }

    return [
      // Corporate
      TestCredential(role: PlatformRole.admin, email: 'admin@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.ceo, email: 'ceo@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.cfo, email: 'cfo@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.coo, email: 'coo@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.cto, email: 'cto@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.complianceManager, email: 'compliance@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.financeDirector, email: 'finance@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.trainingDirector, email: 'training@primecare.test', password: 'TestPassword123!'),
      
      // Franchise
      TestCredential(role: PlatformRole.franchiseOwner, email: 'franchise@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.regionalManagerOntario, email: 'region@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.billingAdmin, email: 'billing@primecare.test', password: 'TestPassword123!'),
      
      // Clinical
      TestCredential(role: PlatformRole.clinicalDirector, email: 'clinicaldir@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.intakeCoordinator, email: 'intake@primecare.test', password: 'TestPassword123!'),
      TestCredential(role: PlatformRole.psw, email: 'psw@primecare.test', password: 'TestPassword123!'),
      
      // Support
      TestCredential(role: PlatformRole.customerSupport, email: 'support@primecare.test', password: 'TestPassword123!'),
      
      // Client
      TestCredential(role: PlatformRole.client, email: 'client@primecare.test', password: 'TestPassword123!'),
    ];
  }

  /// Helper to get a credential for a specific role.
  static TestCredential? getForRole(PlatformRole role) {
    try {
      return allCredentials.firstWhere((c) => c.role == role);
    } catch (_) {
      return null; // Handle if we don't have a specific test credential defined yet.
    }
  }
}
