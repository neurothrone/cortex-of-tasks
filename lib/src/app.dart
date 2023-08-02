import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/models/models.dart';
import 'features/auth/data/auth_controller.dart';
import 'routing/app_router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final AsyncValue<AppUser?> authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (AppUser? user) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
      loading: () {
        // While the user state is loading, show a progress indicator
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (_, __) {
        // On error, return an error widget
        return const Center(
          child: Text("An error occurred"),
        );
      },
    );
  }
}
