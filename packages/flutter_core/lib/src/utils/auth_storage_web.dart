import 'package:web/web.dart' as web;

String? getLocalStorageItem(String key) {
  try {
    return web.window.localStorage.getItem(key);
  } catch (_) {
    return null;
  }
}
