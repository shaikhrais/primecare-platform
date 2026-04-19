import 'package:primecare_ui/src/theme/colors.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_core/flutter_core.dart';
import '../../layouts/responsive_grid_layout.dart';
import '../base_form.dart';

// --- State Model ---
class VitalsData {
  final String heartRate;
  final String bloodPressure;
  final String temperature;

  VitalsData({
    this.heartRate = '',
    this.bloodPressure = '',
    this.temperature = '',
  });

  VitalsData copyWith({
    String? heartRate,
    String? bloodPressure,
    String? temperature,
  }) {
    return VitalsData(
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      temperature: temperature ?? this.temperature,
    );
  }
}

// --- Notifier / ViewModel ---
class VitalsCaptureNotifier extends AsyncNotifier<VitalsData> {
  @override
  FutureOr<VitalsData> build() {
    return VitalsData();
  }

  void updateData({
    String? heartRate,
    String? bloodPressure,
    String? temperature,
  }) {
    final current = state.value ?? VitalsData();
    state = AsyncData(
      current.copyWith(
        heartRate: heartRate,
        bloodPressure: bloodPressure,
        temperature: temperature,
      ),
    );
  }

  void reset() {
    state = AsyncData(VitalsData());
  }

  Future<void> submit({required String patientId}) async {
    if (patientId.isEmpty) {
      state = AsyncError('No patient selected for vitals capture.', StackTrace.current);
      return;
    }
    final currentData = state.value;
    if (currentData == null) return;

    // 1. Connectivity Check Resilience
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = AsyncError(
        'Device is currently offline. Please check your connection.',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    // 2. Network Telemetry wrapper
    final result = await Result.guardFuture<bool>(
      () async {
        // Robust Regex-based BP Parsing (Supports 120/80, 120-80, etc.)
        final bpRegex = RegExp(r'^(\d+)\s*[/-]\s*(\d+)$');
        final match = bpRegex.firstMatch(currentData.bloodPressure.trim());
        
        final systolic = match?.group(1);
        final diastolic = match?.group(2);

        await ref.read(apiClientProvider).post(
          '/v1/clinical/vitals-capture',
          body: {
            'patientId': patientId,
            'heartRate': currentData.heartRate,
            'systolic': systolic,
            'diastolic': diastolic,
            'temperature': currentData.temperature,
          },
        );

        ref
            .read(executionGateProvider)
            .passGate(
              ExecutionGateCategory.domainApi,
              'Vitals captured successfully',
            );
        return true;
      },
      onError: (e, st) {
        ref
            .read(executionGateProvider)
            .failGate(
              ExecutionGateCategory.domainApi,
              'Vitals capture failed',
              error: e,
              stackTrace: st,
            );
        return false; // Safe fallback
      },
    );

    // 3. Fold operation (No named arguments!)
    result.fold(
      (success) {
        if (success) {
          state = AsyncData(VitalsData()); // Reset on success
        } else {
          state = AsyncError('Failed to capture vitals.', StackTrace.current);
        }
      },
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
      },
    );
  }
}

final vitalsCaptureProvider =
    AsyncNotifierProvider<VitalsCaptureNotifier, VitalsData>(
      () => VitalsCaptureNotifier(),
    );

// --- UI Component ---
class VitalsCaptureForm extends ConsumerStatefulWidget {
  final String? patientId;
  final VoidCallback? onSuccess;

  const VitalsCaptureForm({super.key, this.patientId, this.onSuccess});

  @override
  ConsumerState<VitalsCaptureForm> createState() => _VitalsCaptureFormState();
}

class _VitalsCaptureFormState extends ConsumerState<VitalsCaptureForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (widget.patientId == null || widget.patientId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a patient first')),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final notifier = ref.read(vitalsCaptureProvider.notifier);
      notifier.submit(patientId: widget.patientId!).then((_) {
        if (mounted && ref.read(vitalsCaptureProvider).hasValue) {
          widget.onSuccess?.call();
        }
      });
    }
  }

  void _clear() {
    ref.read(vitalsCaptureProvider.notifier).reset();
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(vitalsCaptureProvider);
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Dynamic span allocation based on current grid threshold
    final int thirdSpan = (layout.totalColumns / 3).ceil();
    final int fullSpan = layout.totalColumns;
    final int itemSpan = layout.tier == ResolutionTier.mob
        ? fullSpan
        : thirdSpan;

    return BaseForm(
      formKey: _formKey,
      title: 'Capture Vitals',
      subtitle: 'Record the patient\'s current vitals.',
      onSubmit: _submit,
      submitText: 'Save Vitals',
      isLoading: asyncState.isLoading,
      isEnabled: widget.patientId != null && widget.patientId!.isNotEmpty,
      children: [
        if (widget.patientId == null || widget.patientId!.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24 * layout.scaleFactor),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16 * layout.scaleFactor),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Icon(Icons.person_search, size: 48 * layout.scaleFactor, color: theme.colorScheme.primary.withOpacity(0.5)),
                SizedBox(height: 16 * layout.scaleFactor),
                Text(
                  'No Patient Context',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8 * layout.scaleFactor),
                const Text(
                  'Please select a patient from the clinical list to begin vitals capture.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        if (asyncState.hasError)
          Padding(
            padding: EdgeInsets.only(bottom: 16.0 * layout.scaleFactor),
            child: Text(
              asyncState.error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),

        // Form layout mapped directly against PrimeCare's Adaptive Grid V2
        ResponsiveGridRow(
          spacing: 16 * layout.scaleFactor,
          runSpacing: 16 * layout.scaleFactor,
          children: [
            ResponsiveGridCol(
              span: itemSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Heart Rate (bpm)',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.favorite,
                    color: PrimeCareColors.rose,
                  ),
                ),
                keyboardType: TextInputType.number,
                initialValue: asyncState.value?.heartRate,
                onChanged: (val) => ref
                    .read(vitalsCaptureProvider.notifier)
                    .updateData(heartRate: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: itemSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Blood Pressure',
                  hintText: '120/80',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.monitor_heart,
                    color: PrimeCareColors.skyBlue,
                  ),
                ),
                initialValue: asyncState.value?.bloodPressure,
                onChanged: (val) => ref
                    .read(vitalsCaptureProvider.notifier)
                    .updateData(bloodPressure: val),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  final bpRegex = RegExp(r'^\d+\s*[/-]\s*\d+$');
                  if (!bpRegex.hasMatch(value.trim())) return 'Use Systolic/Diastolic format';
                  return null;
                },
              ),
            ),
            ResponsiveGridCol(
              span: itemSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Temperature (°C)',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.thermostat,
                    color: PrimeCareColors.amber,
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                initialValue: asyncState.value?.temperature,
                onChanged: (val) => ref
                    .read(vitalsCaptureProvider.notifier)
                    .updateData(temperature: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: Row(
                children: [
                  const Spacer(),
                  TextButton.icon(
                    onPressed: asyncState.isLoading ? null : _clear,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear Form'),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
