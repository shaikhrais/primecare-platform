// Centralized export providing conditionally compiled URL strategy functions.
export 'url_strategy_stub.dart'
    if (dart.library.html) 'url_strategy_web.dart';
