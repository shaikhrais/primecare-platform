import 'correction_ticket.dart';

class TicketRegistry {
  static final List<CorrectionTicket> tickets = [
    CorrectionTicket(
      id: 'TICKET-001',
      screenId: 'SCREEN_DASHBOARD',
      reportedBy: 'System Auditor',
      description: 'Misalignment in the health score cards on mobile view.',
      severity: 'minor',
      status: 'open',
      createdAt: '2026-04-29T10:00:00Z',
    ),
    CorrectionTicket(
      id: 'TICKET-002',
      screenId: 'SCREEN_FINANCE_DIRECTOR',
      reportedBy: 'User-122',
      description:
          'Export to CSV functionality is timing out for large datasets.',
      severity: 'major',
      status: 'in_progress',
      createdAt: '2026-04-29T11:30:00Z',
    ),
    CorrectionTicket(
      id: 'TICKET-003',
      screenId: 'SCREEN_GOVERNANCE_SERVICE',
      reportedBy: 'Architectural Audit',
      description:
          'governanceService package is a skeleton with 0 LOC. Needs implementation of backend task runners.',
      severity: 'critical',
      status: 'open',
      createdAt: '2026-04-30T09:40:00Z',
    ),
    CorrectionTicket(
      id: 'TICKET-004',
      screenId: 'SCREEN_COMPLIANCE_API',
      reportedBy: 'Sync Engine',
      description:
          'Compliance API health is warning. Potential memory leak in audit logging middleware.',
      severity: 'major',
      status: 'open',
      createdAt: '2026-04-30T09:42:00Z',
    ),
  ];

  static void addTicket(CorrectionTicket ticket) {
    tickets.add(ticket);
  }

  static List<CorrectionTicket> getByScreen(String screenId) {
    return tickets.where((t) => t.screenId == screenId).toList();
  }

  static List<CorrectionTicket> getOpenTickets() {
    return tickets
        .where((t) => t.status == 'open' || t.status == 'in_progress')
        .toList();
  }

  static int get totalTickets => tickets.length;
  static int get openTickets => getOpenTickets().length;
}
