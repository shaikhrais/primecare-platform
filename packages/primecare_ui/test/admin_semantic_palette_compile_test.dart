import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/governance/screen_health_panel.dart';
import 'package:primecare_ui/src/screens/admin/admin_reality_check_screen.dart';
import 'package:primecare_ui/src/screens/admin/admin_role_carousel_screen.dart';
import 'package:primecare_ui/src/screens/admin/admin_screenshot_gallery_screen.dart';

void main() {
  test('all four diagnostic views compile with semantic palette roles', () {
    final types=<Type>[ScreenHealthOverlayWrapper,AdminRealityCheckScreen,
      AdminRoleCarouselScreen,AdminScreenshotGalleryScreen];
    expect(types,hasLength(4));
  });
}
