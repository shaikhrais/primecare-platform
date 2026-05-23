// Governance - Category: controller | Purpose: Controller layer orchestrating business logic and state management for the corresponding module.
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'correction_ticket_model.dart';
import 'package:flutter_core/flutter_core.dart';

part 'correction_ticket_controller.g.dart';

@riverpod
class CorrectionTicketController extends _$CorrectionTicketController {
  @override
  List<CorrectionTicket> build() {
    _listenToSecurityEvents();
    return [];
  }

  void _listenToSecurityEvents() {
    SecuritySentinelService().eventStream.listen((event) {
      if (event.severity == SecurityEventSeverity.critical) {
        _autoGenerateTicket(event);
      }
    });
  }

  void _autoGenerateTicket(SecurityEvent event) {
    final ticket = CorrectionTicket(
      id: 'SEC-${DateTime.now().millisecondsSinceEpoch}',
      title: 'SECURITY VIOLATION: ${event.type}',
      description: event.description,
      severity: TicketSeverity.critical,
      status: TicketStatus.open,
      createdAt: DateTime.now(),
      metadata: event.metadata,
    );

    state = [ticket, ...state];
  }

  void resolveTicket(String id) {
    state = state
        .map((t) => t.id == id ? t.copyWith(status: TicketStatus.resolved) : t)
        .toList();
  }
}
