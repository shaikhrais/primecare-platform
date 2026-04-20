// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument, inference_failure_on_untyped_parameter, inference_failure_on_function_return_type
import 'package:primecare_ui/src/theme/colors.dart';
import 'components/primecare_card.dart';
import 'components/primecare_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'primecare_ui.dart';

/// 1. Universal Async Component Renderer (Industry Standard Smart-mount)
/// Eliminates localized loading grids, spinner logic, and Try/Catch setState logic from UI nodes.
class PrimeCareAsyncCard<T> extends ConsumerWidget {
  final dynamic provider;
  final Widget Function(BuildContext context, T data) builder;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const PrimeCareAsyncCard({
    super.key,
    required this.provider,
    required this.builder,
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    return PrimeCareCard(
      padding: padding,
      backgroundColor: backgroundColor,
      child: asyncValue.when(
        data: (data) => builder(context, data),
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: CircularProgressIndicator(),
          ),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: PrimeCareColors.rose,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Connection Failed',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                err.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 2. Dynamic Registry Form Engine
/// Eliminates raw static inputs. Mates directly with the `primecare_ui` core engine natively.
class PrimeCareFormBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> schema;
  final String submitLabel;
  final Future<void> Function(Map<String, dynamic> data) onSubmit;
  final String? keySeed;

  const PrimeCareFormBuilder({
    super.key,
    required this.schema,
    required this.onSubmit,
    this.submitLabel = 'Submit',
    this.keySeed,
  });

  @override
  State<PrimeCareFormBuilder> createState() => _PrimeCareFormBuilderState();
}

class _PrimeCareFormBuilderState extends State<PrimeCareFormBuilder> {
  late final GlobalKey<FormState> _formKey;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _dropdownValues = {};
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _formKey = widget.keySeed != null
        ? GlobalObjectKey<FormState>(
            'pc_form_${widget.keySeed}_${identityHashCode(this)}',
          )
        : GlobalKey<FormState>();
    for (var field in widget.schema) {
      if (['text', 'phone', 'email', 'number'].contains(field['type'])) {
        _controllers[field['key']] = TextEditingController(
          text: field['initialValue']?.toString() ?? '',
        );
      } else if (field['type'] == 'dropdown') {
        _dropdownValues[field['key']] =
            field['initialValue']?.toString() ??
            (field['options'] as List).first.toString();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);
      try {
        final payload = <String, dynamic>{};
        _controllers.forEach(
          (key, controller) => payload[key] = controller.text.trim(),
        );
        _dropdownValues.forEach((key, value) => payload[key] = value);
        await widget.onSubmit(payload);
      } finally {
        if (mounted) setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.schema.map((field) {
            if (field['type'] == 'header') {
              return Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: PrimeCareSectionHeader(title: field['label']),
              );
            }

            if (field['type'] == 'dropdown') {
              final options = field['options'] as List<String>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<String>(
                  initialValue: _dropdownValues[field['key']],
                  decoration: InputDecoration(
                    labelText: field['label'],
                    filled: true,
                    fillColor: PrimeCareColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: PrimeCareColors.slate400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: PrimeCareColors.slate400),
                    ),
                  ),
                  items: options
                      .map(
                        (opt) => DropdownMenuItem(value: opt, child: Text(opt)),
                      )
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _dropdownValues[field['key']] = val!),
                ),
              );
            }

            // Default Text Types
            final isPhone = field['type'] == 'phone';
            final isNumber = field['type'] == 'number';
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PrimeCareTextField(
                label: field['label'],
                controller: _controllers[field['key']],
                keyboardType: isPhone
                    ? TextInputType.phone
                    : (isNumber ? TextInputType.number : TextInputType.text),
                validator: field['required'] == true
                    ? (val) => val == null || val.isEmpty ? 'Required' : null
                    : null,
              ),
            );
          }),

          const SizedBox(height: 32),

          PrimeCareButton(
            onPressed: _isSaving ? null : _handleSave,
            text: widget.submitLabel,
            isPrimary: true,
            isLoading: _isSaving,
          ),
        ],
      ),
    );
  }
}

/// 3. Universal Feed Matrix
/// Eliminates manual `ListView.builder` and `ScrollController` loop boilerplate globally.
class PrimeCareFeed<T> extends ConsumerStatefulWidget {
  final dynamic provider;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback? onRefresh;

  const PrimeCareFeed({
    super.key,
    required this.provider,
    required this.itemBuilder,
    this.onRefresh,
  });

  @override
  ConsumerState<PrimeCareFeed<T>> createState() => _PrimeCareFeedState<T>();
}

class _PrimeCareFeedState<T> extends ConsumerState<PrimeCareFeed<T>> {
  @override
  Widget build(BuildContext context) {
    final asyncList = ref.watch(widget.provider);

    return asyncList.when(
      data: (items) {
        if ((items as List).isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No records found.',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: PrimeCareColors.slate400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        final list = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: widget.itemBuilder(context, items[index]),
            );
          },
        );

        if (widget.onRefresh != null) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(widget.provider);
              widget.onRefresh!();
            },
            child: list,
          );
        }

        return list;
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          'Error loading feed: $err',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: PrimeCareColors.rose),
        ),
      ),
    );
  }
}
