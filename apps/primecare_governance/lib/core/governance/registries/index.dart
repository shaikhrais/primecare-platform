export 'admin_infrastructure_registry.dart';
export 'business_development_registry.dart';
export 'client_portal_registry.dart';
export 'clinical_registry.dart';
export 'corporate_registry.dart';
export 'franchise_registry.dart';
export 'marketing_registry.dart';
export 'operational_registry.dart';
export 'support_registry.dart';
export 'workflows_forms_registry.dart';

import '../screen_metadata.dart';
import 'admin_infrastructure_registry.dart';
import 'business_development_registry.dart';
import 'client_portal_registry.dart';
import 'clinical_registry.dart';
import 'corporate_registry.dart';
import 'franchise_registry.dart';
import 'marketing_registry.dart';
import 'operational_registry.dart';
import 'support_registry.dart';
import 'workflows_forms_registry.dart';

class Registry {
  static Map<String, ScreenMetadata> get screens {
    return {
      ...AdminInfrastructureRegistryRegistry.screens,
      ...BusinessDevelopmentRegistryRegistry.screens,
      ...ClientPortalRegistryRegistry.screens,
      ...ClinicalRegistryRegistry.screens,
      ...CorporateRegistryRegistry.screens,
      ...FranchiseRegistryRegistry.screens,
      ...MarketingRegistryRegistry.screens,
      ...OperationalRegistryRegistry.screens,
      ...SupportRegistryRegistry.screens,
      ...WorkflowsFormsRegistryRegistry.screens,
    };
  }
}
