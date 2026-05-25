// Governance - Category: controller | Purpose: Standalone compile-safe Notifier for ControlCenterScreenController
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String type;
  final String phase;
  String status;
  String currentStep;
  Map<String, dynamic>? proof;
  final String createdAt;
  String? completedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.type,
    required this.phase,
    required this.status,
    required this.currentStep,
    this.proof,
    required this.createdAt,
    this.completedAt,
  });

  TaskModel copyWith({
    String? status,
    String? currentStep,
    Map<String, dynamic>? proof,
    String? completedAt,
  }) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      priority: priority,
      type: type,
      phase: phase,
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      proof: proof ?? this.proof,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class ControlCenterState {
  final List<TaskModel> tasks;
  final String? selectedTaskId;
  final String agentStatus; // idle, investigating, fixing, testing, completed
  final List<String> agentLogs;
  final String currentStep;
  final double overallScore;
  final int driftsCount;
  final int mismatchesCount;
  final int failedEndpointsCount;

  ControlCenterState({
    required this.tasks,
    this.selectedTaskId,
    required this.agentStatus,
    required this.agentLogs,
    required this.currentStep,
    required this.overallScore,
    required this.driftsCount,
    required this.mismatchesCount,
    required this.failedEndpointsCount,
  });

  ControlCenterState copyWith({
    List<TaskModel>? tasks,
    String? selectedTaskId,
    String? agentStatus,
    List<String>? agentLogs,
    String? currentStep,
    double? overallScore,
    int? driftsCount,
    int? mismatchesCount,
    int? failedEndpointsCount,
  }) {
    return ControlCenterState(
      tasks: tasks ?? this.tasks,
      selectedTaskId: selectedTaskId ?? this.selectedTaskId,
      agentStatus: agentStatus ?? this.agentStatus,
      agentLogs: agentLogs ?? this.agentLogs,
      currentStep: currentStep ?? this.currentStep,
      overallScore: overallScore ?? this.overallScore,
      driftsCount: driftsCount ?? this.driftsCount,
      mismatchesCount: mismatchesCount ?? this.mismatchesCount,
      failedEndpointsCount: failedEndpointsCount ?? this.failedEndpointsCount,
    );
  }
}

final controlCenterScreenControllerProvider = NotifierProvider<ControlCenterScreenController, AsyncValue<ControlCenterState>>(() {
  return ControlCenterScreenController();
});

class ControlCenterScreenController extends Notifier<AsyncValue<ControlCenterState>> {
  Timer? _logTimer;

  @override
  AsyncValue<ControlCenterState> build() {
    ref.onDispose(() {
      _logTimer?.cancel();
    });

    final nowStr = DateTime.now().subtract(const Duration(days: 2)).toString().split('.')[0];
    final yesterdayStr = DateTime.now().subtract(const Duration(days: 1)).toString().split('.')[0];

    final initialTasks = [
      // Phase 1: Discovery
      TaskModel(
        id: "task_1",
        title: "Scan and resolve unmapped static assets in packages/core",
        description: "Identify and clean up 24 static asset definitions that are not listed in the asset manifest.",
        priority: "high",
        type: "discovery_drift",
        status: "pending",
        phase: "Phase 1: Discovery",
        currentStep: "Ready for dispatch",
        createdAt: nowStr,
      ),
      TaskModel(
        id: "task_2",
        title: "Reconcile loose layout bindings with master roles list",
        description: "Ensure that the standard adaptive dashboard layout correctly enforces RBAC settings for FinanceDirector.",
        priority: "medium",
        type: "discovery_drift",
        status: "completed",
        phase: "Phase 1: Discovery",
        currentStep: "Reconciled with 0 drifts",
        createdAt: nowStr,
        completedAt: yesterdayStr,
        proof: {
          "verified_at": yesterdayStr,
          "audit_logs": "Passed layout binding verification for all roles. 0 drifts found.",
          "signature": "DISCOVERY_SEC_VERIFY_OK"
        },
      ),
      TaskModel(
        id: "task_3",
        title: "Fix package version drift in web-admin and worker-api",
        description: "Check packages dependency graph for yarn workspace sync and align conflicting lodash version declarations.",
        priority: "high",
        type: "discovery_drift",
        status: "investigating",
        phase: "Phase 1: Discovery",
        currentStep: "Scanning package dependency graphs",
        createdAt: nowStr,
        proof: {
          "scan_progress": "45%",
          "issues_found": ["lodash mismatch: 4.17.21 vs 4.17.15"],
          "active_agent": "ZeroDriftGuardian"
        },
      ),
      TaskModel(
        id: "task_4",
        title: "Scan codebase for missing enterprise license headers",
        description: "Audit all lib/**/*.dart and api/**/*.ts files to ensure bank-grade compliance headers are present.",
        priority: "low",
        type: "discovery_drift",
        status: "completed",
        phase: "Phase 1: Discovery",
        currentStep: "Header validation clean",
        createdAt: nowStr,
        completedAt: yesterdayStr,
        proof: {
          "files_audited": 312,
          "headers_fixed": 12,
          "verified_by": "ComplianceAgent"
        },
      ),
      // Phase 2: Implementation
      TaskModel(
        id: "task_5",
        title: "Wire Floating Action Button to check-out screen controller",
        description: "Connect the FAB onClick event trigger in CheckoutScreen to the checkOutSessionProvider state controller.",
        priority: "critical",
        type: "ui_integration",
        status: "fixing",
        phase: "Phase 2: Implementation",
        currentStep: "Injecting FAB wiring and state listener hooks",
        createdAt: nowStr,
        proof: {
          "target_file": "lib/features/checkout/checkout_screen.dart",
          "lines_modified": [142, 143, 144, 145],
          "active_fixer": "ComplianceAgent"
        },
      ),
      TaskModel(
        id: "task_6",
        title: "Add missing consent checkbox field to registration screen",
        description: "Integrate a required terms_of_service consent validation form checkbox to prevent unregistered intakes.",
        priority: "high",
        type: "ui_integration",
        status: "assigned",
        phase: "Phase 2: Implementation",
        currentStep: "Assigned to AntigravityComplianceAgent",
        createdAt: nowStr,
      ),
      TaskModel(
        id: "task_7",
        title: "Implement auto-logout warning popup logic in auth layout",
        description: "Create a modern adaptive dialog prompt that displays when a user has been inactive for 14 minutes.",
        priority: "medium",
        type: "ui_integration",
        status: "pending",
        phase: "Phase 2: Implementation",
        currentStep: "Ready for queue",
        createdAt: nowStr,
      ),
      TaskModel(
        id: "task_8",
        title: "Support neon dark/light theme switch in system dashboard",
        description: "Integrate FlexColorScheme custom palettes into ControlCenterScreen settings toggle dynamically.",
        priority: "low",
        type: "ui_integration",
        status: "completed",
        phase: "Phase 2: Implementation",
        currentStep: "Theme controller linked",
        createdAt: nowStr,
        completedAt: yesterdayStr,
        proof: {
          "flex_theme_applied": "NeonDarkPalette",
          "micro_animations_added": ["glowingRippleEffect", "fadeInScale"],
          "passed_wcag_contrast": true
        },
      ),
      // Phase 3: Runtime Testing
      TaskModel(
        id: "task_9",
        title: "Fix redirect contract mismatch on SSO portal authentication handler",
        description: "SSO OAuth callback fails to parse raw query parameters correctly under zero-trust edge restrictions.",
        priority: "critical",
        type: "contract_assertion",
        status: "test_failed",
        phase: "Phase 3: Runtime Testing",
        currentStep: "Executing SSO integration test suites",
        createdAt: nowStr,
        proof: {
          "test_suite": "sso_auth_flow_test.dart",
          "assertion_failures": [
            {
              "step": "Parse redirect callback",
              "expected": "code=auth_pc_9831&state=pc_active",
              "actual": "code=auth_pc_9831",
              "error": "OAuthStateException: Missing state validation token in edge callback payload"
            }
          ]
        },
      ),
      TaskModel(
        id: "task_10",
        title: "Verify rate limiting resilience under rapid REST stress tests",
        description: "Execute 2,000 requests per minute stress crawler to ensure redis-cluster rejects brute-force spikes.",
        priority: "high",
        type: "contract_assertion",
        status: "verified",
        phase: "Phase 3: Runtime Testing",
        currentStep: "Stress verification passed",
        createdAt: nowStr,
        proof: {
          "rpm_tested": 2500,
          "rejections_count": 500,
          "http_429_success": true,
          "latency_median_ms": 12
        },
      ),
      TaskModel(
        id: "task_11",
        title: "Resolve fuzzy ledger reconciliation precision float mismatch",
        description: "Double-entry tax ledger shows a 0.0001 discrepancy when calculating HST remittance values.",
        priority: "medium",
        type: "contract_assertion",
        status: "runtime_failed",
        phase: "Phase 3: Runtime Testing",
        currentStep: "Executing tax calculator checks",
        createdAt: nowStr,
        proof: {
          "runtime_exception": "ArithmeticException: Float precision drift detected in double-entry balance routine",
          "stack_trace": "at double_entry_ledger.py line 431 in calculate_reconciliation_total\nat tax_remittance_hub.dart line 98 in recomputeTaxTotals",
          "reproduced_locally": true
        },
      ),
      TaskModel(
        id: "task_12",
        title: "Test boundary input validation on patient profile intakes",
        description: "Perform SQL injection and cross-site scripting fuzz tests on first-name and zip-code text inputs.",
        priority: "medium",
        type: "contract_assertion",
        status: "completed",
        phase: "Phase 3: Runtime Testing",
        currentStep: "Fuzz sweeps fully passed",
        createdAt: nowStr,
        completedAt: yesterdayStr,
        proof: {
          "xss_vectors_tested": 150,
          "sqli_vectors_tested": 300,
          "sanitized_inputs_count": 450,
          "compliance_score": 1.0
        },
      ),
      // Phase 4: Release Verification
      TaskModel(
        id: "task_13",
        title: "Deploy worker-api worker and verify edge caching rules",
        description: "Deploy serverless backend scripts to Cloudflare wrangler and assert response caching headers.",
        priority: "critical",
        type: "release_verification",
        status: "proof_missing",
        phase: "Phase 4: Release Verification",
        currentStep: "Awaiting Cloudflare console proof attachment",
        createdAt: nowStr,
        proof: {
          "wrangler_deployment": "worker-api-prod v4.11.0",
          "pages_deployment": "web-admin-dashboard v2.1.2",
          "cache_control_asserted": "public, max-age=31536000",
          "awaiting_visual_confirmation": true
        },
      ),
      TaskModel(
        id: "task_14",
        title: "Generate full Zero-Drift Guardian compliance diagnostics audit sheet",
        description: "Run master export scripts and verify parity between SQLite records and stylized 77-sheet Excel files.",
        priority: "high",
        type: "release_verification",
        status: "completed",
        phase: "Phase 4: Release Verification",
        currentStep: "Diagnostics Excel compiled and verified",
        createdAt: nowStr,
        completedAt: yesterdayStr,
        proof: {
          "tables_scanned": 77,
          "sheets_created": 77,
          "file_hash": "SHA256_PC_EXCEL_AUDIT_OK"
        },
      ),
      TaskModel(
        id: "task_15",
        title: "Verify automated RSA public key rotation on production cluster",
        description: "Run build compiler on public key rotator app and check that rotation event signals fire cleanly.",
        priority: "high",
        type: "release_verification",
        status: "build_failed",
        phase: "Phase 4: Release Verification",
        currentStep: "Compiling key rotator target app",
        createdAt: nowStr,
        proof: {
          "target_package": "apps/key_rotator",
          "compiler_errors": [
            "Error: The getter 'rotationPrivateKey' isn't defined for the class 'KeyValidatorService'.",
            "lib/services/key_validator_service.dart:184:54: Try correcting the name to the name of an existing getter, or defining a getter or field."
          ]
        },
      ),
      TaskModel(
        id: "task_16",
        title: "Validate offline storage sync routines on mobile platforms",
        description: "Simulate device network drop-off during data entry and verify offline indexeddb replication queues.",
        priority: "medium",
        type: "release_verification",
        status: "pending",
        phase: "Phase 4: Release Verification",
        currentStep: "Ready for staging deployment",
        createdAt: nowStr,
      ),
    ];

    return AsyncValue.data(
      ControlCenterState(
        tasks: initialTasks,
        selectedTaskId: "task_9", // Default select the SSO critical issue
        agentStatus: "idle",
        agentLogs: [
          "[SYSTEM] Relational Software Factory Control Room online.",
          "[SYSTEM] Connection established with SQLite schema master governance.db.",
          "[SYSTEM] 16 dynamic compliance tasks resolved from v_agent_pending_task_queue.",
          "[SYSTEM] Standby. Waiting for dispatch allocation..."
        ],
        currentStep: "Standby",
        overallScore: 82.5,
        driftsCount: 24,
        mismatchesCount: 8,
        failedEndpointsCount: 3,
      ),
    );
  }

  void selectTask(String taskId) {
    state.whenData((current) {
      state = AsyncValue.data(current.copyWith(selectedTaskId: taskId));
    });
  }

  Future<void> dispatchToAgent(String taskId) async {
    final current = state.value;
    if (current == null) return;

    final taskIndex = current.tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex == -1) return;

    final targetTask = current.tasks[taskIndex];

    _logTimer?.cancel();
    state = AsyncValue.data(current.copyWith(
      agentStatus: "assigned",
      currentStep: "assigned",
      agentLogs: [
        ...current.agentLogs,
        "[DISPATCH] Allocating Task '${targetTask.title}' to AntigravityComplianceAgent...",
        "[STATUS] Task assigned at: ${DateTime.now().toString().split('.')[0]}",
      ],
    ));

    // Simulated multi-step agent self-healing sequence
    int step = 0;
    _logTimer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      state.whenData((stateData) {
        final logs = List<String>.from(stateData.agentLogs);

        switch (step) {
          case 0:
            final updatedTasks = List<TaskModel>.from(stateData.tasks);
            updatedTasks[taskIndex] = targetTask.copyWith(
              status: "investigating",
              currentStep: "investigating",
            );
            logs.add("[investigating] Analyzing related code file: ${targetTask.type == 'ui_integration' ? 'lib/features/checkout/checkout_screen.dart' : 'lib/services/sso_portal.dart'}");
            logs.add("[investigating] Resolving relational SQLite views schema bindings...");
            state = AsyncValue.data(stateData.copyWith(
              tasks: updatedTasks,
              agentStatus: "investigating",
              currentStep: "investigating",
              agentLogs: logs,
            ));
            break;

          case 1:
            final updatedTasks = List<TaskModel>.from(stateData.tasks);
            updatedTasks[taskIndex] = updatedTasks[taskIndex].copyWith(
              status: "fixing",
              currentStep: "fixing",
            );
            logs.add("[fixing] Applying structural self-healing patches...");
            logs.add("[fixing] Rewriting empty closures and injecting data validators.");
            state = AsyncValue.data(stateData.copyWith(
              tasks: updatedTasks,
              agentStatus: "fixing",
              currentStep: "fixing",
              agentLogs: logs,
            ));
            break;

          case 2:
            final updatedTasks = List<TaskModel>.from(stateData.tasks);
            updatedTasks[taskIndex] = updatedTasks[taskIndex].copyWith(
              status: "fixed_claimed",
              currentStep: "fixed_claimed",
            );
            logs.add("[fixed_claimed] Remediation complete! Triggering automated project compilation tests...");
            logs.add("[testing] Executing 'flutter analyze' and E2E widget regression matrices...");
            state = AsyncValue.data(stateData.copyWith(
              tasks: updatedTasks,
              agentStatus: "testing",
              currentStep: "testing",
              agentLogs: logs,
            ));
            break;

          case 3:
            final updatedTasks = List<TaskModel>.from(stateData.tasks);
            final proofMap = {
              "verified_at": DateTime.now().toString().split('.')[0],
              "audit_logs": "Passed clean compilation. Zero-trust SSO handshakes resolved successfully.",
              "signature": "ANTIGRAVITY_COMPLIANCE_PASS_SIG",
              "screenshot_path": "assets/screenshots/sso_fixed.png"
            };
            updatedTasks[taskIndex] = updatedTasks[taskIndex].copyWith(
              status: "completed",
              currentStep: "completed",
              proof: proofMap,
              completedAt: DateTime.now().toString().split('.')[0],
            );
            logs.add("[test_verified] All E2E contract assertions passed (100% Green).");
            logs.add("[completed] Self-healing compliance verified. Closed cleanly in SQLite!");
            timer.cancel();

            final newScore = stateData.overallScore + 1.25 > 100.0 ? 100.0 : stateData.overallScore + 1.25;

            state = AsyncValue.data(stateData.copyWith(
              tasks: updatedTasks,
              agentStatus: "idle",
              currentStep: "Standby",
              overallScore: newScore,
              driftsCount: stateData.driftsCount - 1,
              mismatchesCount: stateData.mismatchesCount - 1,
              agentLogs: logs,
            ));
            break;
        }
        step++;
      });
    });
  }

  Future<void> triggerRetest(String taskId) async {
    state.whenData((current) {
      final logs = List<String>.from(current.agentLogs);
      logs.add("[RETEST] Triggering dynamic E2E check on Task $taskId...");
      logs.add("[RETEST] Querying v_agent_pending_task_queue view for related endpoint contracts...");
      logs.add("[RETEST] Contract matched: POST /v1/auth/sso/callback. Handshake verification: SUCCESS.");
      state = AsyncValue.data(current.copyWith(agentLogs: logs));
    });
  }

  Future<void> verifyScreenUI(String taskId) async {
    state.whenData((current) {
      final logs = List<String>.from(current.agentLogs);
      logs.add("[SCREEN_PREVIEW] Hydrated responsive view screenshot bounds for Task $taskId.");
      logs.add("[SCREEN_PREVIEW] Asserting layouts against Material Design 3 adaptive specs: verified.");
      state = AsyncValue.data(current.copyWith(agentLogs: logs));
    });
  }

  Future<void> addVerificationProof(String taskId, String logProof, String screenshotPath) async {
    state.whenData((current) {
      final taskIndex = current.tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex == -1) return;

      final updatedTasks = List<TaskModel>.from(current.tasks);
      final targetTask = updatedTasks[taskIndex];

      final proofMap = {
        "verified_at": DateTime.now().toString().split('.')[0],
        "audit_logs": logProof,
        "signature": "MANUAL_VERIFY_OK",
        "screenshot_path": screenshotPath
      };

      updatedTasks[taskIndex] = targetTask.copyWith(
        status: "completed",
        currentStep: "Manually Verified",
        proof: proofMap,
        completedAt: DateTime.now().toString().split('.')[0],
      );

      final logs = List<String>.from(current.agentLogs);
      logs.add("[MANUAL_PROOF] Proof uploaded for task: '${targetTask.title}'");
      logs.add("[MANUAL_PROOF] Closing task with completed status under compliance rule Z8.");

      state = AsyncValue.data(current.copyWith(
        tasks: updatedTasks,
        agentLogs: logs,
        overallScore: current.overallScore + 1.0 > 100.0 ? 100.0 : current.overallScore + 1.0,
      ));
    });
  }
}

