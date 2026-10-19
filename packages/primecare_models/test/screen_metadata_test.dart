import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('API metadata and navigation use shared contracts without Flutter', () {
    const metadata = BaseScreenMetadata<String>(
      id: 'existing-screen', title: 'Existing', icon: 'existing-icon',
      route: '/existing', isAuditCompliant: true,
    );
    const navigation = BaseNavigationItem<String>(
      label: 'Existing', icon: 'existing-icon', route: '/existing',
    );
    final BaseEntity<String> entity = metadata;
    expect(entity.id, 'existing-screen');
    expect(metadata.canImplement, isTrue);
    expect(metadata.icon, navigation.icon);
    expect(metadata.copyWith(title: 'Updated').title, 'Updated');
    expect(metadata.toJson().containsKey('icon'), isFalse);
    expect(metadata.toJson().containsKey('designSize'), isFalse);
    expect(BaseScreenMetadata<String>.fromJson(metadata.toJson()).icon, isNull);
  });
  test('metadata keeps alias precedence and readiness defaults', () {
    const metadata = BaseScreenMetadata<String>(
      id: 'existing-screen', title: 'Existing',
      route: '/original', routePath: '/alias',
      roles: ['original'], allowedRoles: ['alias'],
      lifecycleStatus: LifecycleStatus.legacy, isAuditCompliant: true,
    );
    expect(metadata.route, '/alias');
    expect(metadata.role, 'alias');
    expect(metadata.canImplement, isFalse);
    expect(metadata.isReadyForProduction, isFalse);
    expect(metadata.completionPercent, 0);
    expect(metadata.copyWith(icon: null).icon, isNull);
  });
}
