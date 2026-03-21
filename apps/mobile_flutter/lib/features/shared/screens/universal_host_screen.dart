import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../core/api_client.dart';

final sduiPayloadProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, endpoint) async {
  final response = await apiClient.get(endpoint);
  return response as Map<String, dynamic>;
});

class UniversalHostScreen extends ConsumerWidget {
  final String endpoint;

  const UniversalHostScreen({super.key, required this.endpoint});

  void _handleSduiAction(BuildContext context, String action, Map<String, dynamic>? payload) {
    if (action.startsWith('navigate:')) {
      final route = action.replaceFirst('navigate:', '');
      context.push(route, extra: payload);
    } else if (action == 'pop') {
      if (context.canPop()) context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: PrimeCareText('Unknown SDUI Action: $action')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSchema = ref.watch(sduiPayloadProvider(endpoint));

    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF1F5F9), // Enterprise Standard Slate
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: asyncSchema.when(
            data: (schema) {
              return PrimeCareScrollWrapper(
                child: PrimeCareSduiEngine(
                  schema: schema,
                  onAction: (action, payload) => _handleSduiAction(context, action, payload),
                ),
              );
            },
            loading: () => PrimeCareCenter(child: CircularProgressIndicator()),
            error: (err, stack) => PrimeCareCenter(
              child: PrimeCareCard(
                child: PrimeCareColumn(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimeCareIcon(Icons.error_outline, color: Colors.red, size: 48),
                    PrimeCareSizedBox(height: 16),
                    PrimeCareText('SDUI Sync Failure', style: Theme.of(context).textTheme.titleMedium),
                    PrimeCareText(err.toString(), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
