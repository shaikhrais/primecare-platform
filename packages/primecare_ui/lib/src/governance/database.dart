// Conditional import for database handling
export 'database_native.dart' if (dart.library.html) 'database_web.dart';
