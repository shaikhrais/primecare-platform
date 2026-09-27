# PrimeCare MVC Template Structure

This repository uses a Model-View-Controller (MVC) architecture alongside Riverpod for state management. This ensures that business logic, data models, and UI rendering are decoupled and maintainable.

When creating a new screen or feature, organize your code into a dedicated directory following this pattern:

```
my_feature_name/
  |- my_feature_model.dart       (Model)
  |- my_feature_controller.dart  (Controller)
  |- my_feature_view.dart        (View)
```

## 1. Model (`my_feature_model.dart`)
Define the state class. Use standard classes or `freezed` for immutability.

```dart
class MyFeatureState {
  final bool isLoading;
  final String? error;
  final dynamic data;

  const MyFeatureState({
    this.isLoading = true,
    this.error,
    this.data,
  });

  MyFeatureState copyWith({
    bool? isLoading,
    String? error,
    dynamic data,
  }) {
    return MyFeatureState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
```

## 2. Controller (`my_feature_controller.dart`)
Implement a Riverpod Notifier (or AsyncNotifier) to manage the state and hold business logic.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'my_feature_model.dart';

part 'my_feature_controller.g.dart'; // Run build_runner to generate this file

@riverpod
class MyFeatureController extends _$MyFeatureController {
  @override
  MyFeatureState build() {
    // Initial state
    _loadData();
    return const MyFeatureState();
  }

  Future<void> _loadData() async {
    // Implement data fetching logic
    // state = state.copyWith(isLoading: false, data: fetchedData);
  }
}
```

## 3. View (`my_feature_view.dart`)
Implement the UI using a `ConsumerWidget`. Watch the controller provider to rebuild on state changes.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'my_feature_controller.dart';

class MyFeatureView extends ConsumerWidget {
  const MyFeatureView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(myFeatureControllerProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: Center(child: Text('Data loaded!')),
    );
  }
}
```

## Generator Command
Don't forget to run `build_runner` after creating or updating a controller to generate the `.g.dart` file.

```bash
dart run build_runner build --delete-conflicting-outputs
```
