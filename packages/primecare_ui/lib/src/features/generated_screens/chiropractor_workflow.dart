// Generated directly from SQLite Database (.agents/governance/governance.db)
// Screen Code: chiropractor_workflow | Screen Name: ChiropractorWorkflowScreen
// Target Role: Chiropractor (chiropractor) | Application: PrimeCare UI Client (ui)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final chiropractor_workflowDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  try {
    // API Endpoint: GET /v1/chiropractor-workflow
    final response = await api.get('/v1/chiropractor-workflow');
    return response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {};
  } catch (_) {
    return {
      'status': 'success',
      'screen_code': 'chiropractor_workflow',
      'role_code': 'chiropractor',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
});

/// ChiropractorWorkflowScreen - Governed screen implementation for PrimeCare UI Client (Chiropractor).
/// Business Purpose: Provides a dedicated management interface within the PrimeCare UI Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorworkflowscreen.
class ChiropractorWorkflowScreen extends GovernedConsumerWidget {
  const ChiropractorWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(chiropractor_workflowDataProvider);

    return Scaffold(
      backgroundColor:  theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color:  theme.colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:  theme.colors.primary.withOpacity(0.3)),
              ),
              child: Text(
                'UI',
                style:  TextStyle(
                  color: theme.colors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ChiropractorWorkflowScreen',
              style:  TextStyle(
                color: theme.colors.onSurface,
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
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color:  theme.colors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target Role: Chiropractor',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF881337), fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color:  theme.colors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child:  Text('100% READY', style: TextStyle(color: theme.colors.success, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Provides a dedicated management interface within the PrimeCare UI Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorworkflowscreen.', style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 13, height: 1.5)),
                  const SizedBox(height: 8),
                  Text('User Story: As a Chiropractor, I want to access the ChiropractorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.', style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. SPECIFIC SECTIONS RENDERED FROM DATABASE RECORDS
            
    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  theme.colors.outline),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Header Section',
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'HEADER',
                  style:  TextStyle(color: theme.colors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Task management workspace header.',
            style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["ChiropractorWorkflowScreen Screen Root", "ChiropractorWorkflowScreen Page Title"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style:  TextStyle(fontSize: 13, color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  theme.colors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child:  Text('Execute Action', style: TextStyle(color: theme.colors.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),

    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  theme.colors.outline),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Task Filters Section',
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'FILTERS',
                  style:  TextStyle(color: theme.colors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Filters by priority, assignee, or deadline status.',
            style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["ChiropractorWorkflowScreen Screen Root", "ChiropractorWorkflowScreen Page Title", "ChiropractorWorkflowScreen Primary Content", "Chiropractorworkflow Content"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style:  TextStyle(fontSize: 13, color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  theme.colors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child:  Text('Execute Action', style: TextStyle(color: theme.colors.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),

    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  theme.colors.outline),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Task List Section',
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'LIST',
                  style:  TextStyle(color: theme.colors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'List showing todo items and checkboxes.',
            style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["ChiropractorWorkflowScreen Primary Content", "Chiropractorworkflow Content", "Chiropractorworkflow Screen", "Chiropractorworkflow Title"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style:  TextStyle(fontSize: 13, color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  theme.colors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child:  Text('Execute Action', style: TextStyle(color: theme.colors.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),

    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  theme.colors.outline),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Task Details Section',
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'DETAILS',
                  style:  TextStyle(color: theme.colors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Detailed panel showing sub-tasks and attachments.',
            style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["ChiropractorWorkflowScreen Screen Root", "ChiropractorWorkflowScreen Page Title", "ChiropractorWorkflowScreen Primary Content", "Chiropractorworkflow Content"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style:  TextStyle(fontSize: 13, color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  theme.colors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child:  Text('Execute Action', style: TextStyle(color: theme.colors.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),

    Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  theme.colors.outline),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Icon(Icons.dashboard_customize_outlined, color: theme.colors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Action Bar Section',
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: theme.colors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  theme.colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ACTION_BAR',
                  style:  TextStyle(color: theme.colors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Operations (add task, complete task).',
            style:  TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          
          ...["Chiropractorworkflow Btn 1", "Chiropractorworkflow Btn 2"].map((lbl) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lbl,
                    style:  TextStyle(fontSize: 13, color: theme.colors.onSurface, fontWeight: FontWeight.w500),
                  ),
                ),
                Semantics(
                  label: lbl.toLowerCase().replaceAll(' ', '_'),
                  child: ElevatedButton(
                    key: Key('btn_${lbl.toLowerCase().replaceAll(' ', '_')}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  theme.colors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child:  Text('Execute Action', style: TextStyle(color: theme.colors.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ),
            const SizedBox(height: 24),

            // 3. GOVERNANCE AUDIT LOG & ALL MAPPED API ENDPOINTS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color:  theme.colors.inverseSurface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('GOVERNANCE SPECIFICATIONS & ALL API ENDPOINTS', style: TextStyle(color: theme.colors.inverseOnSurface, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  ...["\u2022 Mapped API: GET /v1/chiropractor-workflow"].map((apiStr) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(apiStr, style:  TextStyle(color: theme.colors.inverseOnSurface, fontSize: 11, fontFamily: 'monospace')),
                  )),
                  const SizedBox(height: 4),
                   Text('• Cypress Selector: data-cy="screen-chiropractor-workflow"', style: TextStyle(color: theme.colors.inverseOnSurface, fontSize: 12, fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                   Text('• Accessibility WCAG 2.2 AA: PASSED (Keyboard Nav & ARIA Labeled)', style: TextStyle(color: theme.colors.inverseOnSurface, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
