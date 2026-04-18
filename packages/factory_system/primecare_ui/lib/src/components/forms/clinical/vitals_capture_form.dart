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

  Future<void> submit() async {
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
        // Mock API Client call
        await Future.delayed(
          const Duration(milliseconds: 800),
        ); // Simulate network

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
  final VoidCallback? onSuccess;

  const VitalsCaptureForm({super.key, this.onSuccess});

  @override
  ConsumerState<VitalsCaptureForm> createState() => _VitalsCaptureFormState();
}

class _VitalsCaptureFormState extends ConsumerState<VitalsCaptureForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final notifier = ref.read(vitalsCaptureProvider.notifier);
    notifier.submit().then((_) {
      if (ref.read(vitalsCaptureProvider).hasValue) {
        widget.onSuccess?.call();
      }
    });
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
      children: [
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
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
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
          ],
        ),
      ],
    );
  }
}
