// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;
class AuthState {
  final bool isAuthenticated;
  final bool isInitialized;
  final String? token;
  final String? role;
  final String? tenantId;
  final String? userName;
  final String? userId;

  final String? preferredLanguage;

  AuthState({
    this.isAuthenticated = false,
    this.isInitialized = false,
    this.token,
    this.role,
    this.tenantId,
    this.userName,
    this.userId,
    this.preferredLanguage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isInitialized,
    String? token,
    String? role,
    String? tenantId,
    String? userName,
    String? userId,
    String? preferredLanguage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isInitialized: isInitialized ?? this.isInitialized,
      token: token ?? this.token,
      role: role ?? this.role,
      tenantId: tenantId ?? this.tenantId,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }
}

// Global listenable for GoRouter
final authListenable = ValueNotifier<bool>(false);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    AuthState initialState = AuthState(isInitialized: false);

    String? cleanStorageValue(String? val) {
      if (val == null) return null;
      var cleaned = val.trim();
      while ((cleaned.startsWith('"') && cleaned.endsWith('"') && cleaned.length >= 2) ||
             (cleaned.startsWith("'") && cleaned.endsWith("'") && cleaned.length >= 2)) {
        cleaned = cleaned.substring(1, cleaned.length - 1);
        cleaned = cleaned.trim();
      }
      return cleaned;
    }

    if (kIsWeb) {
      try {
        // Read directly from browser local storage synchronously to prevent asynchronous GoRouter race conditions!
        final storage = web.window.localStorage;
        final token = cleanStorageValue(storage.getItem('flutter.auth_token'));
        final role = cleanStorageValue(storage.getItem('flutter.auth_role'));
        final tenantId = cleanStorageValue(storage.getItem('flutter.auth_tenant_id'));
        final userName = cleanStorageValue(storage.getItem('flutter.auth_username')) ?? 'PrimeCare User';
        final userId = cleanStorageValue(storage.getItem('flutter.auth_user_id'));
        final preferredLanguage = cleanStorageValue(storage.getItem('flutter.auth_preferred_language')) ?? 'en';

        if (token != null && token.isNotEmpty && role != null && role.isNotEmpty) {
          initialState = AuthState(
            isAuthenticated: true,
            isInitialized: true, // We have successfully initialized synchronously!
            token: token,
            role: role,
            tenantId: tenantId,
            userName: userName,
            userId: userId,
            preferredLanguage: preferredLanguage,
          );
          authListenable.value = true;
        }
      } catch (e) {
        debugPrint('Synchronous local storage read failed: $e');
      }
    }

    _loadStoredAuth();
    return initialState;
  }

  static String getDashboardRouteForRole(String role) {
    if (role.isEmpty) return CommonRoutes.clinicalDashboard;

    // Check if there is a dashboard screen explicitly registered for this role!
    final pRole = PlatformRole.fromName(role);
    if (pRole != PlatformRole.guest && pRole != PlatformRole.unknown) {
      final roleUpper = pRole.name.toUpperCase();
      for (final screen in PlatformScreenRegistry.screens.values) {
        if (screen.id.endsWith('_DASHBOARD') && screen.roles.contains(roleUpper)) {
          return screen.routePath;
        }
      }
    }

    final r = role.toLowerCase().replaceAll(' ', '_').replaceAll('/', '_');

    // Corporate Leadership
    if (r == 'ceo' || r.contains('founder')) {
      return CorporateRoutes.ceoDashboard;
    }
    if (r.contains('shareholder')) {
      return CorporateRoutes.shareholderIntelligenceDashboard;
    }
    if (r == 'coo') return CorporateRoutes.cooDashboard;
    if (r == 'cfo') return CorporateRoutes.cfoDashboard;
    if (r == 'cto') return CorporateRoutes.ctoDashboard;
    if (r.contains('legal')) return CorporateRoutes.legalDashboard;
    if (r.contains('ciso')) return CorporateRoutes.cisoDashboard;
    if (r.contains('compliance_manager')) {
      return CorporateRoutes.complianceManagerDashboard;
    }
    if (r.contains('head_of_bus_dev')) {
      return CorporateRoutes.headOfBusDevDashboard;
    }
    if (r.contains('head_of_marketing')) {
      return CorporateRoutes.headOfMarketingDashboard;
    }
    if (r.contains('training_director')) {
      return CorporateRoutes.trainingDirectorDashboard;
    }
    if (r.contains('finance_director')) {
      return CorporateRoutes.financeDirectorDashboard;
    }

    // Business Development
    if (r.contains('regional_manager_ontario')) {
      return BusinessDevelopmentRoutes.regionalManagerOntarioDashboard;
    }
    if (r.contains('regional_manager_usa')) {
      return BusinessDevelopmentRoutes.regionalManagerUsaDashboard;
    }
    if (r.contains('franchise_sales_manager')) {
      return BusinessDevelopmentRoutes.franchiseSalesManagerDashboard;
    }
    if (r.contains('partnership_manager')) {
      return BusinessDevelopmentRoutes.partnershipManagerDashboard;
    }
    if (r.contains('territory_expansion_manager')) {
      return BusinessDevelopmentRoutes.territoryExpansionManagerDashboard;
    }
    if (r.contains('general_manager')) {
      return BusinessDevelopmentRoutes.generalManagerDashboard;
    }

    // Franchise Tier
    if (r.contains('franchise_owner') || r.contains('owner')) {
      return FranchiseRoutes.franchiseOwnerDashboard;
    }
    if (r.contains('operations_manager')) {
      return FranchiseRoutes.operationsManagerDashboard;
    }
    if (r.contains('scheduler') || r.contains('coordinator')) {
      return FranchiseRoutes.schedulerDashboard;
    }
    if (r.contains('billing_admin') || r.contains('billing')) {
      return FranchiseRoutes.billingAdminDashboard;
    }
    if (r.contains('hr_manager')) {
      return FranchiseRoutes.hrHiringDashboard;
    }
    if (r.contains('hr_hiring')) {
      return FranchiseRoutes.hrHiringDashboard;
    }

    // Support & Institutional
    if (r.contains('customer_support') || r.contains('support')) {
      return SupportRoutes.customerSupportDashboard;
    }
    if (r.contains('qa_specialist')) {
      return '/offices/support/roles/qa_specialist/dashboard';
    }
    if (r.contains('intake')) return SupportRoutes.intakeCoordinatorDashboard;
    if (r.contains('quality_assurance') || r.contains('qa_manager')) {
      return SupportRoutes.qualityAssuranceDashboard;
    }
    if (r.contains('training_coordinator')) {
      return SupportRoutes.trainingCoordinatorDashboard;
    }
    if (r.contains('receptionist')) {
      return CommonRoutes.receptionistDashboard;
    }
    if (r.contains('volunteer_coordinator')) {
      return CorporateRoutes.volunteerCoordinatorDashboard;
    }
    if (r.contains('scrum_master')) {
      return CommonRoutes.scrumMasterDashboard;
    }
    if (r.contains('guest')) {
      return ClientRoutes.patientDashboard;
    }

    // Marketing & Growth
    if (r.contains('local_marketing')) {
      return MarketingRoutes.localMarketingManagerDashboard;
    }
    if (r.contains('outreach')) {
      return MarketingRoutes.communityOutreachDashboard;
    }
    if (r.contains('territory_sales')) {
      return MarketingRoutes.territorySalesManagerDashboard;
    }

    // Clinical Execution
    if (r.contains('clinical_director')) {
      return ClinicalRoutes.clinicalDirectorDashboard;
    }
    if (r == 'psw') {
      return ClinicalRoutes.pswDashboard;
    }
    if (r == 'chiropractor') {
      return ClinicalRoutes.chiropractorDashboard;
    }
    if (r == 'physio' || r == 'physiotherapist') {
      return ClinicalRoutes.physiotherapistDashboard;
    }
    if (r == 'rmt') {
      return ClinicalRoutes.rmtDashboard;
    }
    if (r == 'social_worker') {
      return ClinicalRoutes.socialWorkerDashboard;
    }
    if (r == 'therapist') {
      return ClinicalRoutes.therapistDashboard;
    }
    if (r == 'intake') {
      return ClinicalRoutes.intakeCoordinatorDashboard;
    }
    if (r == 'caregiver') {
      return ClinicalRoutes.careGiverDashboard;
    }
    if (r == 'rn') {
      return ClinicalRoutes.rnDashboard;
    }
    if (r == 'rpn') {
      return ClinicalRoutes.rpnDashboard;
    }
    if (r == 'lpn') {
      return '/clinical/lpn-dashboard';
    }
    if (r == 'np') {
      return '/clinical/np-dashboard';
    }
    if (r == 'physician') {
      return '/clinical/physician-dashboard';
    }
    if (r == 'pediatric') {
      return '/clinical/pediatric-dashboard';
    }
    if (r == 'hsw') {
      return '/clinical/hsw-dashboard';
    }
    if (r == 'cns') {
      return '/clinical/cns-dashboard';
    }
    if (r == 'rn_field_supervisor') {
      return '/rn/rn-field-supervisor-dashboard';
    }
    if (r.contains('clinical')) {
      return CommonRoutes.clinicalDashboard;
    }

    // Client Side
    if (r == 'client') return ClientRoutes.clientDashboard;
    if (r.contains('family')) return ClientRoutes.familyMemberDashboard;

    // Institutional Fallbacks
    if (r == 'admin') return FranchiseRoutes.billingAdminDashboard;

    return CommonRoutes.clinicalDashboard; // Fallback security
  }

  Future<void> _loadStoredAuth() async {
    await Result.guardFuture<void>(
      () async {
        final prefs = await SharedPreferences.getInstance();

        // 1. Try SSO Session Restoration
        try {
          if (kIsWeb && Uri.base.path.contains('/auth/callback')) {
            ref.read<ExecutionGateService>(executionGateProvider).passGate(
              ExecutionGateCategory.auth,
              'Skipping initial session restoration: actively in auth callback flow.',
            );
            
            // Read stored session directly without hit to auth/me to avoid race conditions
            final token = prefs.getString('auth_token');
            final role = prefs.getString('auth_role');
            final tenantId = prefs.getString('auth_tenant_id');
            final userName = prefs.getString('auth_username') ?? 'PrimeCare User';
            final userId = prefs.getString('auth_user_id');
            final preferredLanguage = prefs.getString('auth_preferred_language') ?? 'en';
            
            if (token != null && role != null) {
              state = state.copyWith(
                isAuthenticated: true,
                token: token,
                role: role,
                userName: userName,
                tenantId: tenantId,
                userId: userId,
                preferredLanguage: preferredLanguage,
              );
              authListenable.value = true;
            }
            return;
          }

          // Pre-load stored token/role into state so interceptors can use it for the /me call!
          final preToken = prefs.getString('auth_token');
          final preRole = prefs.getString('auth_role');
          final preTenantId = prefs.getString('auth_tenant_id');
          final preUserName = prefs.getString('auth_username') ?? 'PrimeCare User';
          final preUserId = prefs.getString('auth_user_id');
          final prePreferredLanguage = prefs.getString('auth_preferred_language') ?? 'en';

          if (preToken != null && preToken.isNotEmpty && preRole != null && preRole.isNotEmpty) {
            state = state.copyWith(
              isAuthenticated: true,
              token: preToken,
              role: preRole,
              userName: preUserName,
              tenantId: preTenantId,
              userId: preUserId,
              preferredLanguage: prePreferredLanguage,
            );
            authListenable.value = true;

            try {
              final apiClient = ref.read(apiClientProvider);
              final response = await apiClient.get(ApiConfig.endpoints['me']!);
              if (response.isSuccess) {
                final data = response.data as Map<String, dynamic>;
                await prefs.setString('auth_token', 'sso-token');
                final rawRoles = data['roles'];
                String roleStr = 'psw';
                if (rawRoles is List && rawRoles.isNotEmpty) {
                  roleStr = rawRoles.first.toString();
                } else if (rawRoles != null) {
                  roleStr = rawRoles.toString();
                }
                await prefs.setString('auth_role', roleStr);
                await prefs.setString('auth_user_id', data['userId']?.toString() ?? '');
                // keep existing username if any
              } else {
                 if (prefs.getString('auth_token') != 'demo-token') {
                   await prefs.remove('auth_token');
                   await prefs.remove('auth_role');
                   // Clear active state to force login on failure
                   state = AuthState();
                   authListenable.value = false;
                 }
              }
            } catch (e) {
              // In case of network error, we might still want to clear or keep? 
              // For true SSO, no cookie = no auth. But we'll leave it for now.
            }
          }

        final token = prefs.getString('auth_token');
        final role = prefs.getString('auth_role');
        final tenantId = prefs.getString('auth_tenant_id');
        final userName = prefs.getString('auth_username') ?? 'PrimeCare User';
        final userId = prefs.getString('auth_user_id');
        final preferredLanguage =
            prefs.getString('auth_preferred_language') ?? 'en';

        if (token != null && role != null) {
          state = state.copyWith(
            isAuthenticated: true,
            token: token,
            role: role,
            userName: userName,
            tenantId: tenantId,
            userId: userId,
            preferredLanguage: preferredLanguage,
          );
          authListenable.value = true;
          ref
              .read<ExecutionGateService>(executionGateProvider)
              .passGate(
                ExecutionGateCategory.auth,
                'Session restored for active role: $role',
                metadata: {
                  'tenantId': tenantId,
                  'hasToken': true,
                  'userName': userName,
                },
              );
        }
        } catch (e) {
          debugPrint('SSO Restoration error: $e');
        }
      },
      onError: (e, st) {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .failGate(
              ExecutionGateCategory.auth,
              'SharedPreferences restoration failure.',
              error: e,
              stackTrace: st,
            );
        // Ensure we stay in a safe unauthenticated state
        state = AuthState(isInitialized: true);
        authListenable.value = false;
      },
    );
    state = state.copyWith(isInitialized: true);
  }

  Future<void> handleDeepLinkAuth({
    required String token,
    required String role,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save to SharedPreferences so session persists across app restarts
    await prefs.setString('auth_token', token);
    await prefs.setString('auth_role', role);
    await prefs.setString('auth_user_id', userId);
    
    // Update State
    state = state.copyWith(
      isAuthenticated: true,
      isInitialized: true,
      token: token,
      role: role,
      userId: userId,
    );
    authListenable.value = true;
    
    ref.read<ExecutionGateService>(executionGateProvider).passGate(
      ExecutionGateCategory.auth,
      'Session restored via Deep Link SSO for role: $role',
      metadata: {'hasToken': true, 'userId': userId},
    );
  }

  Future<bool> login(String email, String password) async {
    final result = await Result.guardFuture<bool>(
      () async {
        final emailLower = email.toLowerCase().trim();
        TestCredential? matchedCred;
        if (!kReleaseMode) {
          try {
            matchedCred = TestCredentialsRegistry.allCredentials.firstWhere(
              (c) => c.email.toLowerCase().trim() == emailLower && c.password == password,
            );
          } catch (_) {}
        }

        if (matchedCred != null) {
          final role = matchedCred.role.nameSnake;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', 'demo-token');
          await prefs.setString('auth_role', role);
          await prefs.setString('auth_username', matchedCred.role.displayName);
          await prefs.setString('auth_user_id', 'mock-user-id-${matchedCred.role.name}');

          state = state.copyWith(
            isAuthenticated: true,
            token: 'demo-token',
            role: role,
            userName: matchedCred.role.displayName,
            userId: 'mock-user-id-${matchedCred.role.name}',
            preferredLanguage: 'en',
          );
          authListenable.value = true;
          ref
              .read<ExecutionGateService>(executionGateProvider)
              .passGate(
                ExecutionGateCategory.auth,
                'Offline Test Authentication successful. Role: $role',
                metadata: {'email': email},
              );
          return true;
        }

        // Debug Bypass for local verification fallback
        if (!kReleaseMode && (emailLower.endsWith('@demo.primecare.com') || emailLower.endsWith('@primecare.test'))) {
          final role = emailLower.split('@')[0];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', 'demo-token');
          await prefs.setString('auth_role', role);
          await prefs.setString('auth_username', 'Demo User');

          state = state.copyWith(
            isAuthenticated: true,
            token: 'demo-token',
            role: role,
            userName: 'Demo User',
            preferredLanguage: 'en',
          );
          authListenable.value = true;
          return true;
        }

        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.post(
          ApiConfig.endpoints['login']!,
          body: {'email': email, 'password': password},
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data =
              response.data as Map<String, dynamic>;
          final token = (data['token'] as String?) ?? 'mock-token';

          // Deeply unpack role from Worker-API or root
          String role = 'PSW';
          final emailLower = email.toLowerCase().trim();
          final user = data['user'] as Map<String, dynamic>?;

          if (emailLower == 'itpro.mohammed@gmail.com') {
            role = 'Super Admin';
          } else if (data['role'] != null) {
            role = data['role'] as String;
          } else if (user != null &&
              user['roles'] != null &&
              (user['roles'] as List).isNotEmpty) {
            role = (user['roles'] as List)[0] as String;
          } else if (data['activeRole'] != null) {
            role = data['activeRole'] as String;
          } else if (emailLower.endsWith('@primecare.com')) {
            // Dynamic role mapping for high-fidelity orchestration sandbox
            role = emailLower.split('@')[0];
          }

          final prefs = await SharedPreferences.getInstance();

          final tenantId =
              (data['tenantId'] as String?) ??
              (user != null ? user['tenantId'] as String? : null) ??
              '00000000-0000-0000-0000-000000000000';

          final firstName =
              (user != null ? user['firstName'] as String? : null) ?? 'Active';
          final lastName =
              (user != null ? user['lastName'] as String? : null) ?? 'User';
          final userName = '$firstName $lastName';

          final userId =
              (user != null ? user['id'] as String? : null) ?? 'unknown';
          final preferredLanguage =
              (user != null ? user['preferredLanguage'] as String? : null) ??
              state.preferredLanguage ??
              'en';

          await prefs.setString('auth_token', token);
          await prefs.setString('auth_role', role);
          await prefs.setString('auth_tenant_id', tenantId);
          await prefs.setString('auth_username', userName);
          await prefs.setString('auth_user_id', userId);
          await prefs.setString('auth_preferred_language', preferredLanguage);

          state = state.copyWith(
            isAuthenticated: true,
            token: token,
            role: role,
            tenantId: tenantId,
            userName: userName,
            userId: userId,
            preferredLanguage: preferredLanguage,
          );
          authListenable.value = true;
          ref
              .read<ExecutionGateService>(executionGateProvider)
              .passGate(
                ExecutionGateCategory.auth,
                'API Authentication via Cloudflare successful. Role: $role',
                metadata: {'tenantId': tenantId, 'email': email},
              );
          return true;
        } else {
          ref
              .read<ExecutionGateService>(executionGateProvider)
              .failGate(
                ExecutionGateCategory.auth,
                'API Authentication declined. Status: ${response.statusCode}',
                metadata: {
                  'email': email,
                  'statusCode': response.statusCode,
                  'responseBody': response.data.toString(),
                },
              );
          return false;
        }
      },
      onError: (e, st) {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .failGate(
              ExecutionGateCategory.auth,
              'API Connection Exception during login.',
              error: e,
              stackTrace: st,
              metadata: {
                'email': email,
                'target': ApiConfig.endpoints['login'],
              },
            );
        return false;
      },
    );
    return result.fold((data) => data, (error) => false);
  }

  Future<bool> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String role,
  ) async {
    final result = await Result.guardFuture<bool>(
      () async {
        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.post(
          ApiConfig.endpoints['register']!,
          body: {
            'email': email,
            'password': password,
            'firstName': firstName,
            'lastName': lastName,
            'role': role,
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Automatically login the user after successful registration
          return await login(email, password);
        } else {
          return false;
        }
      },
      onError: (e, st) {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .failGate(
              ExecutionGateCategory.auth,
              'API Connection Exception during registration.',
              error: e,
              stackTrace: st,
              metadata: {
                'email': email,
                'target': ApiConfig.endpoints['register'],
              },
            );
        return false;
      },
    );
    return result.fold((data) => data, (error) => false);
  }

  Future<bool> forgotPassword(String email) async {
    final result = await Result.guardFuture<bool>(
      () async {
        // Offline test mock bypass
        if (!kReleaseMode && (email.toLowerCase().endsWith('@demo.primecare.com') || email.toLowerCase().endsWith('@primecare.test'))) {
           ref.read<ExecutionGateService>(executionGateProvider).passGate(
            ExecutionGateCategory.auth,
            'Offline Forgot Password mock successful.',
            metadata: {'email': email},
          );
          return true;
        }

        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.post(
          ApiConfig.endpoints['forgotPassword']!,
          body: {'email': email},
        );

        if (response.statusCode == 200) {
          ref.read<ExecutionGateService>(executionGateProvider).passGate(
            ExecutionGateCategory.auth,
            'Forgot Password request successful.',
            metadata: {'email': email},
          );
          return true;
        } else {
          ref.read<ExecutionGateService>(executionGateProvider).failGate(
            ExecutionGateCategory.auth,
            'Forgot Password request declined. Status: ${response.statusCode}',
            metadata: {'email': email, 'statusCode': response.statusCode},
          );
          return false;
        }
      },
      onError: (e, st) {
        ref.read<ExecutionGateService>(executionGateProvider).failGate(
          ExecutionGateCategory.auth,
          'API Connection Exception during forgot password.',
          error: e,
          stackTrace: st,
          metadata: {
            'email': email,
            'target': ApiConfig.endpoints['forgotPassword'],
          },
        );
        return false;
      },
    );
    return result.fold((data) => data, (error) => false);
  }

  Future<void> logout() async {
    await Result.guardFuture<void>(
      () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
        await prefs.remove('auth_role');
        await prefs.remove('auth_tenant_id');
        await prefs.remove('auth_username');
        await prefs.remove('auth_user_id');
        await prefs.remove('auth_preferred_language');

        ref
            .read<ExecutionGateService>(executionGateProvider)
            .passGate(
              ExecutionGateCategory.auth,
              'User session persistence cleared successfully.',
            );
      },
      onError: (e, st) {
        ref
            .read<ExecutionGateService>(executionGateProvider)
            .failGate(
              ExecutionGateCategory.auth,
              'Persistence failure during logout.',
              error: e,
              stackTrace: st,
            );
      },
    );

    state = AuthState();
    authListenable.value = false;
    ref
        .read<ExecutionGateService>(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auth,
          'Auth state reset sequence completed.',
        );
  }

  Future<void> updatePreferredLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_preferred_language', lang);
    state = state.copyWith(preferredLanguage: lang);

    if (state.isAuthenticated) {
      final apiClient = ref.read(apiClientProvider);
      try {
        await apiClient.post(
          '/v1/user/preferences',
          body: {'userId': state.userId, 'preferredLanguage': lang},
        );
      } catch (e) {
        // Resilience: Fail silently
      }
    }
  }
  Future<void> simulateRoleSession(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', 'simulated-token');
    await prefs.setString('auth_role', role);
    await prefs.setString('auth_username', 'Simulated $role');
    await prefs.setString('auth_tenant_id', 'simulated-tenant');

    state = state.copyWith(
      isAuthenticated: true,
      token: 'simulated-token',
      role: role,
      userName: 'Simulated $role',
      tenantId: 'simulated-tenant',
      preferredLanguage: 'en',
    );
    authListenable.value = true;

    ref.read<ExecutionGateService>(executionGateProvider).passGate(
      ExecutionGateCategory.auth,
      'Architectural Parity Simulation active for role: $role',
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
