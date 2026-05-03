import 'package:primecare_ui/primecare_ui.dart';
import '../models/proposal_intake.dart';
import '../providers/proposal_provider.dart';
import '../services/proposal_collector_service.dart';
import '../services/flow_runner_service.dart';

class ProposalDetailView extends ConsumerStatefulWidget {
  final String proposalId;

  const ProposalDetailView({super.key, required this.proposalId});

  @override
  ConsumerState<ProposalDetailView> createState() => _ProposalDetailViewState();
}

class _ProposalDetailViewState extends ConsumerState<ProposalDetailView> {
  @override
  Widget build(BuildContext context) {
    final proposalsAsync = ref.watch(proposalListProvider);
    
    return proposalsAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (proposals) {
        final proposal = proposals.firstWhere((p) => p.id == widget.proposalId, orElse: () => throw Exception('Proposal not found'));

        return Scaffold(
          appBar: AppBar(
            title: const Text('Proposal Review'),
            actions: [
              if (proposal.status != 'production')
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                     ref.read(proposalListProvider.notifier).deleteProposal(proposal.id);
                     Navigator.pop(context);
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusHeader(proposal),
                const SizedBox(height: 24),
                
                _buildGridSection([
                  _buildInfoTile('Business Goal', proposal.businessGoal, Icons.flag_rounded),
                  _buildInfoTile('Requested By', proposal.requestedBy, Icons.person_rounded),
                  _buildInfoTile('Priority', proposal.priority.toUpperCase(), Icons.priority_high_rounded),
                  _buildInfoTile('Technical Route', proposal.routePath, Icons.route_rounded),
                ]),
                
                const SizedBox(height: 24),
                _buildComplianceCard(proposal),
                
                const SizedBox(height: 24),
                _buildPanel('Registry Duplicate Check', _buildDuplicateCheckPanel(proposal)),
                
                const SizedBox(height: 16),
                _buildPanel('API & Component Mapping', _buildApiMappingPanel(proposal)),
                
                const SizedBox(height: 16),
                _buildPanel('Automated Test Plan', _buildTestPlanPanel(proposal)),
                
                const SizedBox(height: 32),
                _buildApprovalSection(proposal),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget _buildStatusHeader(ProposalIntake proposal) {
    final readiness = ProposalCollectorService.calculateReadiness(proposal);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                proposal.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'ID: ${proposal.id} | Created: ${proposal.createdAt.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        _buildReadinessIndicator(readiness),
      ],
    );
  }

  Widget _buildReadinessIndicator(double value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(
            '${(value * 100).toInt()}%',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: value > 0.8 ? Colors.green : (value > 0.5 ? Colors.orange : Colors.red),
            ),
          ),
          const Text('READY', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildGridSection(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: children.map((child) => SizedBox(
            width: (constraints.maxWidth - 16) / 2,
            child: child,
          )).toList(),
        );
      },
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return PrimeCareCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCard(ProposalIntake proposal) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Compliance & Data Safety', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),

          _buildComplianceItem('PHI Data Handling', proposal.needsPhiData, Icons.health_and_safety),
          _buildComplianceItem('User Consent Required', proposal.needsConsent, Icons.verified_user),
          _buildComplianceItem('Digital Signature', proposal.needsSignature, Icons.draw),
          _buildComplianceItem('Audit Logging', proposal.needsAuditLog, Icons.history),
        ],
      ),
    );
  }

  Widget _buildComplianceItem(String label, bool active, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: active ? Colors.green : Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: active ? Colors.black : Colors.grey, fontSize: 13)),
          const Spacer(),
          Icon(
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: active ? Colors.green : Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel(String title, Widget content) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );

  }

  Widget _buildDuplicateCheckPanel(ProposalIntake proposal) {
    // Mock check against registry
    final isDuplicateRoute = proposal.routePath == '/clinical/psw/checkin'; // Mock match
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isDuplicateRoute ? Icons.warning_amber_rounded : Icons.verified_rounded,
              color: isDuplicateRoute ? Colors.orange : Colors.green,
            ),
            const SizedBox(width: 8),
            Text(
              isDuplicateRoute ? 'Potential Conflict Detected' : 'No Structural Duplicates Found',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: isDuplicateRoute ? Colors.orange : Colors.green,
              ),
            ),
          ],
        ),
        if (isDuplicateRoute)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'A screen with this route path already exists in the Clinical Registry. Please verify if this is an update or a new feature.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildApiMappingPanel(ProposalIntake proposal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Required Infrastructure:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: proposal.requiredApis.map((api) => Chip(
            label: Text(api, style: const TextStyle(fontSize: 10)),
            backgroundColor: Colors.blue.withValues(alpha: 0.05),
          )).toList(),
        ),
        const SizedBox(height: 8),
        const Text('UI Component Dependencies:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: proposal.requiredComponents.map((comp) => Chip(
            label: Text(comp, style: const TextStyle(fontSize: 10)),
            backgroundColor: Colors.purple.withValues(alpha: 0.05),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildTestPlanPanel(ProposalIntake proposal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Automated Validation Suite:', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        ...proposal.testScenarios.map((test) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              const Icon(Icons.science_rounded, size: 14, color: Colors.indigo),
              const SizedBox(width: 8),
              Expanded(child: Text(test, style: const TextStyle(fontSize: 12))),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildApprovalSection(ProposalIntake proposal) {
    final isApproved = proposal.status == 'approved' || proposal.status == 'production';
    final canGoToProduction = ProposalCollectorService.isReadyForProduction(proposal);

    return Column(
      children: [
        if (!isApproved)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _updateStatus(proposal.id, 'rejected'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade50, foregroundColor: Colors.red),
                  child: const Text('Reject Proposal'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _updateStatus(proposal.id, 'approved'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Approve for Production'),
                ),
              ),
            ],
          ),
        if (isApproved && proposal.status != 'production')
          Column(
            children: [
              const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text('STAKEHOLDER APPROVAL GRANTED', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: canGoToProduction ? () => _sendToProduction(proposal) : null,
                icon: const Icon(Icons.rocket_launch_rounded),
                label: const Text('SEND TO PRODUCTION (START FLOW RUNNER)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
              if (!canGoToProduction)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '⚠ Validation failures must be resolved before deployment.',
                    style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        if (proposal.status == 'production')
          const Center(
            child: Column(
              children: [
                Icon(Icons.auto_awesome, color: Colors.amber, size: 48),
                SizedBox(height: 8),
                Text('PROPOSAL DEPLOYED TO PRODUCTION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber)),
                Text('Managed by Autonomous Flow Runner', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
      ],
    );
  }

  void _updateStatus(String id, String status) {
    ref.read(proposalListProvider.notifier).updateStatus(id, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Proposal $status')),
    );
  }

  void _sendToProduction(ProposalIntake proposal) async {
    final flowRunner = ref.read(flowRunnerServiceProvider);
    
    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🚀 Flow Runner Initiated'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Automating registry patching and artifact generation...'),
            const SizedBox(height: 16),
            _buildFlowStep('Analyzing Governance Proposal...'),
            _buildFlowStep('Injecting AST Patch to Registry...'),
            _buildFlowStep('Synchronizing Blueprint Seeder...'),
          ],
        ),
      ),
    );

    // Execute real deployment
    final success = await flowRunner.deployProposal(proposal);
    
    if (mounted) {
      Navigator.pop(context); // Close progress dialog
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Feature successfully deployed to production registry.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Flow Runner failed. Check AST integrity.')),
        );
      }
    }
  }

  Widget _buildFlowStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 12, 
            height: 12, 
            child: CircularProgressIndicator(strokeWidth: 2)
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
