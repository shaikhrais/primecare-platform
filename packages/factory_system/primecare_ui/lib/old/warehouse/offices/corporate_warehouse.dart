// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart'
    hide HeadOfMarketingDashboardScreen, OperationsManagerDashboardScreen;
import 'package:primecare_ui/src/features/operations_manager_dashboard/presentation/widgets/operations_manager_dashboard_screen.dart';

class CorporateComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'ceoDashboardAdapter': (context, payload) =>
        CeodashboardadapterPlaceholder(data: payload),
    'ceoDashboardDto': (context, payload) =>
        CeodashboarddtoPlaceholder(data: payload),
    'ceoDashboardDtoAdapter': (context, payload) =>
        CeodashboarddtoadapterPlaceholder(data: payload),
    'ceoDashboardMapper': (context, payload) =>
        CeodashboardmapperPlaceholder(data: payload),
    'ceoDashboardMapperAdapter': (context, payload) =>
        CeodashboardmapperadapterPlaceholder(data: payload),
    'ceoDashboardProvider': (context, payload) =>
        CeodashboardproviderPlaceholder(data: payload),
    'ceoDashboardScreen': (context, payload) => const CeoDashboardScreen(),
    'ceoDashboardViewModel': (context, payload) => const CeoDashboardScreen(),
    'ceoDashboardViewModelAdapter': (context, payload) =>
        CeodashboardviewmodeladapterPlaceholder(data: payload),

    'cfoDashboardAdapter': (context, payload) =>
        CfodashboardadapterPlaceholder(data: payload),
    'cfoDashboardDto': (context, payload) =>
        CfodashboarddtoPlaceholder(data: payload),
    'cfoDashboardDtoAdapter': (context, payload) =>
        CfodashboarddtoadapterPlaceholder(data: payload),
    'cfoDashboardMapper': (context, payload) =>
        CfodashboardmapperPlaceholder(data: payload),
    'cfoDashboardMapperAdapter': (context, payload) =>
        CfodashboardmapperadapterPlaceholder(data: payload),
    'cfoDashboardProvider': (context, payload) =>
        CfodashboardproviderPlaceholder(data: payload),
    'cfoDashboardScreen': (context, payload) => const CfoDashboardScreen(),
    'cfoDashboardViewModel': (context, payload) => const CfoDashboardScreen(),
    'cfoDashboardViewModelAdapter': (context, payload) =>
        CfodashboardviewmodeladapterPlaceholder(data: payload),

    'cooDashboardAdapter': (context, payload) =>
        CoodashboardadapterPlaceholder(data: payload),
    'cooDashboardDto': (context, payload) =>
        CoodashboarddtoPlaceholder(data: payload),
    'cooDashboardDtoAdapter': (context, payload) =>
        CoodashboarddtoadapterPlaceholder(data: payload),
    'cooDashboardMapper': (context, payload) =>
        CoodashboardmapperPlaceholder(data: payload),
    'cooDashboardMapperAdapter': (context, payload) =>
        CoodashboardmapperadapterPlaceholder(data: payload),
    'cooDashboardProvider': (context, payload) =>
        CoodashboardproviderPlaceholder(data: payload),
    'cooDashboardScreen': (context, payload) => const CooDashboardScreen(),
    'cooDashboardViewModel': (context, payload) => const CooDashboardScreen(),
    'cooDashboardViewModelAdapter': (context, payload) =>
        CoodashboardviewmodeladapterPlaceholder(data: payload),

    'generalManagerDashboardAdapter': (context, payload) =>
        GeneralmanagerdashboardadapterPlaceholder(data: payload),
    'generalManagerDashboardDto': (context, payload) =>
        GeneralmanagerdashboarddtoPlaceholder(data: payload),
    'generalManagerDashboardDtoAdapter': (context, payload) =>
        GeneralmanagerdashboarddtoadapterPlaceholder(data: payload),
    'generalManagerDashboardMapper': (context, payload) =>
        GeneralmanagerdashboardmapperPlaceholder(data: payload),
    'generalManagerDashboardMapperAdapter': (context, payload) =>
        GeneralmanagerdashboardmapperadapterPlaceholder(data: payload),
    'generalManagerDashboardViewModel': (context, payload) =>
        const GeneralManagerDashboardScreen(),

    'hrManagerDashboardViewModel': (context, payload) =>
        const HrManagerDashboardScreen(),

    'operationsManagerDashboardAdapter': (context, payload) =>
        OperationsmanagerdashboardadapterPlaceholder(data: payload),
    'operationsManagerDashboardDto': (context, payload) =>
        OperationsmanagerdashboarddtoPlaceholder(data: payload),
    'operationsManagerDashboardDtoAdapter': (context, payload) =>
        OperationsmanagerdashboarddtoadapterPlaceholder(data: payload),
    'operationsManagerDashboardMapper': (context, payload) =>
        OperationsmanagerdashboardmapperPlaceholder(data: payload),
    'operationsManagerDashboardViewModel': (context, payload) =>
        const OperationsManagerDashboardScreen(),

    'ownerDashboardAdapter': (context, payload) =>
        OwnerdashboardadapterPlaceholder(data: payload),
    'ownerDashboardDto': (context, payload) =>
        OwnerdashboarddtoPlaceholder(data: payload),
    'ownerDashboardDtoAdapter': (context, payload) =>
        OwnerdashboarddtoadapterPlaceholder(data: payload),
    'ownerDashboardMapper': (context, payload) =>
        OwnerdashboardmapperPlaceholder(data: payload),
    'ownerDashboardMapperAdapter': (context, payload) =>
        OwnerdashboardmapperadapterPlaceholder(data: payload),
    'ownerDashboardViewModel': (context, payload) =>
        const OwnerDashboardScreen(),
    'ownerDashboardViewModelAdapter': (context, payload) =>
        OwnerdashboardviewmodeladapterPlaceholder(data: payload),

    'regionalManagerDashboardAdapter': (context, payload) =>
        RegionalmanagerdashboardadapterPlaceholder(data: payload),
    'regionalManagerDashboardDto': (context, payload) =>
        RegionalmanagerdashboarddtoPlaceholder(data: payload),
    'regionalManagerDashboardMapper': (context, payload) =>
        RegionalmanagerdashboardmapperPlaceholder(data: payload),
    'regionalManagerDashboardViewModel': (context, payload) =>
        const RegionalManagerScreen(),
  };
}
