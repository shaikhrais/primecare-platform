import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class RegionalFinanceRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      RegionalFinanceRoutes.ontFinOverview,
      PrimeCareForm.ontFinOverview,
      provider: ontFinOverviewAdapterProvider,
      componentLabels: [
        'Aura HUD (Ontario Finance)',
        'Regional Revenue Matrix',
        'Branch Liquidity Index',
        'Tax Remittance Status',
      ],
      structuralPlan:
          'Ontario Finance Overview: Regional macro-view of revenue and liquidity across all Ontario branches.',
    );

    registerRoute(
      RegionalFinanceRoutes.ontFinApprovals,
      PrimeCareForm.ontFinApprovals,
      provider: ontFinApprovalsAdapterProvider,
      componentLabels: [
        'Aura HUD (Approval Velocity)',
        'Pending Expenditure Queue',
        'Vendor Payment Authorization',
        'Audit Trail Monitor',
      ],
      structuralPlan:
          'Financial Approvals: Command center for regional expenditure and vendor payment authorizations.',
    );

    registerRoute(
      RegionalFinanceRoutes.ontFinRoadmap,
      PrimeCareForm.ontFinRoadmap,
      provider: ontFinRoadmapAdapterProvider,
      componentLabels: [
        'Aura HUD (Fiscal Strategy)',
        'Expansion Capital Roadmap',
        'Budget Projection Model',
        'Strategic Investment Log',
      ],
      structuralPlan:
          'Finance Roadmap: Strategic planning for capital expansion and budget projections in the Ontario region.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'ont_fin_overview': {
      'path': RegionalFinanceRoutes.ontFinOverview,
      'title': 'regional.ontario.finance.overview.title',
      'form': PrimeCareForm.ontFinOverview.name,
    },
    'ont_fin_approvals': {
      'path': RegionalFinanceRoutes.ontFinApprovals,
      'title': 'regional.ontario.finance.approvals.title',
      'form': PrimeCareForm.ontFinApprovals.name,
    },
    'ont_fin_roadmap': {
      'path': RegionalFinanceRoutes.ontFinRoadmap,
      'title': 'regional.ontario.finance.roadmap.title',
      'form': PrimeCareForm.ontFinRoadmap.name,
    },
  };
}
