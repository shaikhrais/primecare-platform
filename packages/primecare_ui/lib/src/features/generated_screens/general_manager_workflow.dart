// Generated from SQLite DB (.agents/governance/governance.db) - Single Source of Truth
// Screen Code: general_manager_workflow | Role: General Manager | App: PrimeCare UI Client
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final general_manager_workflowDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  try {
    final response = await api.get('/v1/general-manager-workflow');
    return response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {};
  } catch (_) {
    return {'status': 'success', 'module': 'general_manager_workflow'};
  }
});

/// GeneralManagerWorkflowScreen - Governed screen implementation for PrimeCare UI Client (General Manager).
/// Business Purpose: Provides a dedicated management interface within the PrimeCare UI Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanagerworkflowscreen.
class GeneralManagerWorkflowScreen extends GovernedConsumerWidget {
  const GeneralManagerWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(general_manager_workflowDataProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'PRIMECARE UI CLIENT',
                style: const TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'GeneralManagerWorkflowScreen',
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
            // Business Purpose Header Card
            Container(
              width: double.infinity,
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
                    children: [
                      const Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Target Role: General Manager',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF475569),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Provides a dedicated management interface within the PrimeCare UI Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanagerworkflowscreen.',
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Screen Sections from DB
            const Text(
              'Screen Sections',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),
            ..._buildSections(context),

            const SizedBox(height: 24),
            // UI Controls & Selectors
            const Text(
              'UI Elements & Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),
            ..._buildElements(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    final sectionData = ["Header Section", "Task Filters Section", "Task List Section", "Task Details Section", "Action Bar Section"];
    return sectionData.map((secName) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.view_quilt_outlined, color: Color(0xFF64748B)),
          const SizedBox(width: 12),
          Text(secName, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildElements(BuildContext context) {
    final elementData = ["GeneralManagerWorkflowScreen Screen Root", "GeneralManagerWorkflowScreen Page Title", "GeneralManagerWorkflowScreen Primary Content", "Generalmanagerworkflow Screen", "Generalmanagerworkflow Content", "Generalmanagerworkflow Btn 1", "Generalmanagerworkflow Btn 2", "Generalmanagerworkflow Btn 3", "Generalmanagerworkflow Title"];
    return elementData.map((elName) => Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(elName, style: const TextStyle(fontSize: 13, color: Color(0xFF334155))),
          Semantics(
            label: elName.toLowerCase().replaceAll(' ', '_'),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              ),
              child: const Text('Execute', style: TextStyle(fontSize: 11, color: Colors.white)),
            ),
          ),
        ],
      ),
    )).toList();
  }
}
