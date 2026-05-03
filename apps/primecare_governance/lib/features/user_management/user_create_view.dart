import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'user_form_view.dart';
import 'user_controller.dart';
import 'models/user.dart';

class UserCreateView extends ConsumerWidget {
  const UserCreateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('New User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: UserFormView(
          onSave: (data) async {
            final newUser = User(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: data['name'] as String,
              email: data['email'] as String,
              role: data['role'] as String,
              isActive: data['isActive'] as bool? ?? true,
            );
            
            await ref.read(userControllerProvider.notifier).addUser(newUser);
            if (context.mounted) context.pop();
          },
        ),
      ),
    );
  }
}
