// Host retains the existing configured public text service URL.
import 'package:http/http.dart' as http;
import 'package:primecare_localization/src/localization/live_screen_text.dart';
import '../network/api_client.dart' show ApiConfig;
export 'package:primecare_localization/src/localization/live_screen_text.dart' show liveScreenText;

class LiveScreenTextStore extends LiveScreenTextStoreBase {
  LiveScreenTextStore({http.Client? client, String? baseUrl})
      : super(client: client, baseUrl: baseUrl ?? ApiConfig.baseUrl);
}

class LiveScreenTextScope extends LiveScreenTextScopeBase<LiveScreenTextStore> {
  const LiveScreenTextScope({super.key,required super.child,super.store});
  @override LiveScreenTextStore createStore() => LiveScreenTextStore();
}
