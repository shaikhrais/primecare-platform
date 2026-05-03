import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;

import '../../core/governance/ticket_registry.dart';
import '../../core/governance/correction_ticket.dart';
import '../../core/governance/screen_registry.dart';

class CorrectionTicketForm extends StatefulWidget {
  final String? initialScreenId;
  const CorrectionTicketForm({super.key, this.initialScreenId});

  @override
  State<CorrectionTicketForm> createState() => _CorrectionTicketFormState();
}

class _CorrectionTicketFormState extends State<CorrectionTicketForm> {
  final _descriptionController = TextEditingController();
  String _selectedSeverity = 'minor';
  String _selectedScreen = 'DASHBOARD';

  @override
  void initState() {
    super.initState();
    if (widget.initialScreenId != null) {
      _selectedScreen = widget.initialScreenId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: 'Submit Correction Ticket',
      icon: Icons.confirmation_number_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Report architectural drifts or UI discrepancies for correction.'),
          const SizedBox(height: 24),
          
          DropdownButtonFormField<String>(
            initialValue: _selectedScreen,
            decoration: InputDecoration(
              labelText: 'Target Screen',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ScreenRegistry.screens.keys
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selectedScreen = val!),
          ),
          
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            initialValue: _selectedSeverity,
            decoration: InputDecoration(
              labelText: 'Severity Level',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ['critical', 'major', 'minor', 'suggestion']
                .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
                .toList(),
            onChanged: (val) => setState(() => _selectedSeverity = val!),
          ),
          
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Correction Details',
              hintText: 'Describe what needs to be fixed...',
              filled: true,
              fillColor: theme.colors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () {
              final ticket = CorrectionTicket(
                id: 'TICKET-${DateTime.now().millisecondsSinceEpoch}',
                screenId: _selectedScreen,
                reportedBy: 'User (Session)',
                description: _descriptionController.text,
                severity: _selectedSeverity,
                status: 'open',
                createdAt: DateTime.now().toIso8601String(),
              );
              TicketRegistry.addTicket(ticket);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Correction Ticket ${ticket.id} Submitted'),
                  backgroundColor: theme.colors.primary,
                ),
              );
              _descriptionController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Submit Ticket', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
