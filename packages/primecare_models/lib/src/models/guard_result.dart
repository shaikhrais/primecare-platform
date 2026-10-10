/// Represents the decision of the RouteGuard for a given navigation event.
class GuardResult {
  final bool isAllowed;
  final String? redirectRoute;

  GuardResult(this.isAllowed, {this.redirectRoute});
}
