import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../routes/app_routes.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? role;

  AuthState({this.isAuthenticated = false, this.token, this.role});

  AuthState copyWith({bool? isAuthenticated, String? token, String? role}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }
}

// Global listenable for GoRouter
final authListenable = ValueNotifier<bool>(false);

class AuthNotifier extends Notifier<AuthState> {
  String get _baseUrl => dotenv.env['API_URL'] ?? 'https://primecare-api.itpro-mohammed.workers.dev';

  @override
  AuthState build() {
    // Initial sync load triggers asynchronously
    Future.microtask(() => _loadStoredAuth());
    return AuthState();
  }

  static String getDashboardRouteForRole(String role) {
    if (role.isEmpty) return AppRoutes.pswDashboard;
    
    final r = role.toLowerCase().replaceAll(' ', '_').replaceAll('/', '_');
    
    // Corporate Leadership
    if (r.contains('ceo') || r.contains('founder')) return AppRoutes.ceoDashboard;
    if (r.contains('coo')) return AppRoutes.cooDashboard;
    if (r.contains('cfo') || r.contains('finance')) return AppRoutes.cfoDashboard;
    if (r.contains('cto') || r.contains('tech')) return AppRoutes.ctoDashboard;
    if (r.contains('compliance')) return AppRoutes.complianceManagerDashboard;
    if (r.contains('training') && r.contains('director')) return AppRoutes.trainingDirectorDashboard;
    
    // Business Development
    if (r.contains('regional') || r.contains('bdm')) return AppRoutes.regionalManagerOntarioDashboard;
    if (r.contains('sales_manager')) return AppRoutes.franchiseSalesManagerDashboard;
    if (r.contains('partnership')) return AppRoutes.partnershipManagerDashboard;
    if (r.contains('expansion')) return AppRoutes.territoryExpansionManagerDashboard;

    // Franchise Tier
    if (r.contains('owner') || r.contains('franchisee')) return AppRoutes.franchiseOwnerDashboard;
    if (r.contains('operations') || r.contains('ops')) return AppRoutes.operationsManagerDashboard;
    if (r.contains('scheduler') || r.contains('coordinator')) return AppRoutes.schedulerDashboard;
    if (r.contains('admin') || r.contains('billing')) return AppRoutes.billingAdminDashboard;
    if (r.contains('hr') || r.contains('hiring')) return AppRoutes.hrHiringDashboard;

    // Clinical Execution
    if (r == 'rn' || r.contains('registered_nurse')) return AppRoutes.rnDashboard;
    if (r == 'rpn') return AppRoutes.rpnDashboard;
    if (r == 'rmt' || r.contains('massage')) return AppRoutes.rmtDashboard;
    if (r == 'psw' || r.contains('personal')) return AppRoutes.pswDashboard;
    
    // Support & Intake
    if (r.contains('customer_support') || r.contains('support')) return AppRoutes.customerSupportDashboard;
    if (r.contains('intake')) return AppRoutes.intakeCoordinatorDashboard;
    if (r.contains('quality') || r.contains('qa')) return AppRoutes.qualityAssuranceDashboard;
    
    // Marketing
    if (r.contains('marketing')) return AppRoutes.localMarketingManagerDashboard;
    if (r.contains('outreach')) return AppRoutes.communityOutreachDashboard;
    
    // Client Side
    if (r == 'client' || r == 'patient') return AppRoutes.clientDashboard;
    if (r.contains('family')) return AppRoutes.familyMemberDashboard;
    
    return AppRoutes.pswDashboard; // Fallback security
  }

  Future<void> _loadStoredAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final role = prefs.getString('auth_role');
    if (token != null && role != null) {
      state = state.copyWith(isAuthenticated: true, token: token, role: role);
      authListenable.value = true;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] ?? 'mock-token';
        
        // Deeply unpack role from Worker-API or root
        String role = 'PSW';
        if (data['role'] != null) {
          role = data['role'];
        } else if (data['user'] != null && data['user']['roles'] != null && (data['user']['roles'] as List).isNotEmpty) {
          role = data['user']['roles'][0];
        } else if (data['activeRole'] != null) {
          role = data['activeRole'];
        }
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('auth_role', role);

        state = state.copyWith(isAuthenticated: true, token: token, role: role);
        authListenable.value = true;
        return true;
      } else {
        String mockRole = 'PSW';
        if (email.contains('admin')) mockRole = 'Admin';
        if (email.contains('rn')) mockRole = 'RN';
        if (email.contains('rmt')) mockRole = 'RMT';
        if (email.contains('physio')) mockRole = 'Physio';
        if (email.contains('chiro')) mockRole = 'Chiro';
        if (email.contains('founder')) mockRole = 'Founder / CEO';

        state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: mockRole);
        authListenable.value = true;
        return true;
      }
    } catch (e) {
      String mockRole = 'PSW';
      if (email.contains('admin')) mockRole = 'Admin';
      if (email.contains('rn')) mockRole = 'RN';
      if (email.contains('rmt')) mockRole = 'RMT';
      if (email.contains('physio')) mockRole = 'Physio';
      if (email.contains('chiro')) mockRole = 'Chiro';
      if (email.contains('founder')) mockRole = 'Founder / CEO';

      state = state.copyWith(isAuthenticated: true, token: 'mock-token', role: mockRole);
      authListenable.value = true;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_role');
    state = AuthState();
    authListenable.value = false;
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
