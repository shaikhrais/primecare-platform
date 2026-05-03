import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../providers/proposal_provider.dart';
import '../models/proposal_intake.dart';
import '../services/proposal_collector_service.dart';

class ProposalInboxView extends ConsumerWidget {
  const ProposalInboxView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposals = ref.watch(proposalListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposal Inbox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task),
            onPressed: () => context.push('/proposals/new'),
            tooltip: 'New Proposal',
          ),
        ],
      ),
      body: proposals.when(
        data: (list) => list.isEmpty
            ? _buildEmptyState(context)
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final proposal = list[index];
                  return _buildProposalCard(context, proposal);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error loading proposals: $err'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(proposalListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'No proposals received',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Stakeholder intake requests will appear here.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {}, // TODO: Push to new
            icon: const Icon(Icons.add),
            label: const Text('Create First Proposal'),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalCard(BuildContext context, ProposalIntake proposal) {
    final readiness = ProposalCollectorService.calculateReadiness(proposal);
    final statusColor = _getStatusColor(proposal.status);

    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/proposals/detail/${proposal.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBadge(proposal.priority.toUpperCase(), _getPriorityColor(proposal.priority)),
                  _buildBadge(proposal.status.replaceAll('_', ' ').toUpperCase(), statusColor),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                proposal.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                proposal.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(proposal.requestedBy, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Spacer(),
                  const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${proposal.createdAt.day}/${proposal.createdAt.month}/${proposal.createdAt.year}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Readiness Score: ${(readiness * 100).toInt()}%',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: readiness,
                          backgroundColor: Colors.grey.withValues(alpha: 0.1),
                          color: readiness > 0.8 ? Colors.green : (readiness > 0.5 ? Colors.orange : Colors.red),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/proposals/detail/${proposal.id}'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Review', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'p0': return Colors.red;
      case 'p1': return Colors.orange;
      case 'p2': return Colors.blue;
      case 'p3': return Colors.grey;
      default: return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'proposal_received': return Colors.blue;
      case 'in_review': return Colors.purple;
      case 'approved': return Colors.green;
      case 'production': return Colors.teal;
      case 'rejected': return Colors.red;
      default: return Colors.grey;
    }
  }
}
