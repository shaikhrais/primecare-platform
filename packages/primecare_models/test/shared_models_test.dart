import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';

class ExampleState extends BaseScreenState<ExampleState> {
  const ExampleState({super.isLoading, super.errorMessage, super.data});
  @override
  ExampleState rebuild({required bool isLoading, required String? errorMessage,
    required Map<String, dynamic> data}) => ExampleState(
      isLoading: isLoading, errorMessage: errorMessage, data: data);
}

void main() {
  test('inherited copy preserves legacy null semantics and subtype', () {
    const state = ExampleState(errorMessage: 'existing', data: {'id': '1'});
    final ExampleState next = state.copyWith(isLoading: true);
    expect(next.isLoading, isTrue);
    expect(next.errorMessage, 'existing');
    expect(next.data, same(state.data));
    expect(next.copyWith(errorMessage: null).errorMessage, 'existing');
    expect(state.isLoading, isFalse);
  });
  test('provider parser preserves nullable bio and rejects extra fields', () {
    final payload = <String, dynamic>{'id':'1', 'full_name':'Provider',
      'bio':null, 'languages':'English', 'service_areas':'Hamilton',
      'provider_type':'RMT', 'is_approved':true, 'skills':'Massage'};
    expect(ProviderProfile.fromResponse({'profile':payload}).role, ProviderRole.rmt);
    expect(ProviderProfile.fromJson(payload).bio, '');
    expect(() => ProviderProfile.fromJson({...payload, 'passwordHash':'secret'}),
      throwsFormatException);
  });
  test('response wire envelope remains identical', () {
    expect(DomainResponse(data: {'id':'1'}).toJson(), {
      'data': {'id':'1'}, 'success': true, 'message': null, 'error': null,
    });
    expect(DomainResponse.error('failed').success, isFalse);
  });
}
