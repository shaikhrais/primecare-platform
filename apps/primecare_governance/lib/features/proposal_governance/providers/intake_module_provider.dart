import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/proposal_intake.dart';
import '../services/proposal_data_collection_service.dart';
import '../services/compliance_checklist_service.dart';
import 'proposal_provider.dart';
import '../services/flow_runner_service.dart';

part 'intake_module_provider.g.dart';

enum IntakeStage {
  initial,
  business,
  technical,
  collection, // New stage
  compliance,
  review,
  completed
}

class IntakeState {
  final ProposalIntake? proposal;
  final IntakeStage stage;
  final bool isProcessing;
  final List<String> logs;
  final String? stitchPrompt;
  final bool isStitchComplete;
  final bool isDeployed;
  final ComplianceCheckResult? complianceResult;

  IntakeState({
    this.proposal,
    this.stage = IntakeStage.initial,
    this.isProcessing = false,
    this.logs = const [],
    this.stitchPrompt,
    this.isStitchComplete = false,
    this.isDeployed = false,
    this.complianceResult,
  });

  IntakeState copyWith({
    ProposalIntake? proposal,
    IntakeStage? stage,
    bool? isProcessing,
    List<String>? logs,
    String? stitchPrompt,
    bool? isStitchComplete,
    bool? isDeployed,
    ComplianceCheckResult? complianceResult,
  }) {
    return IntakeState(
      proposal: proposal ?? this.proposal,
      stage: stage ?? this.stage,
      isProcessing: isProcessing ?? this.isProcessing,
      logs: logs ?? this.logs,
      stitchPrompt: stitchPrompt ?? this.stitchPrompt,
      isStitchComplete: isStitchComplete ?? this.isStitchComplete,
      isDeployed: isDeployed ?? this.isDeployed,
      complianceResult: complianceResult ?? this.complianceResult,
    );
  }
}

@riverpod
class IntakeModule extends _$IntakeModule {
  @override
  IntakeState build() {
    return IntakeState();
  }

  /// Step 1: Process the raw prompt
  Future<void> processPrompt(String prompt) async {
    state = state.copyWith(isProcessing: true, logs: [...state.logs, 'Ingesting prompt: $prompt']);
    
    final service = ref.read(proposalDataCollectionServiceProvider);
    final proposal = await service.createFromPrompt(prompt);
    
    state = state.copyWith(
      proposal: proposal,
      stage: IntakeStage.business,
      isProcessing: false,
      logs: [...state.logs, 'Draft created: ${proposal.title}'],
    );
  }

  /// Step 2: Enrich from registries
  Future<void> enrichFromRegistries() async {
    if (state.proposal == null) return;
    
    state = state.copyWith(isProcessing: true, logs: [...state.logs, 'Synthesizing with Screen Registry...']);
    
    final service = ref.read(proposalDataCollectionServiceProvider);
    final enriched = await service.enrichFromRegistry(state.proposal!);
    
    state = state.copyWith(
      proposal: enriched,
      stage: IntakeStage.collection, // Transition to collection
      isProcessing: false,
      logs: [...state.logs, 'Registry alignment complete.'],
    );
  }

  /// Step 3: Run Proposal Data Collection Module
  /// Aggregates data from Role Matrix, API Registry, and Design Sources.
  Future<void> runDataCollectionModule() async {
    if (state.proposal == null) return;

    state = state.copyWith(isProcessing: true, logs: [...state.logs, 'Running Data Collection Module...']);

    final service = ref.read(proposalDataCollectionServiceProvider);
    final collected = await service.collectFromMultiSource(state.proposal!);

    state = state.copyWith(
      proposal: collected,
      stage: IntakeStage.compliance, // Transition to compliance
      isProcessing: false,
      logs: [...state.logs, 'Multi-source data collection complete.'],
    );
  }

  /// Step 3: Run Compliance Scan
  Future<void> runComplianceScan() async {
    if (state.proposal == null) return;
    
    state = state.copyWith(isProcessing: true, logs: [...state.logs, 'Running Deep Compliance Scan...']);
    
    final complianceService = ref.read(complianceChecklistServiceProvider);
    final result = await complianceService.runDeepScan(state.proposal!);
    
    state = state.copyWith(
      complianceResult: result,
      stage: IntakeStage.review, // Transition to review
      isProcessing: false,
      logs: [
        ...state.logs, 
        'Compliance scan complete. Risk Score: ${result.riskScore.toStringAsFixed(2)}',
        if (!result.passed) '[SECURITY ALERT] ${result.violations.length} compliance violations found.',
      ],
    );
  }

  /// Step 4: Finalize for Review
  void finalizeForReview() {
    state = state.copyWith(stage: IntakeStage.review);
  }

  /// Final Step: Submit to Proposal List
  Future<void> submit() async {
    if (state.proposal == null) return;
    
    state = state.copyWith(isProcessing: true);
    await ref.read(proposalListProvider.notifier).addProposal(state.proposal!);
    
    state = state.copyWith(
      stage: IntakeStage.completed,
      isProcessing: false,
      logs: [...state.logs, 'Proposal submitted to Governance HUD.'],
    );
  }

  /// Bridging Step: Prepare for Stitch UI Engine
  void prepareStitchGeneration() {
    if (state.proposal == null) return;
    
    final service = ref.read(proposalDataCollectionServiceProvider);
    final prompt = service.toStitchPrompt(state.proposal!);
    
    state = state.copyWith(
      stitchPrompt: prompt,
      logs: [...state.logs, 'Stitch UI Blueprint generated. Ready for engine handoff.'],
    );
  }

  /// Mark Stitch as complete (simulated callback)
  void notifyStitchComplete() {
    state = state.copyWith(
      isStitchComplete: true,
      logs: [...state.logs, 'Stitch UI Engine: Screen generation successful.'],
    );
  }

  /// Bridge to Production: Run Flow Runner
  Future<bool> deployToPlatform() async {
    if (state.proposal == null) return false;

    
    state = state.copyWith(isProcessing: true, logs: [...state.logs, 'Initializing Flow Runner...']);
    
    final flowRunner = ref.read(flowRunnerServiceProvider);
    final success = await flowRunner.deployProposal(state.proposal!);
    
    if (success) {
      state = state.copyWith(
        isProcessing: false,
        isDeployed: true,
        logs: [...state.logs, 'Production injection successful. Screen registered and UI generated.'],
      );
      return true;
    } else {
      state = state.copyWith(
        isProcessing: false,
        isDeployed: false,
        logs: [...state.logs, 'Deployment failed: Registry conflict or AST error.'],
      );
      return false;
    }
  }

  void reset() {
    state = IntakeState();
  }
}
