// Stub implementation for web builds (no SQLite).
import 'screen_self_diagnosis.dart'; // type definitions

List<ScreenHealthStatus> loadAllScreensFromDb() => screenHealthRegistry.values.toList();

void setDiagnosisEnabled(String routePath, bool enabled) {
  // No‑op on web
}

ScreenHealthStatus testSingleScreenReply(String routePath) => getScreenHealth(routePath);

List<ScreenHealthStatus> testAllScreenReplies() => screenHealthRegistry.values.toList();
