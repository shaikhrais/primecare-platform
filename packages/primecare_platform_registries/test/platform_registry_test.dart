import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_platform_registries/primecare_platform_registries.dart';
import 'package:primecare_models/primecare_models.dart';
void main() { test('existing screen and role metadata remain canonical', () { final screen=PlatformScreenRegistry.getById('SCREEN_HEALTH');expect(screen,isNotNull);expect(screen!.route,'/admin/screen-health');final role=RoleRegistry.getMetadata(PlatformRole.volunteer);expect(role?.defaultDashboardId,'VOLUNTEER_DASHBOARD');expect(RoleRegistry.getRolesByCategory('Clinical'),isNotEmpty); }); }
