// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class MarketingManagerView extends ConsumerWidget {
  const MarketingManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(marketingManagerControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marketing Performance Hub', style: theme.typography.h3),
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
                        title: const Text('Active Campaigns'),
                        subtitle: Text(
                          '${state.activeCampaigns}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.md),
                  Expanded(
                    child: PrimeCareCard(
                      child: ListTile(
                        title: const Text('Lead Conversions'),
                        subtitle: Text(
                          '${state.leadConversions}',
                          style: theme.typography.h2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.xl),
              PrimeCareButton(onPressed: () {}, label: 'Launch New Campaign'),
            ],
          ),
        ),
      ),
    );
  }
}

class MarketingManagerIntent extends PrimeCareScreen {
  MarketingManagerIntent() : super(title: 'MarketingManager');

  @override
  Widget build(BuildContext context) => const MarketingManagerView();
}
