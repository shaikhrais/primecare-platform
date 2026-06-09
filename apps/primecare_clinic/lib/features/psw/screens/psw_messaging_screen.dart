// Governance - Category: view | Purpose: UI Screen component rendering the Psw Messaging workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswMessagingState {
  final List<Map<String, String>> messages;
  final String currentText;

  const PswMessagingState({
    required this.messages,
    required this.currentText,
  });

  PswMessagingState copyWith({
    List<Map<String, String>>? messages,
    String? currentText,
  }) {
    return PswMessagingState(
      messages: messages ?? this.messages,
      currentText: currentText ?? this.currentText,
    );
  }
}

// --- Controller ---
class PswMessagingController extends StateNotifier<PswMessagingState> {
  final Ref _ref;
  PswMessagingController(this._ref)
      : super(const PswMessagingState(
          currentText: '',
          messages: [
            {'sender': 'Supervisor (RN)', 'msg': "Hi Jane, remember to complete Arthur's vitals check-in before 11:00.", 'time': '10:15'},
            {'sender': 'Me', 'msg': 'Thanks for the heads-up. Working on it now.', 'time': '10:17'},
          ],
        ));

  void updateText(String val) {
    state = state.copyWith(currentText: val);
  }

  void sendMessage() {
    if (state.currentText.isEmpty) return;
    
    final updated = [
      ...state.messages,
      {'sender': 'Me', 'msg': state.currentText, 'time': '10:30'},
    ];
    state = state.copyWith(messages: updated, currentText: '');
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/messaging',
        eventType: 'sendMessage',
        metadata: {'length': state.currentText.length},
      );
    } catch (_) {}
  }

  void refreshMessages() {}
}

final pswMessagingControllerProvider = StateNotifierProvider<PswMessagingController, PswMessagingState>((ref) {
  return PswMessagingController(ref);
});

// --- View ---
class PswMessagingScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Psw Messaging screen requires components for messaging interaction, user activity tracking, and error handling, along with necessary APIs for data operations.';

  @override
  List<String> get requiredComponents => const [
        'MessagingWorkspace',
        'NotificationPanel',
        'UserActivityTracker',
        'ErrorLogViewer',
      ];

  @override
  List<String> get requiredFunctions => const [
        'sendMessage',
        'fetchMessages',
        'trackUserActivity',
        'logError',
      ];

  const PswMessagingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswMessagingControllerProvider);
    final controller = ref.read(pswMessagingControllerProvider.notifier);
    
    final textInputController = TextEditingController(text: state.currentText);

    return Semantics(
      label: 'data-cy:psw-messaging-btn-send',
      container: true,
      child: Scaffold(
        key: const Key('psw-messaging-btn-send'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Care Coordinator Chat',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('psw-messaging-btn-refresh'),
              icon: const Icon(LucideIcons.refreshCw),
              onPressed: () => controller.refreshMessages(),
            ),
          ],
        ),
        body: Semantics(
          label: 'data-cy:pswmessaging-content',
          container: true,
          child: Column(
            children: [
              // Chat List Section
              Expanded(
                child: ListView.builder(
                  key: const Key('pswmessaging-list'),
                  padding: const EdgeInsets.all(24.0),
                  itemCount: state.messages.length,
                  itemBuilder: (context, idx) {
                    final m = state.messages[idx];
                    final isMe = m['sender'] == 'Me';
                    return Container(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? theme.colors.primary : theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m['sender'] ?? '',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: isMe ? Colors.white70 : theme.colors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              m['msg'] ?? '',
                              style: TextStyle(
                                color: isMe ? Colors.white : theme.colors.onSurface,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Chat Input Bar
              Container(
                padding: const EdgeInsets.all(16),
                color: theme.colors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textInputController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: InputBorder.none,
                        ),
                        onChanged: (val) => controller.updateText(val),
                      ),
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.send, color: theme.colors.primary),
                      onPressed: () => controller.sendMessage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
