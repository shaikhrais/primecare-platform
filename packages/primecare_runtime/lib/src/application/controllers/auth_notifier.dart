part of '../../../auth_service.dart';

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
      final tenant = data is Map<String, dynamic> ? data['tenantId'] : null;
      if (!response.isSuccess || role is! String || role.isEmpty ||
          userId is! String || userId.isEmpty ||
          tenant != null && (tenant is! String || !RegExp(r'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$').hasMatch(tenant))) {
        await _persist((prefs) async {
          if (_isCurrent(revision)) await _clearSession(prefs);
        });
        if (!_isCurrent(revision)) return;
        state = AuthState(isInitialized: true, preferredLanguage: language);
        authListenable.value = false;
        return;
      }
      await _persist((prefs) async {
        if (!_isCurrent(revision)) return;
        if (tenant is String) { await prefs.setString('auth_tenant_id', tenant); }
        else { await prefs.remove('auth_tenant_id'); }
      });
      if (!_isCurrent(revision)) return;
      state = AuthState(
        isAuthenticated: true, isInitialized: true, token: token,
        role: role, userId: userId, tenantId: tenant as String?,
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

  Future<bool> login(String email, String password, {MfaPrompt? completeMfa}) async {
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

        var payload = response.data;
        if (response.statusCode == 200 && payload is Map<String, dynamic> && payload['status'] == 'mfa_required') {
          // A challenge must never issue authority. Reject it and clean up any
          // unexpected session without installing it as the active actor.
          final unexpectedToken = payload['token'];
          if (unexpectedToken is String && unexpectedToken.trim().isNotEmpty) {
            try { await apiClient.revokeSession(unexpectedToken); } catch (_) {}
            return false;
          }
          if (completeMfa == null || !_isCurrent(revision) ||
              payload['challenge'] is! String || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(payload['challenge'] as String) ||
              !['enroll', 'verify'].contains(payload['purpose']) || payload.containsKey('token') ||
              (payload['purpose'] == 'enroll' && (payload['setupKey'] is! String || !RegExp(r'^[A-Z2-7]{32}$').hasMatch(payload['setupKey'] as String))) ||
              (payload['purpose'] == 'verify' && payload.containsKey('setupKey'))) return false;
          final challenge = Map<String, dynamic>.unmodifiable(payload);
          Map<String, dynamic>? verified;
          Map<String, dynamic>? replacement;
          var verifying = false;
          var promptOpen = true;
          Future<bool> verifyFactor(String code) async {
            if (!promptOpen || !_isCurrent(revision) || verifying || verified != null || !RegExp(r'^[0-9]{6}$').hasMatch(code)) return false;
            verifying = true;
            String? provisional;
            try {
              final factor = await apiClient.post(ApiConfig.endpoints[replacement == null ? 'mfa' : 'mfaReplacementConfirm']!,
                body: {'challenge': replacement?['challenge'] ?? challenge['challenge'], 'code': code});
              final data = factor.data;
              // Capture issued authority before validating the envelope so
              // rejected status/identity/token formats still reach cleanup.
              provisional = data is Map<String, dynamic> && data['token'] is String &&
                  (data['token'] as String).trim().isNotEmpty ? data['token'] as String : null;
              if (factor.statusCode != 200 || data is! Map<String, dynamic> || data['status'] != 'authenticated' ||
                  provisional == null || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(provisional)) return false;
              if (!promptOpen || !_isCurrent(revision) || data['role'] != 'code_admin' || data['userId'] is! String || (data['userId'] as String).trim().isEmpty) return false;
              final confirmation = await apiClient.confirmSession(provisional);
              final identity = confirmation.data;
              if (!promptOpen || !_isCurrent(revision) || !confirmation.isSuccess || identity is! Map<String, dynamic> ||
                  identity['status'] != 'authenticated' || identity['roles'] != data['role'] || identity['userId'] != data['userId'] || identity['tenantId'] != data['tenantId']) return false;
              verified = Map<String, dynamic>.unmodifiable(data);
              return true;
            } catch (_) { return false; }
            finally {
              verifying = false;
              if (provisional != null && verified == null) {
                try { await apiClient.revokeSession(provisional); } catch (_) {}
              }
            }
          }
          Future<Map<String, dynamic>?> recoverFactor(String savedCode) async {
            if (!promptOpen || !_isCurrent(revision) || verifying || verified != null || replacement != null ||
                challenge['purpose'] != 'verify' || !RegExp(r'^[A-Z2-7]{26}$').hasMatch(savedCode)) return null;
            verifying = true;
            String? unexpected;
            try {
              final response = await apiClient.post(ApiConfig.endpoints['mfaRecovery']!,
                body: {'challenge': challenge['challenge'], 'recoveryCode': savedCode});
              final data = response.data;
              if (data is Map<String, dynamic> && data['token'] is String && (data['token'] as String).trim().isNotEmpty) {
                unexpected = data['token'] as String;
              }
              if (!promptOpen || !_isCurrent(revision) || response.statusCode != 200 || unexpected != null || data is! Map<String, dynamic> ||
                  data.length != 3 || data['status'] != 'mfa_replacement_required' || data['challenge'] is! String ||
                  !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(data['challenge'] as String) || data['setupKey'] is! String ||
                  !RegExp(r'^[A-Z2-7]{32}$').hasMatch(data['setupKey'] as String)) return null;
              replacement = Map<String, dynamic>.unmodifiable(data);
              return Map<String, dynamic>.unmodifiable({...data, 'purpose': 'replace'});
            } catch (_) {return null;}
            finally {
              verifying = false;
              if (unexpected != null) {try {await apiClient.revokeSession(unexpected);} catch (_) {}}
            }
          }
          try { await completeMfa(challenge, MfaVerifier(verify: verifyFactor, recover: recoverFactor)); } catch (_) {
            final issued = verified?['token'];
            if (issued is String) { try { await apiClient.revokeSession(issued); } catch (_) {} }
            rethrow;
          } finally {
            // Disposal/cancellation may close the prompt with a request still
            // in flight. Its callback must not retain a late server session.
            promptOpen = false;
          }
          if (verified == null) return false;
          payload = verified;
        }
        final issuedToken = response.statusCode == 200 &&
                payload is Map<String, dynamic> && payload['token'] is String &&
                (payload['token'] as String).trim().isNotEmpty
            ? payload['token'] as String : null;
        var retained = false;
        try {
          if (!_isCurrent(revision)) return false;
          if (response.statusCode == 200) {
            if (issuedToken == null || payload is! Map<String, dynamic>) return false;
            final data = payload;
            final token = issuedToken;
            final role = data['role'];
            final userId = data['userId'];
            final tenant = data['tenantId'];
            if (role is! String || role.trim().isEmpty ||
                userId is! String || userId.trim().isEmpty ||
                (tenant != null && (tenant is! String || !RegExp(r'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$').hasMatch(tenant)))) {
              return false;
            }
            final userName = email.trim();
            final tenantId = tenant as String? ?? '';
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
            if (!_isCurrent(revision)) return false;
            state = AuthState(
              isAuthenticated: true, isInitialized: true,
              token: token, role: role, tenantId: tenantId,
              userName: userName, userId: userId,
              preferredLanguage: state.preferredLanguage ?? preferredLanguage,
            );
            authListenable.value = true;
            retained = true;
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
        } finally {
          // Rejected, malformed and superseded login replies still issued a
          // server session. Revoke that captured token without changing the
          // active actor or allowing a failed cleanup to grant authority.
          if (issuedToken != null && !retained) {
            try { await apiClient.revokeSession(issuedToken); } catch (_) {}
          }
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
    final actor = state;
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

        final current = state;
        return current.token == actor.token && current.userId == actor.userId &&
            current.tenantId == actor.tenantId &&
            response.confirmsCreatedAccount(
              email: email, role: role, tenantId: actor.tenantId ?? '',
            );
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

        if (response.confirmsPasswordRecovery()) {
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

  bool get canManageMfa => state.isInitialized && state.isAuthenticated && state.role == 'code_admin' &&
      state.token != null && state.userId != null;

  Future<Map<String, dynamic>?> manageMfa(MfaManagementAction action, String password, String code) async {
    if (!canManageMfa || password.isEmpty || !RegExp(r'^[0-9]{6}$').hasMatch(code)) return null;
    final actor = state, revision = _sessionRevision, api = ref.read(apiClientProvider);
    String? unexpected;
    try {
      final response = await api.post(ApiConfig.endpoints[action == MfaManagementAction.recoveryCodes ? 'mfaRecoveryCodes' : 'mfaReplacement']!,
        body: {'password': password, 'code': code});
      final data = response.data;
      if (data is Map<String, dynamic> && data['token'] is String && (data['token'] as String).trim().isNotEmpty) unexpected = data['token'] as String;
      if (!_isCurrent(revision) || state.token != actor.token || state.userId != actor.userId ||
          response.statusCode != 200 || unexpected != null || data is! Map<String, dynamic>) return null;
      if (action == MfaManagementAction.recoveryCodes) {
        final codes = data['recoveryCodes'];
        if (data.length != 2 || data['status'] != 'recovery_codes_issued' || codes is! List || codes.length != 10 ||
            codes.toSet().length != 10 || !codes.every((value) => value is String && RegExp(r'^[A-Z2-7]{26}$').hasMatch(value))) return null;
        return Map<String, dynamic>.unmodifiable({'status': data['status'], 'recoveryCodes': List<String>.unmodifiable(codes.cast<String>())});
      }
      if (data.length != 3 || data['status'] != 'mfa_replacement_required' || data['challenge'] is! String ||
          !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(data['challenge'] as String) || data['setupKey'] is! String ||
          !RegExp(r'^[A-Z2-7]{32}$').hasMatch(data['setupKey'] as String)) return null;
      return Map<String, dynamic>.unmodifiable(data);
    } catch (_) {return null;}
    finally {if (unexpected != null) {try {await api.revokeSession(unexpected);} catch (_) {}}}
  }

  Future<bool> confirmManagedMfa(String challenge, String code) async {
    if (!canManageMfa || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(challenge) || !RegExp(r'^[0-9]{6}$').hasMatch(code)) return false;
    final actor = state, revision = ++_sessionRevision, api = ref.read(apiClientProvider);
    String? provisional;
    var retained = false;
    var replacementAcknowledged = false;
    try {
      final response = await api.post(ApiConfig.endpoints['mfaReplacementConfirm']!, body: {'challenge': challenge, 'code': code});
      final data = response.data;
      if (data is Map<String, dynamic> && data['token'] is String && (data['token'] as String).trim().isNotEmpty) provisional = data['token'] as String;
      if (!_isCurrent(revision) || state.token != actor.token || response.statusCode != 200 || data is! Map<String, dynamic> ||
          data['status'] != 'authenticated' || provisional == null || !RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(provisional) ||
          data['role'] != 'code_admin' || data['userId'] != actor.userId) return false;
      replacementAcknowledged = true;
      final confirmation = await api.confirmSession(provisional);
      final identity = confirmation.data;
      if (!_isCurrent(revision) || state.token != actor.token || !confirmation.isSuccess || identity is! Map<String, dynamic> ||
          identity['status'] != 'authenticated' || identity['userId'] != actor.userId || identity['roles'] != 'code_admin') return false;
      final token = provisional;
      await _persist((prefs) async {
        if (!_isCurrent(revision)) return;
        await prefs.setString('auth_token', token);
        await prefs.setString('auth_role', 'code_admin');
        await prefs.setString('auth_user_id', actor.userId!);
        await prefs.setString('auth_tenant_id', actor.tenantId ?? '');
        await prefs.setString('auth_username', actor.userName ?? '');
        if (!_isCurrent(revision)) await _clearSession(prefs);
      });
      if (!_isCurrent(revision)) return false;
      state = actor.copyWith(token: token, preferredLanguage: state.preferredLanguage);
      authListenable.value = true;
      retained = true;
      return true;
    } catch (_) {return false;}
    finally {
      if (provisional != null && !retained) {
        try {await api.revokeSession(provisional);} catch (_) {}
        // A confirmed replacement invalidates the old server session. If its
        // new authority cannot be confirmed, fail closed for this captured actor.
        if (replacementAcknowledged && _isCurrent(revision) && state.token == actor.token && state.userId == actor.userId) {
          state = AuthState(isInitialized: true, preferredLanguage: state.preferredLanguage);
          authListenable.value = false;
          await _persist(_clearSession);
          if (actor.token != null) {try {await api.revokeSession(actor.token!);} catch (_) {}}
        }
      }
    }
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
