// Native implementation using sqlite3 and dart:io
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'screen_self_diagnosis.dart'; // brings in ScreenHealthStatus and registry

List<ScreenHealthStatus> loadAllScreensFromDb() {
  final dbPath = r"C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\.agents\\governance\\governance.db";
  if (!File(dbPath).existsSync()) {
    return screenHealthRegistry.values.toList();
  }
  try {
    final db = sqlite3.open(dbPath);
    final results = db.select('SELECT * FROM screens');
    final List<ScreenHealthStatus> list = [];
    for (final row in results) {
      final routePath = (row['route_path'] ?? '') as String;
      if (routePath.isEmpty) continue;
      final progress = (row['progress_percent'] ?? 0) as int;
      final isPlaceholder = (row['blocker'] != null && (row['blocker'] as String).contains('Placeholder'));
      final currentStage = _mapProgressToStage(progress);
      final missingItems = <String>[];
      if (currentStage < 2) missingItems.add('HTML structure definition');
      if (currentStage < 3) missingItems.add('Real visual elements (cards/buttons)');
      if (currentStage < 4) missingItems.add('Modular state components wired');
      if (currentStage < 5) missingItems.add('State controller business logic');
      if (currentStage < 6) missingItems.add('API endpoint connection client');
      if (currentStage < 7) missingItems.add('Local DB save/read transaction flows');
      if (currentStage < 8) missingItems.add('Input field form validation');
      if (currentStage < 9) missingItems.add('User interaction callbacks wired');
      if (currentStage < 10) missingItems.add('QA verification spec coverage');
      if (currentStage < 11) missingItems.add('Production release certification');

      list.add(ScreenHealthStatus(
        screenName: (row['screen_name'] ?? '') as String,
        routePath: routePath,
        componentFile: (row['actual_file_path'] ?? (row['file_path'] ?? '')) as String,
        currentStage: currentStage,
        progressPercent: progress,
        isPlaceholder: isPlaceholder,
        hasRealUi: currentStage >= 3,
        hasButtons: currentStage >= 3,
        hasForms: currentStage >= 3,
        hasTables: currentStage >= 3,
        hasApiCalls: currentStage >= 6,
        hasDbConnection: currentStage >= 7,
        hasValidation: currentStage >= 8,
        hasErrorHandling: currentStage >= 6,
        hasLoadingState: currentStage >= 5,
        hasEmptyState: currentStage >= 4,
        isProductionReady: currentStage >= 11,
        missingItems: missingItems,
        nextAction: (row['next_action'] ?? '') as String,
        lastCheckedAt: (row['last_verified_at'] ?? DateTime.now().toIso8601String()) as String,
        diagnosisEnabled: ((row['diagnosis_enabled'] ?? 0) as int) == 1,
        diagnosisReplyStatus: (row['diagnosis_reply_status'] ?? 'NOT_TESTED') as String,
        diagnosisLastQuestion: row['diagnosis_last_question'] as String?,
        diagnosisLastAnswer: row['diagnosis_last_answer'] as String?,
        diagnosisLastCheckedAt: row['diagnosis_last_checked_at'] as String?,
        diagnosisError: row['diagnosis_error'] as String?,
        buttonCount: (row['button_count'] ?? 0) as int,
        formFieldCount: (row['form_field_count'] ?? 0) as int,
        linkCount: (row['link_count'] ?? 0) as int,
        tableActionCount: (row['table_action_count'] ?? 0) as int,
        filterCount: (row['filter_count'] ?? 0) as int,
        navigationActionCount: (row['navigation_action_count'] ?? 0) as int,
        totalInteractiveObjects: (row['total_interactive_objects'] ?? 0) as int,
        screenPurpose: row['screen_purpose'] as String?,
        primaryUserGoal: row['primary_user_goal'] as String?,
        expectedUserActions: row['expected_user_actions'] as String?,
        businessReason: row['business_reason'] as String?,
        screenPurposeStatus: (row['screen_purpose_status'] ?? 'NO_USER_VALUE') as String,
        needsReview: ((row['needs_review'] ?? 0) as int) == 1,
        productionReady: ((row['production_ready'] ?? 0) as int) == 1,
        falseProgress: ((row['false_progress'] ?? 0) as int) == 1,
        roleKey: row['role_key'] as String?,
        roleName: row['role_name'] as String?,
        roleCategory: row['role_category'] as String?,
        roleScreenOrder: (row['role_screen_order'] ?? 0) as int,
        roleCompletionPercent: (row['role_completion_percent'] ?? 0) as int,
        roleDocPath: row['role_doc_path'] as String?,
        visualStatus: row['visual_status'] as String?,
        screenBodyButtonCount: (row['screen_body_button_count'] ?? 0) as int,
        screenBodyFormCount: (row['screen_body_form_count'] ?? 0) as int,
        screenBodyFilterCount: (row['screen_body_filter_count'] ?? 0) as int,
        screenBodyTableActionCount: (row['screen_body_table_action_count'] ?? 0) as int,
        screenBodyClickableCardCount: (row['screen_body_clickable_card_count'] ?? 0) as int,
        screenBodyTotalInteractions: (row['screen_body_total_interactions'] ?? 0) as int,
        globalNavigationCount: (row['global_navigation_count'] ?? 0) as int,
        meaningfulInteractionStatus: (row['meaningful_interaction_status'] ?? 'ZERO_SCREEN_BODY_INTERACTION') as String,
        businessWorkflowScore: (row['business_workflow_score'] ?? 0) as int,
        roleExpectationScore: (row['role_expectation_score'] ?? 0) as int,
        missingBusinessFeatures: row['missing_business_features'] as String?,
        businessReady: ((row['business_ready'] ?? 0) as int) == 1,
        hardFail: ((row['hard_fail'] ?? 0) as int) == 1,
        screenshotPath: row['screenshot_path'] as String?,
        renderSuccess: ((row['render_success'] ?? 0) as int) == 1,
        renderError: row['render_error'] as String?,
        visualQualityScore: (row['visual_quality_score'] ?? 0) as int,
      ));
    }
    db.dispose();
    return list;
  } catch (_) {
    return screenHealthRegistry.values.toList();
  }
}

void setDiagnosisEnabled(String routePath, bool enabled) {
  final dbPath = r"C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\.agents\\governance\\governance.db";
  if (!File(dbPath).existsSync()) return;
  try {
    final db = sqlite3.open(dbPath);
    db.execute('UPDATE screens SET diagnosis_enabled = ? WHERE route_path = ?', [enabled ? 1 : 0, routePath]);
    db.dispose();
  } catch (_) {}
}

ScreenHealthStatus testSingleScreenReply(String routePath) {
  final dbPath = r"C:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\.agents\\governance\\governance.db";
  String answer = '';
  String status = 'NOT_TESTED';
  String errorMsg = '';
  try {
    final health = getScreenHealth(routePath);
    if (health.componentFile == 'Unknown') {
      status = 'ERROR';
      errorMsg = 'Screen not registered in registry';
    } else {
      answer = askScreen(routePath, "Are you OK?");
      if (answer.contains("Status:")) {
        status = 'REPLIED_OK';
      } else if (answer.isEmpty) {
        status = 'NO_REPLY';
      } else {
        status = 'PARTIAL_REPLY';
      }
    }
  } catch (e) {
    status = 'ERROR';
    errorMsg = e.toString();
  }

  if (File(dbPath).existsSync()) {
    try {
      final db = sqlite3.open(dbPath);
      final screenRows = db.select('SELECT id FROM screens WHERE route_path = ?', [routePath]);
      int? screenId;
      if (screenRows.isNotEmpty) {
        screenId = screenRows.first['id'] as int;
      }
      final nowStr = DateTime.now().toIso8601String();
      db.execute('''
        UPDATE screens SET 
          diagnosis_reply_status = ?,
          diagnosis_last_question = ?,
          diagnosis_last_answer = ?,
          diagnosis_last_checked_at = ?,
          diagnosis_error = ?
        WHERE route_path = ?
      ''', [status, "Are you OK?", answer, nowStr, errorMsg, routePath]);

      if (screenId != null) {
        db.execute('''
          INSERT INTO screen_diagnosis_tests (screen_id, route_path, question, answer, reply_status, tested_at, error_message)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', [screenId, routePath, "Are you OK?", answer, status, nowStr, errorMsg]);
      }
      db.dispose();
    } catch (_) {}
  }
  final all = loadAllScreensFromDb();
  return all.firstWhere((s) => s.routePath == routePath, orElse: () => getScreenHealth(routePath));
}

List<ScreenHealthStatus> testAllScreenReplies() {
  final all = loadAllScreensFromDb();
  for (final s in all) {
    if (s.diagnosisEnabled) {
      testSingleScreenReply(s.routePath);
    }
  }
  return loadAllScreensFromDb();
}

int _mapProgressToStage(int progress) {
  if (progress >= 100) return 11;
  if (progress >= 95) return 10;
  if (progress >= 90) return 9;
  if (progress >= 80) return 8;
  if (progress >= 70) return 7;
  if (progress >= 60) return 6;
  if (progress >= 50) return 5;
  if (progress >= 40) return 4;
  if (progress >= 30) return 3;
  if (progress >= 20) return 2;
  if (progress >= 10) return 1;
  return 0;
}
