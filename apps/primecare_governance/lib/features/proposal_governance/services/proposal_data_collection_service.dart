import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/proposal_intake.dart';
import '../../../core/governance/screen_registry.dart';

/// [ProposalDataCollectionService] - Orchestrates the multi-source intake process
/// for new feature proposals, ensuring architectural and compliance alignment.
class ProposalDataCollectionService {
  final Ref ref;

  ProposalDataCollectionService(this.ref);

  /// Initiates a proposal from a raw user/stakeholder prompt.
  /// Simulates AI extraction of intent, goals, and priority.
  Future<ProposalIntake> createFromPrompt(String prompt) async {
    // Simulated AI Processing Delay
    await Future.delayed(const Duration(milliseconds: 1200));

    final id = const Uuid().v4();
    final isClinical = prompt.toLowerCase().contains('patient') || 
                       prompt.toLowerCase().contains('psw') || 
                       prompt.toLowerCase().contains('vitals');
    
    final isFinance = prompt.toLowerCase().contains('billing') || 
                      prompt.toLowerCase().contains('revenue') || 
                      prompt.toLowerCase().contains('invoice');

    return ProposalIntake(
      id: id,
      title: _extractTitle(prompt),
      description: prompt,
      requestedBy: 'System AI (extracted)',
      department: isClinical ? 'Clinical' : (isFinance ? 'Finance' : 'Operations'),
      office: 'HQ',
      role: isClinical ? 'PSW' : (isFinance ? 'Billing Admin' : 'Staff'),
      priority: prompt.toLowerCase().contains('urgent') ? 'p0' : 'p2',
      businessGoal: 'Extracted from: $prompt',
      problemStatement: 'Automated extraction pending...',
      expectedOutcome: 'TBD via Stakeholder Interview',
      screenId: 'screen_${id.substring(0, 8)}',
      routePath: '/${isClinical ? 'clinical' : (isFinance ? 'corporate' : 'ops')}/new_feature',
      allowedRoles: isClinical ? ['psw', 'rn'] : (isFinance ? ['billing_admin'] : ['admin']),
      requiredApis: _suggestApis(prompt),
      requiredComponents: _suggestComponents(prompt),
      requiredForms: [],
      designSource: 'text',
      designUrl: '',
      mockDataNotes: '',
      needsPhiData: isClinical,
      needsConsent: isClinical,
      needsSignature: isClinical,
      needsAuditLog: true,
      acceptanceCriteria: ['Feature matches original prompt: $prompt'],
      testScenarios: ['Verify security access for ${isClinical ? 'Clinical' : 'Finance'} roles'],
      createdAt: DateTime.now(),
    );
  }

  /// Enriches a proposal by checking the existing Screen Registry for conflicts or patterns.
  /// Handles scaling for the 251+ existing screens in the PrimeCare ecosystem.
  Future<ProposalIntake> enrichFromRegistry(ProposalIntake proposal) async {
    final existingScreens = ScreenRegistry.getAllScreens();
    
    // 1. Exact Conflict Check
    final idConflict = existingScreens.any((s) => s.id == proposal.screenId);
    final routeConflict = existingScreens.any((s) => s.routePath == proposal.routePath);
    
    // 2. Fuzzy Match Check (Semantic Similarity)
    final similarScreens = existingScreens.where((s) {
      final titleMatch = s.title.toLowerCase().contains(proposal.title.toLowerCase()) ||
                         proposal.title.toLowerCase().contains(s.title.toLowerCase());
      return titleMatch;
    }).toList();

    String refinedId = proposal.screenId;
    String refinedRoute = proposal.routePath;
    String refinedMockNotes = proposal.mockDataNotes;

    if (idConflict || routeConflict) {
      // Auto-remediate naming by appending a semantic suffix
      final count = existingScreens.where((s) => s.routePath.startsWith(proposal.routePath)).length;
      refinedId = '${proposal.screenId}_v${count + 1}';
      refinedRoute = '${proposal.routePath}_v${count + 1}';
      refinedMockNotes += '\n[Registry Warning] Potential collision detected with existing screens. Path auto-remediated.';
    }

    if (similarScreens.isNotEmpty) {
      refinedMockNotes += '\n[Registry Intel] Found ${similarScreens.length} similar screens. Consider merging logic with: ${similarScreens.map((e) => e.title).join(", ")}';
    }

    return proposal.copyWith(
      screenId: refinedId,
      routePath: refinedRoute,
      mockDataNotes: refinedMockNotes,
    );
  }

  /// Transforms a validated proposal into a high-fidelity Stitch UI Engine prompt.
  String toStitchPrompt(ProposalIntake proposal) {
    final componentList = proposal.requiredComponents.join(", ");
    final apiList = proposal.requiredApis.join(", ");
    
    return '''
Generate a premium ${proposal.department} screen for the PrimeCare Platform.
Title: ${proposal.title}
Role: ${proposal.role}
Intent: ${proposal.businessGoal}

Key Components to Include:
- Aura HUD (Primary Telemetry)
- $componentList
- Standard PrimeCare Layout

Data Integration:
- Connect to $apiList
- PHI Sensitive: ${proposal.needsPhiData ? 'YES' : 'NO'}
- Audit Log Required: ${proposal.needsAuditLog ? 'YES' : 'NO'}

Visual Style: Glassmorphism, Deep Blue/Slate palette, high-contrast typography (Inter).
''';
  }

  /// Aggregates data from multiple sources: Role Matrix, API Registry, Design Sources.
  Future<ProposalIntake> collectFromMultiSource(ProposalIntake proposal) async {
    await Future.delayed(const Duration(milliseconds: 1500)); // Simulate multi-source fetch

    final isClinical = proposal.department == 'Clinical';
    
    // Simulate Role Matrix Fetch
    final roles = isClinical ? ['clinical_director', 'rn', 'psw'] : ['admin', 'billing_admin'];
    
    // Simulate API Registry Fetch
    final apis = [...proposal.requiredApis];
    if (isClinical && !apis.contains('phi_protection_service')) {
      apis.add('phi_protection_service');
    }
    
    // Simulate Design Source Alignment
    final designSource = proposal.description.contains('figma') ? 'figma' : 'stitch';
    final designUrl = designSource == 'figma' ? 'https://figma.com/file/primecare_mockup' : '';

    return proposal.copyWith(
      allowedRoles: roles,
      requiredApis: apis,
      designSource: designSource,
      designUrl: designUrl,
      mockDataNotes: '${proposal.mockDataNotes}\n[Data Module] Roles synced from Matrix. APIs validated against Registry.',
    );
  }

  /// Runs a compliance scan based on the proposal content.
  ProposalIntake runComplianceScan(ProposalIntake proposal) {
    bool hasPhiKeywords = proposal.description.toLowerCase().contains('patient') || 
                          proposal.description.toLowerCase().contains('health') ||
                          proposal.description.toLowerCase().contains('medical');

    return proposal.copyWith(
      needsPhiData: hasPhiKeywords,
      needsAuditLog: true, // Mandatory for all new features in PrimeCare
    );
  }

  String _extractTitle(String prompt) {
    if (prompt.length < 30) return prompt;
    return '${prompt.substring(0, 27)}...';
  }

  List<String> _suggestApis(String prompt) {
    final apis = <String>[];
    if (prompt.contains('patient')) apis.add('patient_api');
    if (prompt.contains('billing')) apis.add('billing_api');
    if (prompt.contains('vitals')) apis.add('vitals_api');
    if (prompt.contains('auth')) apis.add('auth_api');
    return apis.isEmpty ? ['core_api'] : apis;
  }

  List<String> _suggestComponents(String prompt) {
    final comps = <String>[];
    if (prompt.contains('chart')) comps.add('LineChart');
    if (prompt.contains('list')) comps.add('DataGrid');
    if (prompt.contains('form')) comps.add('DynamicForm');
    return comps.isEmpty ? ['StandardLayout'] : comps;
  }
}

final proposalDataCollectionServiceProvider = Provider((ref) => ProposalDataCollectionService(ref));
