import 'package:flutter_core/routes/route_guard.dart';

void main() {
  print("Running RouteGuard verification test...");
  final result = RouteGuard.verify(
    requestedRoute: '/offices/clinical/roles/chiropractor/dashboard',
    isLoggedIn: true,
    userRole: 'chiropractor',
  );
  print("Result: isAllowed=${result.isAllowed}, redirectRoute=${result.redirectRoute}, externalRedirectUrl=${result.externalRedirectUrl}");
}
