import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_manager_controller.dart';

class ComplianceManagerView extends ConsumerWidget {
  const ComplianceManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(complianceManagerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Compliance & Risk Oversight', style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareCard(
                child: ListTile(
                  title: Text('Global Compliance Score', style: theme.typography.h4),
                  trailing: Text('${(state.complianceScore * 100).toInt()}%', style: theme.typography.h2.copyWith(color: Colors.green)),
                ),
              ),
              SizedBox(height: theme.spacing.xl),
              Text('Pending Audits', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.pendingAudits.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.assignment_turned_in),
                        title: Text(state.pendingAudits[index]),
                        trailing: PrimeCareButton(onPressed: () {}, label: 'Start Audit'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplianceManagerIntent extends PrimeCareScreen {
  ComplianceManagerIntent() : super(title: "ComplianceManager");

  @override
  Widget build(BuildContext context) => const ComplianceManagerView();
}


