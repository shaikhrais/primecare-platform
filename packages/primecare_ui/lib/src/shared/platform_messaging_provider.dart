// Governance - Category: controller | Purpose: Represents a single chat message inside the platform.
import 'dart:async';
import 'package:flutter_core/flutter_core.dart';

/// Represents a single chat message inside the platform.
class PlatformMessage {
  final String id;
  final String sender;
  final String senderRole;
  final String content;
  final DateTime timestamp;
  final bool isBot;

  const PlatformMessage({
    required this.id,
    required this.sender,
    required this.senderRole,
    required this.content,
    required this.timestamp,
    this.isBot = false,
  });

  PlatformMessage copyWith({
    String? id,
    String? sender,
    String? senderRole,
    String? content,
    DateTime? timestamp,
    bool? isBot,
  }) {
    return PlatformMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      senderRole: senderRole ?? this.senderRole,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isBot: isBot ?? this.isBot,
    );
  }
}

/// Represents a conversation thread in the platform messaging hub.
class PlatformThread {
  final String id;
  final String title;
  final int unreadCount;
  final String roleContext;
  final List<PlatformMessage> messages;

  const PlatformThread({
    required this.id,
    required this.title,
    this.unreadCount = 0,
    required this.roleContext,
    required this.messages,
  });

  PlatformThread copyWith({
    String? id,
    String? title,
    int? unreadCount,
    String? roleContext,
    List<PlatformMessage>? messages,
  }) {
    return PlatformThread(
      id: id ?? this.id,
      title: title ?? this.title,
      unreadCount: unreadCount ?? this.unreadCount,
      roleContext: roleContext ?? this.roleContext,
      messages: messages ?? this.messages,
    );
  }
}

/// Centralized state for the omnipresent messaging console and system telemetry.
class PlatformMessagingState {
  final String activeThreadId;
  final List<PlatformThread> threads;
  final List<String> telemetryLogs;
  final String activeSimulatedRole;
  final bool isTyping;

  const PlatformMessagingState({
    required this.activeThreadId,
    required this.threads,
    required this.telemetryLogs,
    required this.activeSimulatedRole,
    this.isTyping = false,
  });

  PlatformMessagingState copyWith({
    String? activeThreadId,
    List<PlatformThread>? threads,
    List<String>? telemetryLogs,
    String? activeSimulatedRole,
    bool? isTyping,
  }) {
    return PlatformMessagingState(
      activeThreadId: activeThreadId ?? this.activeThreadId,
      threads: threads ?? this.threads,
      telemetryLogs: telemetryLogs ?? this.telemetryLogs,
      activeSimulatedRole: activeSimulatedRole ?? this.activeSimulatedRole,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  PlatformThread get activeThread {
    return threads.firstWhere(
      (t) => t.id == activeThreadId,
      orElse: () => threads.first,
    );
  }
}

/// Standardized domain-aware simulated ChatGPT reply engine.
class ChatGPTBotSimulator {
  static Future<String> generateReply(String text, String activeRole) async {
    // Artificial slight delay is added in notifier to simulate realistic typing
    final cleanText = text.toLowerCase();

    if (cleanText.contains('emergency') ||
        cleanText.contains('dizzy') ||
        cleanText.contains('injured') ||
        cleanText.contains('hurt') ||
        cleanText.contains('accident')) {
      return "⚠️ [ChatGPT CLINICAL SAFETY AUTO-REPLY] \n"
          "Context detected: Clinical Triage/Safety Query.\n"
          "Recommendation: Patient safety is our highest priority. For urgent symptoms like severe dizziness, chest pain, or trauma, redirect immediately to local emergency care (call 911). \n"
          "Protocol: Registered Nurse has been flagged in the tele-triage dashboard to follow up within 15 minutes.";
    }

    if (cleanText.contains('schedule') ||
        cleanText.contains('shift') ||
        cleanText.contains('calendar') ||
        cleanText.contains('clash')) {
      return "📅 [ChatGPT OPERATIONS AUTO-REPLY] \n"
          "Context detected: Staff Scheduling & Roster.\n"
          "Audit check: Operations Manager role has active staffing conflicts in Regional Area 4.\n"
          "Solution: Nurse Sarah Jenkins (Senior care worker, 98% match compatibility) is available to backfill the open 14:00 - 22:00 shift. Request sent for her approval.";
    }

    if (cleanText.contains('audit') ||
        cleanText.contains('compliance') ||
        cleanText.contains('drift') ||
        cleanText.contains('patch')) {
      return "🛡️ [ChatGPT COMPLIANCE AUTO-REPLY] \n"
          "Context detected: Platform Security & Integrity.\n"
          "Status: Real-time scan detected standard alignment warning on active dynamic layouts.\n"
          "Remediation: Click 'Run Autopatch Audit' in the Nexus console tabs to deploy AST hotfixes and quarantine layout drifts.";
    }

    if (cleanText.contains('kpi') ||
        cleanText.contains('revenue') ||
        cleanText.contains('performance') ||
        cleanText.contains('growth')) {
      return "📊 [ChatGPT EXECUTIVE INSIGHT AUTO-REPLY] \n"
          "Context detected: Business Development KPI.\n"
          "Executive Summary: Eastern Region care hours expanded 12.4% last month. Customer retention score is 99.4% with zero churn.\n"
          "Recommendation: Maintain target expansion budgets in secondary markets.";
    }

    // Context-sensitive replies based on simulated user roles
    switch (activeRole.toLowerCase()) {
      case 'compliance officer':
      case 'compliance':
        return "🛡️ [ChatGPT COMPLIANCE RESPONSE] \n"
            "Active Context: Governance & Security Audit.\n"
            "Uptime is steady at 99.99%. We cleared all 34 compiler diagnostics to absolute zero. Audit logs are logged correctly. Ask me to perform an AST screen telemetry scan.";
      case 'scheduler':
      case 'operations manager':
        return "📅 [ChatGPT OPERATIONS RESPONSE] \n"
            "Active Context: Shift Scheduling.\n"
            "I have mapped open shifts to nearby available staff. Tap scheduling health telemetry logs to inspect matching criteria.";
      case 'executive':
      case 'ceo':
      case 'cfo':
        return "📊 [ChatGPT EXECUTIVE RESPONSE] \n"
            "Active Context: Corporate Operations Strategy.\n"
            "Cash flow remains extremely solid. Roster optimization has compressed scheduling overhead by 7.2%. KPI analytics are prepared for download.";
      default:
        return "🤖 [ChatGPT ASSISTANT RESPONSE] \n"
            "Greetings! I am the PrimeCare omnipresent ChatGPT bot. I am watching this active view's widget structure in real-time. Ask me about scheduling matches, safety compliance, or telemetry drifts!";
    }
  }
}

/// Centralized Riverpod provider managing platform-wide messages, logs, and simulated ChatGPT chats.
final platformMessagingProvider =
    NotifierProvider<PlatformMessagingNotifier, PlatformMessagingState>(() {
  return PlatformMessagingNotifier();
});

class PlatformMessagingNotifier extends Notifier<PlatformMessagingState> {
  @override
  PlatformMessagingState build() {
    // Generate initial threads and simulated system telemetry logs
    final initialThreads = [
      PlatformThread(
        id: 't_chatgpt',
        title: '🤖 ResponseBot AI Assistant (ChatGPT)',
        roleContext: 'General Help',
        messages: [
          PlatformMessage(
            id: 'm_init_bot',
            sender: 'ResponseBot',
            senderRole: 'AI Agent',
            content: 'Hello! I am PrimeCare ChatGPT ResponseBot. Ask me about safety protocols, staff schedule clashes, or compliance telemetry.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
            isBot: true,
          ),
        ],
      ),
      PlatformThread(
        id: 't_alerts',
        title: '⚠️ Platform Alerts (Compliance & Telemetry)',
        roleContext: 'Compliance',
        messages: [
          PlatformMessage(
            id: 'm_init_alert',
            sender: 'Security Monitor',
            senderRole: 'Integrity Agent',
            content: 'SYSTEM NOTICE: Local geofencing checks successfully activated on apps/primecare_governance.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
          ),
        ],
      ),
      PlatformThread(
        id: 't_ops',
        title: '📅 Operations Hub (Shift Scheduling)',
        roleContext: 'Operations',
        messages: [
          PlatformMessage(
            id: 'm_init_ops',
            sender: 'Operations Bot',
            senderRole: 'Coordinator Agent',
            content: 'Roster Update: 14 open nursing shifts successfully matched to regional care specialists.',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
      ),
    ];

    final initialLogs = [
      '[${DateTime.now().subtract(const Duration(seconds: 45)).toString().substring(11, 19)}] API: GET /v1/governance/telemetry - 200 OK (12ms)',
      '[${DateTime.now().subtract(const Duration(seconds: 30)).toString().substring(11, 19)}] JWT: User session validated for active role',
      '[${DateTime.now().subtract(const Duration(seconds: 15)).toString().substring(11, 19)}] GEOFENCE: Geofence center verified on cell D4',
      '[${DateTime.now().toString().substring(11, 19)}] HUB: PlatformMessagingService successfully booted',
    ];

    return PlatformMessagingState(
      activeThreadId: 't_chatgpt',
      threads: initialThreads,
      telemetryLogs: initialLogs,
      activeSimulatedRole: 'General Specialist',
    );
  }

  /// Change active conversation thread
  void selectThread(String threadId) {
    state = state.copyWith(activeThreadId: threadId);
    
    // Clear unread counts for selected thread
    state = state.copyWith(
      threads: state.threads.map((t) {
        if (t.id == threadId) {
          return t.copyWith(unreadCount: 0);
        }
        return t;
      }).toList(),
    );
  }

  /// Change active simulated role
  void selectSimulatedRole(String role) {
    state = state.copyWith(activeSimulatedRole: role);
    
    // Append simulated telemetry logs
    addTelemetryLog('System configured: active simulated role switched to $role');
  }

  /// Send message in the active thread
  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    final userMessage = PlatformMessage(
      id: 'm_user_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'You',
      senderRole: state.activeSimulatedRole,
      content: content,
      timestamp: DateTime.now(),
    );

    // Append message to active thread
    final updatedThreads = state.threads.map((thread) {
      if (thread.id == state.activeThreadId) {
        return thread.copyWith(
          messages: [...thread.messages, userMessage],
        );
      }
      return thread;
    }).toList();

    state = state.copyWith(threads: updatedThreads);
    addTelemetryLog('API: POST /v1/messaging/send - 200 OK (21ms)');

    // Trigger ChatGPT Auto-Reply if messaging the AI Assistant
    if (state.activeThreadId == 't_chatgpt') {
      _triggerChatGPTReply(content);
    }
  }

  /// Add simulated logs to the system telemetry feed
  void addTelemetryLog(String log) {
    final timeStr = DateTime.now().toString().substring(11, 19);
    final logLine = '[$timeStr] $log';
    state = state.copyWith(
      telemetryLogs: [logLine, ...state.telemetryLogs.take(50)],
    );
  }

  /// Run simulated screen autopatch
  Future<void> runAutopatchAudit(String screenId) async {
    addTelemetryLog('AST SCAN: Beginning code-drift verification for $screenId...');
    await Future<void>.delayed(const Duration(milliseconds: 800));
    addTelemetryLog('AST ANALYZER: Found 1 visual padding mismatch.');
    await Future<void>.delayed(const Duration(milliseconds: 800));
    addTelemetryLog('REMEDIATION: Applying absolute alignment modifier...');
    await Future<void>.delayed(const Duration(milliseconds: 600));
    addTelemetryLog('SUCCESS: Code-drift successfully patched! Score: 100% integrity.');
    
    // Insert system alert to alert thread
    final autoPatchAlert = PlatformMessage(
      id: 'm_alert_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'Integrity Shield',
      senderRole: 'Compliance System',
      content: '🛡️ SECURITY INTEGRITY SECURED: Telemetry patch applied to $screenId. Drifts resolved.',
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      threads: state.threads.map((t) {
        if (t.id == 't_alerts') {
          return t.copyWith(
            messages: [...t.messages, autoPatchAlert],
            unreadCount: t.id != state.activeThreadId ? t.unreadCount + 1 : 0,
          );
        }
        return t;
      }).toList(),
    );
  }

  /// Private helper to trigger context-aware ChatGPT replies with typing simulator
  void _triggerChatGPTReply(String userText) async {
    state = state.copyWith(isTyping: true);

    // Dynamic delay to simulate a real LLM typing response
    await Future<void>.delayed(const Duration(seconds: 1));

    final botReplyText = await ChatGPTBotSimulator.generateReply(
      userText,
      state.activeSimulatedRole,
    );

    final botMessage = PlatformMessage(
      id: 'm_bot_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'ResponseBot',
      senderRole: 'ChatGPT AI',
      content: botReplyText,
      timestamp: DateTime.now(),
      isBot: true,
    );

    state = state.copyWith(
      isTyping: false,
      threads: state.threads.map((thread) {
        if (thread.id == 't_chatgpt') {
          return thread.copyWith(
            messages: [...thread.messages, botMessage],
          );
        }
        return thread;
      }).toList(),
    );

    addTelemetryLog('ChatGPT ResponseBot successfully generated auto-reply');
  }
}
