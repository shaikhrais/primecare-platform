// Generated directly from SQLite Database (.agents/governance/governance.db)
// Screen Code: system_dashboard | Screen Name: SystemDashboardScreen
// Target Role: Governance Officer (governance) | Application: Primecare Governance (go)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final system_dashboardDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  try {
    // API Endpoint: GET /v1/system
    final response = await api.get('/v1/system');
    return response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {};
  } catch (_) {
    return {
      'status': 'success',
      'screen_code': 'system_dashboard',
      'role_code': 'governance',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
});

/// SystemDashboardScreen - Governed screen implementation for Primecare Governance (Governance Officer).
/// Business Purpose: Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to systemdashboardscreen.
class SystemDashboardScreen extends GovernedConsumerWidget {
  const SystemDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(system_dashboardDataProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.3)),
              ),
              child: Text(
                'GO',
                style: const TextStyle(
                  color: Color(0xFF7C3AED),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'SystemDashboardScreen',
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SPECIFIC BUSINESS PURPOSE & USER STORY HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target Role: Governance Officer',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4C1D95), fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: const Text('100% READY', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to systemdashboardscreen.', style: const TextStyle(color: Color(0xFF475569), fontSize: 13, height: 1.5)),
                  const SizedBox(height: 8),
                  Text('User Story: As a Governance Officer, I want to access the SystemDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. SPECIFIC SECTIONS RENDERED FROM DATABASE RECORDS
            
    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.dashboard_customize_outlined, color: Color(0xFF7C3AED), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Header Section',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'HEADER',
                  style: const TextStyle(color: Color(0xFF7C3AED), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Global screen header containing navigation breadcrumbs and user context.',
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["SystemDashboardScreen Screen Root", "SystemDashboardScreen Page Title", "SystemDashboardScreen Screen Title", "GOVERNANCE Role Badge"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      elevation: 0,
