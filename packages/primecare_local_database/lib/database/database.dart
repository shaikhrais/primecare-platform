// Wrapper to select appropriate DB implementation based on platform
export 'native_database_impl.dart' if (dart.library.html) 'web_database.dart';
