import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_owner_controller.dart';

class FranchiseOwnerView extends ConsumerWidget {
  const FranchiseOwnerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseOwnerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Franchise Operations: ${state.region}', style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Monthly Revenue'),
                        subtitle: Text('\$${state.monthlyRevenue.toInt()}', style: theme.typography.h2),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Active Staff'),
                        subtitle: Text('${state.activeStaff}', style: theme.typography.h2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.xl),
              PrimeCareButton(onPressed: () {}, label: 'Generate Regional Report'),
            ],
          ),
        ),
      ),
    );
  }
}

class FranchiseOwnerIntent extends PrimeCareScreen {
  FranchiseOwnerIntent() : super(title: 'Franchise Owner Dashboard');

  @override
  Widget build(BuildContext context) => const FranchiseOwnerView();
}


