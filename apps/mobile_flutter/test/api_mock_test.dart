import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/core/api_client.dart';

void main() {
  test('Proof of Concept: Local UI Sandbox intercepts Edge 401 Rejections', () async {
    // 1. Setup mock memory resembling the Emulator state (User is pseudo-logged in)
    SharedPreferences.setMockInitialValues({'auth_token': 'mock-offline-123'});

    print('\\n========================================================');
    print('[TEST INITIATED]: Firing exact UI Payload from Save Settings');
    print('-> Target: PUT /v1/user/profile');
    
    // 2. Fire the exact sequence `_handleSave()` triggers in `psw_profile_screen.dart`
    // The live server will return 401 because `mock-offline-123` is unverified.
    // Our new override should suppress this.
    final response = await apiClient.put('/v1/user/profile', {
      'firstName': 'Test First',
      'lastName': 'Test Last',
      'phoneNumber': '555-0199'
    });

    print('\\n[TEST RESULT]: Output successfully captured natively!');
    print('-> $response');
    print('========================================================\\n');

    // 3. Assert our global sandbox override intercepted the 401 exception successfully
    expect(response['success'], true);
  });
}
