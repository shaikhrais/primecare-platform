// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/src/utils/auth_storage.dart';
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
        final token = cleanStorageValue(getLocalStorageItem('flutter.auth_token'));
        final role = cleanStorageValue(getLocalStorageItem('flutter.auth_role'));
        final tenantId = cleanStorageValue(getLocalStorageItem('flutter.auth_tenant_id'));
        final userName = cleanStorageValue(getLocalStorageItem('flutter.auth_username')) ?? 'PrimeCare User';
        final userId = cleanStorageValue(getLocalStorageItem('flutter.auth_user_id'));
        final preferredLanguage = cleanStorageValue(getLocalStorageItem('flutter.auth_preferred_language')) ?? 'en';

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
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null || token.isEmpty) {
        state = AuthState(isInitialized: true);
        authListenable.value = false;
        return;
      }

      // The token is provisional until the server confirms it is active.
      state = AuthState(
        isInitialized: false,
        token: token,
        role: prefs.getString('auth_role'),
      );
      final response = await ref.read(apiClientProvider)
          .get(ApiConfig.endpoints['me']!);
      if (!response.isSuccess || response.data is! Map<String, dynamic>) {
        await prefs.remove('auth_token');
        await prefs.remove('auth_role');
        state = AuthState(isInitialized: true);
        authListenable.value = false;
        return;
      }
      final data = response.data as Map<String, dynamic>;
      final role = data['roles']?.toString();
      final userId = data['userId']?.toString();
      if (role == null || role.isEmpty || userId == null || userId.isEmpty) {
        await prefs.remove('auth_token');
        state = AuthState(isInitialized: true);
        authListenable.value = false;
        return;
      }
      state = AuthState(
        isAuthenticated: true,
        isInitialized: true,
        token: token,
        role: role,
        userId: userId,
        userName: prefs.getString('auth_username'),
        tenantId: prefs.getString('auth_tenant_id'),
        preferredLanguage: prefs.getString('auth_preferred_language') ?? 'en',
      );
      authListenable.value = true;
    } catch (_) {
      state = AuthState(isInitialized: true);
      authListenable.value = false;
    }
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
        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.post(
          ApiConfig.endpoints['login']!,
          body: {'email': email, 'password': password},
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data =
              response.data as Map<String, dynamic>;
          final token = data['token'] as String?;
          if (token == null || token.isEmpty) return false;

          final role = data['role'] as String?;
          final userId = data['userId']?.toString();
          if (role == null || role.isEmpty || userId == null || userId.isEmpty) {
            return false;
          }
          final userName = email.trim();
          final tenantId = data['tenantId']?.toString() ?? '';
          final preferredLanguage = state.preferredLanguage ?? 'en';

          final prefs = await SharedPreferences.getInstance();

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
