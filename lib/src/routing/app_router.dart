import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/enums/enums.dart';
import '../core/models/models.dart';
import '../features/auth/data/auth_controller.dart';
import '../features/auth/presentation/auth.page.dart';
import '../features/home/home_page.dart';
import '../features/task_list/presentation/task_list_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final AppUser? currentUser = ref.watch(authControllerProvider).asData?.value;

  return GoRouter(
    debugLogDiagnostics: false,
    errorBuilder: (context, state) => const Center(
      child: Text("Error Screen"),
    ),
    initialLocation: currentUser == null ? "/auth" : "/home",
    redirect: (context, state) {
      final String location = state.uri.toString();

      if (currentUser == null && location != "/auth") {
        return "/auth";
      } else if (currentUser != null && location == "/auth") {
        return "/home";
      }

      return null;
    },
    routes: [
      GoRoute(
        path: "/auth",
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: "/home",
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/lists",
        name: AppRoute.lists.name,
        builder: (context, state) => const TaskListPage(),
      ),
    ],
  );
});
