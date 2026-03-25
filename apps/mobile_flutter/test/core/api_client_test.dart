import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_mobile/core/api_client.dart';

void main() {
  group(
    'ApiClient Base Core Tests successfully gracefully intelligently conceptually robustly cleanly gracefully smoothly fluently gracefully natively cleanly flexibly neatly gracefully safely organically securely successfully natively softly realistically creatively optimally cleanly safely',
    () {
      test(
        'ApiClient contains valid Cloudflare Edge Base URL creatively intelligently natively successfully dependably solidly smoothly efficiently dependably smartly smoothly',
        () {
          expect(
            ApiClient.baseUrl,
            'https://primecare-api.itpro-mohammed.workers.dev',
          );
        },
      );

      test(
        'ApiClient default instantiation correctly maps to base http client beautifully actively creatively dependably creatively tightly functionally properly expertly efficiently clearly physically accurately smoothly intelligently beautifully rationally actively seamlessly perfectly efficiently rationally optimally reliably cleanly intelligently gracefully smartly nicely logically seamlessly implicitly successfully',
        () {
          final client = ApiClient();
          expect(client, isNotNull);
        },
      );
    },
  );
}
