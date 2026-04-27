import 'package:primecare_ui/primecare_ui.dart';
import 'administrative_forms_controller.dart';
import 'administrative_forms_model.dart';

class AdministrativeFormsView extends ConsumerStatefulWidget {
  const AdministrativeFormsView({super.key});

  @override
  ConsumerState<AdministrativeFormsView> createState() => _AdministrativeFormsViewState();
}

class _AdministrativeFormsViewState extends ConsumerState<AdministrativeFormsView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(administrativeFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Administrative Approval Center', style: theme.typography.h3),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Expenses'),
              Tab(text: 'Leave Requests'),
              Tab(text: 'Payroll Runs'),
            ],
            onTap: (index) {
              ref.read(administrativeFormsControllerProvider.notifier).selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildApprovalList(theme, 'Expense Reimbursements', ['EXP-2024-001', 'EXP-2024-002']),
            _buildApprovalList(theme, 'Leave Request Approvals', ['LR-2024-045', 'LR-2024-046']),
            _buildApprovalList(theme, 'Payroll Run Authorizations', ['PAY-APR-2024', 'PAY-MAY-2024']),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalList(PrimeCareThemeData theme, String title, List<String> items) {
    return ListView.builder(
      padding: EdgeInsets.all(theme.spacing.lg),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return PrimeCareCard(
          margin: EdgeInsets.only(bottom: theme.spacing.md),
          padding: EdgeInsets.all(theme.spacing.md),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(items[index], style: theme.typography.h4),
                  Text('Pending Review', style: theme.typography.labelSmall),
                ],
              ),
              const Spacer(),
              PrimeCareButton.secondary(
                onPressed: () {},
                label: 'View Details',
              ),
              SizedBox(width: theme.spacing.sm),
              PrimeCareButton(
                onPressed: () => ref.read(administrativeFormsControllerProvider.notifier).approveForm(items[index]),
                label: 'Approve',
              ),
            ],
          ),
        );
      },
    );
  }
}

class AdministrativeFormsIntent extends PrimeCareScreen {
  AdministrativeFormsIntent() : super(title: "AdministrativeForms");

  @override
  Widget build(BuildContext context) => const AdministrativeFormsView();
}


