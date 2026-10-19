import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

class ApiTenant extends BasePlatformTenant<Map<String, String>> {
  @override String get tenantId => 'existing-tenant';
  @override String get name => 'Existing';
  @override Map<String, String> get branding => const {'name': 'Existing'};
}
class ApiModule extends BasePlatformModule<String, PlatformRole, String> {
  @override String get moduleId => 'existing-module';
  @override String get name => 'Existing';
  @override String get icon => 'existing-icon';
  @override List<PlatformRole> get allowedRoles => [PlatformRole.client];
  @override List<String> get screens => ['/existing'];
}
class ApiRoleDefinition extends BasePlatformRoleDefinition<PlatformRole, ApiModule> {
  ApiRoleDefinition(List<ApiModule> modules) : super(role: PlatformRole.client,
    label: 'Existing', modules: modules, dashboardRoute: '/existing');
}
class ApiApplication extends BasePlatformApplication<ApiTenant, ApiRoleDefinition> {
  @override String get appId => 'existing-app';
  @override String get name => 'Existing';
  @override final ApiTenant tenant = ApiTenant();
  @override final List<ApiRoleDefinition> roleDefinitions;
  ApiApplication(this.roleDefinitions);
}

void main() {
  test('platform contracts support an API consumer without Flutter types', () {
    final modules = <ApiModule>[ApiModule()];
    final definition = ApiRoleDefinition(modules);
    final definitions = [definition];
    final application = ApiApplication(definitions);
    expect(application.tenant.tenantId, 'existing-tenant');
    expect(application.tenant.branding['name'], 'Existing');
    expect(application.roleDefinitions, same(definitions));
    expect(definition.modules, same(modules));
    expect(definition.modules.first.allowedRoles, [PlatformRole.client]);
    expect(definition.modules.first.screens, ['/existing']);
    modules.add(ApiModule());
    expect(definition.modules.length, 2);
  });
  test('canonical role aliases and unknown-role fallback remain unchanged', () {
    expect(PlatformRole.fromName(' SUPER_ADMIN '), PlatformRole.admin);
    expect(PlatformRole.fromName('owner'), PlatformRole.franchiseOwner);
    expect(PlatformRole.fromName('"client"'), PlatformRole.client);
    expect(PlatformRole.fromName('unrecognized-role'), PlatformRole.guest);
    expect(PlatformRole.fromRoute('/clinical/missing'), PlatformRole.clinical);
    expect(PrimeCareLabel.dashboard.get('en'), 'Dashboard');
    expect(PrimeCareLabel.dashboard.get('unknown'), 'dashboard');
  });
}
