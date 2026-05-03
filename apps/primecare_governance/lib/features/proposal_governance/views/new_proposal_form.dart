import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../models/proposal_intake.dart';
import '../providers/proposal_provider.dart';
import '../providers/intake_module_provider.dart';
import '../services/compliance_checklist_service.dart';

class NewProposalForm extends ConsumerStatefulWidget {
  const NewProposalForm({super.key});

  @override
  ConsumerState<NewProposalForm> createState() => _NewProposalFormState();
}

class _NewProposalFormState extends ConsumerState<NewProposalForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requestedByController = TextEditingController();
  final _departmentController = TextEditingController();
  final _businessGoalController = TextEditingController();
  final _problemStatementController = TextEditingController();
  final _expectedOutcomeController = TextEditingController();
  final _screenIdController = TextEditingController();
  final _routePathController = TextEditingController();
  final _designUrlController = TextEditingController();

  String _priority = 'p2';
  final String _office = 'Corporate';
  final String _role = 'Admin';
  String _designSource = 'text';
  bool _needsPhiData = false;
  bool _needsConsent = false;
  bool _needsSignature = false;
  bool _needsAuditLog = true;

  final List<String> _allowedRoles = [];
  final List<String> _requiredApis = [];
  final List<String> _requiredComponents = [];
  final List<String> _acceptanceCriteria = [];
  final List<String> _testScenarios = [];

  @override
  Widget build(BuildContext context) {
    // Listen for intake updates to auto-fill or update controllers
    ref.listen(intakeModuleProvider, (previous, next) {
      if (next.proposal != null) {
        final p = next.proposal!;
        
        // Initial auto-fill from prompt
        if (next.stage == IntakeStage.business && previous?.stage == IntakeStage.initial) {
          _titleController.text = p.title;
          _descriptionController.text = p.description;
          _businessGoalController.text = p.businessGoal;
          _requestedByController.text = p.requestedBy;
          _departmentController.text = p.department;
          _screenIdController.text = p.screenId;
          _routePathController.text = p.routePath;
          setState(() {
            _priority = p.priority;
            _needsPhiData = p.needsPhiData;
            _needsAuditLog = p.needsAuditLog;
            _allowedRoles.clear();
            _allowedRoles.addAll(p.allowedRoles);
            _requiredApis.clear();
            _requiredApis.addAll(p.requiredApis);
          });
        }
        
        // Update controllers after registry enrichment (technical stage)
        if (next.stage == IntakeStage.collection && previous?.stage == IntakeStage.technical) {
          _screenIdController.text = p.screenId;
          _routePathController.text = p.routePath;
        }

        // Update controllers after data collection
        if (next.stage == IntakeStage.compliance && previous?.stage == IntakeStage.collection) {
          setState(() {
            _allowedRoles.clear();
            _allowedRoles.addAll(p.allowedRoles);
            _requiredApis.clear();
            _requiredApis.addAll(p.requiredApis);
            _designSource = p.designSource;
            _designUrlController.text = p.designUrl;
          });
        }

        // Handle compliance stage feedback
        if (next.stage == IntakeStage.review && previous?.stage == IntakeStage.compliance) {
          setState(() {
            _needsAuditLog = p.needsAuditLog;
            _needsPhiData = p.needsPhiData;
            _needsConsent = p.needsConsent;
            _needsSignature = p.needsSignature;
          });
        }
      }
    });

    final intakeState = ref.watch(intakeModuleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Intake: New Feature Proposal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSmartIntakeSection(intakeState),
            const SizedBox(height: 24),
            _buildSectionHeader('Basic Information', Icons.info_outline),
            PrimeCareTextField(
              controller: _titleController,
              label: 'Proposal Title',
              hintText: 'e.g. Real-time Patient Vitals Tracking',
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              controller: _descriptionController,
              label: 'Description',
              maxLines: 3,
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PrimeCareTextField(
                    controller: _requestedByController,
                    label: 'Requested By',
                    validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _priority,
                    decoration: const InputDecoration(labelText: 'Priority'),
                    items: ['p0', 'p1', 'p2', 'p3'].map((p) => DropdownMenuItem(value: p, child: Text(p.toUpperCase()))).toList(),
                    onChanged: (val) => setState(() => _priority = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Business Context', Icons.business_center_outlined),
            PrimeCareTextField(
              controller: _businessGoalController,
              label: 'Business Goal',
              hintText: 'What are we trying to achieve?',
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              controller: _problemStatementController,
              label: 'Problem Statement',
              hintText: 'What is broken or missing today?',
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Technical Specifications', Icons.code_rounded),
            Row(
              children: [
                Expanded(
                  child: PrimeCareTextField(
                    controller: _screenIdController,
                    label: 'Proposed Screen ID',
                    hintText: 'screen_patient_vitals',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimeCareTextField(
                    controller: _routePathController,
                    label: 'Proposed Route',
                    hintText: '/clinical/patient/vitals',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMultiSelect('Allowed Roles', ['Admin', 'PSW', 'RN', 'Clinical Director'], _allowedRoles),
            const SizedBox(height: 16),
            _buildMultiSelect('Required APIs', ['Patient API', 'Vitals API', 'Auth API', 'Shift API'], _requiredApis),
            const SizedBox(height: 24),

            _buildSectionHeader('Compliance & Risk', Icons.gavel_rounded),
            SwitchListTile(
              title: const Text('Handles PHI Data?'),
              subtitle: const Text('Personal Health Information protection requirements.'),
              value: _needsPhiData,
              onChanged: (v) => setState(() => _needsPhiData = v),
            ),
            SwitchListTile(
              title: const Text('Requires Audit Logging?'),
              value: _needsAuditLog,
              onChanged: (v) => setState(() => _needsAuditLog = v),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Quality Assurance', Icons.fact_check_outlined),
            _buildListAdder('Acceptance Criteria', _acceptanceCriteria),
            const SizedBox(height: 16),
            _buildListAdder('Test Scenarios', _testScenarios),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit Governance Proposal'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const Expanded(child: Divider(indent: 16)),
        ],
      ),
    );
  }

  Widget _buildMultiSelect(String label, List<String> options, List<String> selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    selected.add(opt);
                  } else {
                    selected.remove(opt);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSmartIntakeSection(IntakeState state) {
    final promptController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology_outlined, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'AI SMART INTAKE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  letterSpacing: 1.1,
                ),
              ),
              const Spacer(),
              if (state.isProcessing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Paste a raw request or idea here. We will auto-extract business goals, technical needs, and compliance risks.',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimeCareTextField(
                  label: 'Prompt',
                  controller: promptController,
                  hintText: 'e.g. CEO wants a revenue dashboard for regional billing admins...',
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: state.isProcessing ? null : () async {
                  if (promptController.text.isNotEmpty) {
                    await ref.read(intakeModuleProvider.notifier).processPrompt(promptController.text);
                    await ref.read(intakeModuleProvider.notifier).enrichFromRegistries();
                    await ref.read(intakeModuleProvider.notifier).runDataCollectionModule();
                    ref.read(intakeModuleProvider.notifier).runComplianceScan();
                  }
                },
                icon: const Icon(Icons.auto_awesome),
                tooltip: 'Process with AI',
              ),
            ],
          ),
          if (state.logs.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.logs.reversed.take(3).map((log) {
                  final isWarning = log.contains('[Registry Warning]');
                  final isIntel = log.contains('[Registry Intel]');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          isWarning ? Icons.warning_amber_rounded : (isIntel ? Icons.lightbulb_outline : Icons.chevron_right),
                          size: 14,
                          color: isWarning ? Colors.orange : (isIntel ? Colors.blue : Colors.grey),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            log,
                            style: TextStyle(
                              fontSize: 10, 
                              fontFamily: 'monospace',
                              color: isWarning ? Colors.orange.shade800 : (isIntel ? Colors.blue.shade800 : null),
                              fontWeight: (isWarning || isIntel) ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          if (state.complianceResult != null) ...[
            const SizedBox(height: 16),
            _buildComplianceResults(state.complianceResult!),
          ],
          if (state.stage != IntakeStage.initial && state.proposal != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => ref.read(intakeModuleProvider.notifier).prepareStitchGeneration(),
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text('Prepare Stitch Blueprint'),
                  ),
                ),
                if (state.stitchPrompt != null) ...[
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Stitch Engine Blueprint'),
                          content: SingleChildScrollView(child: Text(state.stitchPrompt!)),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                // This would trigger the actual MCP call in an agentic workflow
                                ref.read(intakeModuleProvider.notifier).notifyStitchComplete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Stitch Engine Request Sent')),
                                );
                              },
                              child: const Text('Deploy to Stitch'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(state.isStitchComplete ? Icons.check_circle : Icons.visibility),
                    color: state.isStitchComplete ? Colors.green : null,
                  ),
                ],
              ],
            ),
          ],
          if (state.isStitchComplete && !state.isDeployed) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: state.isProcessing ? null : () async {
                  final success = await ref.read(intakeModuleProvider.notifier).deployToPlatform();
                  if (success && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Deployment successful! Screen injected into Registry.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.rocket_launch),
                label: Text(state.isProcessing ? 'Deploying...' : 'Deploy to Production'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
          if (state.isDeployed) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'DEPLOYMENT SUCCESSFUL',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref.read(intakeModuleProvider.notifier).reset();
                        context.pop();
                      },
                      icon: const Icon(Icons.dashboard_customize_outlined),
                      label: const Text('View in Governance HUD'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildComplianceResults(ComplianceCheckResult result) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: result.passed ? Colors.green.withValues(alpha: 0.05) : Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: result.passed ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                result.passed ? Icons.verified_user_outlined : Icons.gavel_rounded,
                size: 16,
                color: result.passed ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                result.passed ? 'COMPLIANCE PASSED' : 'COMPLIANCE WARNING',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: result.passed ? Colors.green.shade800 : Colors.red.shade800,
                ),
              ),
              const Spacer(),
              Text(
                'Risk Score: ${(result.riskScore * 100).toInt()}%',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (result.violations.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...result.violations.map((v) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 12, color: Colors.red),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      v,
                      style: const TextStyle(fontSize: 11, color: Colors.red),
                    ),
                  ),
                ],
              ),
            )),
          ],
          if (result.suggestions.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...result.suggestions.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, size: 12, color: Colors.orange),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      s,
                      style: const TextStyle(fontSize: 11, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildListAdder(String label, List<String> items) {
    final controller = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(child: Text(item)),
              IconButton(icon: const Icon(Icons.remove_circle_outline, size: 16), onPressed: () => setState(() => items.remove(item))),
            ],
          ),
        )),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Add $label...'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() => items.add(controller.text));
                  controller.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final proposal = ProposalIntake(
        id: const Uuid().v4(),

        title: _titleController.text,
        description: _descriptionController.text,
        requestedBy: _requestedByController.text,
        department: _departmentController.text,
        office: _office,
        role: _role,
        priority: _priority,
        businessGoal: _businessGoalController.text,
        problemStatement: _problemStatementController.text,
        expectedOutcome: _expectedOutcomeController.text,
        screenId: _screenIdController.text,
        routePath: _routePathController.text,
        allowedRoles: _allowedRoles,
        requiredApis: _requiredApis,
        requiredComponents: _requiredComponents,
        requiredForms: [],
        designSource: _designSource,
        designUrl: _designUrlController.text,
        mockDataNotes: '',
        needsPhiData: _needsPhiData,
        needsConsent: _needsConsent,
        needsSignature: _needsSignature,
        needsAuditLog: _needsAuditLog,
        acceptanceCriteria: _acceptanceCriteria,
        testScenarios: _testScenarios,
        createdAt: DateTime.now(),
      );

      ref.read(proposalListProvider.notifier).addProposal(proposal);
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proposal Submitted Successfully')),
      );
    }
  }
}
