import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'user_controller.dart';
import '../../../core/ui/app_components.dart';
import '../../../core/ui/app_drawer.dart';
import '../../../core/ui/app_skeleton.dart';
import '../../../core/ui/state_widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserListView extends ConsumerStatefulWidget {
  const UserListView({super.key});

  @override
  ConsumerState<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<UserListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        ref.read(userControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(userControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: userState.when(
        data: (users) {
          if (users.isEmpty) return const AppEmptyState();
          return ListView.builder(
            controller: _scrollController,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return AppCard(
                title: user.name,
                actions: [
                  AppButton(
                    text: 'Edit',
                    onPressed: () {},
                    type: GFButtonType.outline,
                  ),
                ],
                child: ListTile(
                  subtitle: Text('${user.email} • ${user.role}'),
                  trailing: Icon(
                    user.isActive ? Icons.check_circle : Icons.error,
                    color: user.isActive ? Colors.green : Colors.red,
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms).slideX();
            },
          );
        },
        loading: () => const AppListSkeleton(),
        error: (err, stack) => AppErrorState(
          error: err,
          onRetry: () => ref.read(userControllerProvider.notifier).refresh(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/users/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
