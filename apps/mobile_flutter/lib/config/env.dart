/// Legacy structural fallback to prevent Wasm compiler linkage crashes
/// inside un-refactored literal URL parser screens.
class Env {
  // Gracefully routes literal Uri.parse actions natively back to the Cloudflare proxy domain.
  static const String apiBaseUrl = 'https://primecare-api.mohammed-42e.workers.dev';
}
