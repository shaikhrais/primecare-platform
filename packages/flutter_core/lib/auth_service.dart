// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/foundation.dart';

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
  int _sessionRevision = 0;
  Future<void> _persistence = Future<void>.value();

  bool _isCurrent(int revision) => ref.mounted && revision == _sessionRevision;

  // Serialize storage mutations so a superseded write cannot outlive logout or
  // overwrite the next login. Failed storage must not poison the queue.
  Future<void> _persist(Future<void> Function(SharedPreferences) operation) {
    final work = _persistence.then((_) async {
      await operation(await SharedPreferences.getInstance());
    });
    _persistence = work.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return work;
  }

  Future<void> _clearSession(SharedPreferences prefs) async {
    for (final key in const ['auth_token', 'auth_role', 'auth_tenant_id',
        'auth_username', 'auth_user_id']) {
      await prefs.remove(key);
    }
  }

  @override
  AuthState build() {
    _loadStoredAuth(++_sessionRevision);
    return AuthState(isInitialized: false);
  }

  static String getDashboardRouteForRole(String role) {
    if (role == 'maintenance') return '/maintenance/configuration';
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

  Future<void> _loadStoredAuth(int revision) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!_isCurrent(revision)) return;
      final language = prefs.getString('auth_preferred_language') ?? 'en';
      final token = prefs.getString('auth_token');
      if (token == null || token.isEmpty) {
        state = AuthState(isInitialized: true, preferredLanguage: language);
        authListenable.value = false;
        return;
      }
      // Local role/identity values are not authority until the server confirms.
      state = AuthState(token: token, preferredLanguage: language);
      final response = await ref.read(apiClientProvider).get(ApiConfig.endpoints['me']!);
      if (!_isCurrent(revision)) return;
      final data = response.data;
      final role = data is Map<String, dynamic> ? data['roles'] : null;
      final userId = data is Map<String, dynamic> ? data['userId'] : null;
      if (!response.isSuccess || role is! String || role.isEmpty ||
          userId is! String || userId.isEmpty) {
        await _persist((prefs) async {
          if (_isCurrent(revision)) await _clearSession(prefs);
        });
        if (!_isCurrent(revision)) return;
        state = AuthState(isInitialized: true, preferredLanguage: language);
        authListenable.value = false;
        return;
      }
      state = AuthState(
        isAuthenticated: true, isInitialized: true, token: token,
        role: role, userId: userId,
        userName: prefs.getString('auth_username'),
        preferredLanguage: state.preferredLanguage ?? language,
      );
      authListenable.value = true;
    } catch (_) {
      if (!_isCurrent(revision)) return;
      await _persist((prefs) async {
        if (_isCurrent(revision)) await _clearSession(prefs);
      });
      if (!_isCurrent(revision)) return;
      state = AuthState(isInitialized: true, preferredLanguage: state.preferredLanguage);
      authListenable.value = false;
    }
  }

  Future<void> handleDeepLinkAuth({
    required String token,
    required String role,
    required String userId,
  }) async {
    // Untrusted callback parameters neither establish nor destroy a session.
  }

  Future<bool> login(String email, String password) async {
    final revision = ++_sessionRevision;
    if (!state.isInitialized) {
      state = AuthState(isInitialized: true, preferredLanguage: state.preferredLanguage);
    }
    final result = await Result.guardFuture<bool>(
      () async {
        final apiClient = ref.read(apiClientProvider);
        final response = await apiClient.post(
          ApiConfig.endpoints['login']!,
          body: {'email': email, 'password': password},
        );

        if (!_isCurrent(revision)) {
          final data = response.data;
          if (response.statusCode == 200 && data is Map<String, dynamic> &&
              data['token'] is String && (data['token'] as String).isNotEmpty) {
            await apiClient.revokeSession(data['token'] as String);
          }
          return false;
        }
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

          await _persist((prefs) async {
            if (!_isCurrent(revision)) return;
            await prefs.setString('auth_token', token);
            await prefs.setString('auth_role', role);
            await prefs.setString('auth_tenant_id', tenantId);
            await prefs.setString('auth_username', userName);
            await prefs.setString('auth_user_id', userId);
            // A newer operation may start while the platform writes are in
            // flight. It will run after this queue entry, so remove the stale
            // credentials before allowing the next entry to proceed.
            if (!_isCurrent(revision)) await _clearSession(prefs);
          });
          if (!_isCurrent(revision)) {
            await apiClient.revokeSession(token);
            return false;
          }
          state = AuthState(
            isAuthenticated: true, isInitialized: true,
            token: token, role: role, tenantId: tenantId,
            userName: userName, userId: userId,
            preferredLanguage: state.preferredLanguage ?? preferredLanguage,
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
            'role': role,
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // This is privileged account provisioning. Keep the creating user's
          // session; registration does not authenticate the new account.
          return true;
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
    ++_sessionRevision;
    final token = state.token;
    final api = ref.read(apiClientProvider);
    final language = state.preferredLanguage;
    // Remove local authority immediately. A stalled network must not leave a
    // logged-out user on protected screens. Revocation uses the captured token.
    state = AuthState(isInitialized: true, preferredLanguage: language);
    authListenable.value = false;
    final cleared = _persist(_clearSession);
    try {
      if (token != null && token.isNotEmpty) await api.revokeSession(token);
    } catch (_) {
      // Offline revocation cannot restore local authentication.
    } finally {
      await cleared;
    }
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
    throw UnsupportedError('Simulated authentication is disabled.');

  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
