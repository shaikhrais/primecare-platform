import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/component_catalogue/prime_component_catalogue.dart' as view0;
import 'package:primecare_runtime/routes/auth_callback_view.dart' as view1;
import 'package:primecare_runtime/routes/clinic_login_bridge.dart' as view2;
import 'package:primecare_runtime/routes/sso_redirect_view.dart' as view3;
import 'package:primecare_runtime/src/resilience/app_error_boundary.dart' as view4;

void main() {
  test('actual shared progress consumers compile', () {
    final types=<Type>[
      view0.CatalogueLabels,
      view1.AuthCallbackView,
      view2.ClinicLoginBridge,
      view3.SsoRedirectView,
      view4.AppErrorBoundary
    ];
    expect(types,hasLength(5));
  });
}
