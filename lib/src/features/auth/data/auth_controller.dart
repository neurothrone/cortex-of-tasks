import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/app_user.dart';
import '../../../core/appwrite/repositories/appwrite_auth_repository.dart';
import '../../../core/interfaces/repositories/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AppUser?>>((ref) {
  final AuthRepository authRepository = ref.watch(
    appwriteAuthRepositoryProvider,
  );
  return AuthController(
    authRepository: authRepository,
  );
});

final currentUserProvider = FutureProvider<AppUser?>((ref) async {
  final authRepository = ref.watch(appwriteAuthRepositoryProvider);
  return await authRepository.getCurrentUser();
});

class AuthController extends StateNotifier<AsyncValue<AppUser?>> {
  AuthController({
    required AuthRepository authRepository,
    AppUser? currentUser,
  })  : _authRepository = authRepository,
        super(const AsyncValue.loading()) {
    _getCurrentUser();
  }

  final AuthRepository _authRepository;

  Future<void> _getCurrentUser() async {
    state = const AsyncValue.loading();

    try {
      final AppUser? user = await _authRepository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<AppUser?> getCurrentUser() async {
    return await _authRepository.getCurrentUser();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authRepository.signUp(
      email: email,
      password: password,
    );

    response.fold(
      (failure) {
        debugPrint("❌ -> Failed to Sign Up. Error: ${failure.message}");
        state = AsyncValue.error(failure.message, failure.stackTrace);
      },
      (_) async {
        debugPrint("✅ -> You have signed up.");

        final signInResponse = await _authRepository.signIn(
          email: email,
          password: password,
        );

        signInResponse.fold(
          (failure) {
            debugPrint(
              "❌ -> Failed to Sign In after creating an account. "
              "Error: ${failure.message}",
            );
            state = AsyncValue.error(failure.message, failure.stackTrace);
          },
          (AppUser user) {
            debugPrint("✅ -> You have signed in after creating an account.");
            state = AsyncValue.data(user);
          },
        );
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authRepository.signIn(
      email: email,
      password: password,
    );

    response.fold(
      (failure) {
        debugPrint("❌ -> Failed to Sign In. Error: ${failure.message}");
        state = AsyncValue.error(failure.message, failure.stackTrace);
      },
      (AppUser user) {
        debugPrint("✅ -> You have signed in.");
        state = AsyncValue.data(user);
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    state = const AsyncValue.loading();

    final response = await _authRepository.signOut();

    response.fold(
      (failure) {
        debugPrint("❌ -> Failed to Sign Out. Error: ${failure.message}");
        state = AsyncValue.error(failure.message, failure.stackTrace);
      },
      (_) {
        debugPrint("✅ -> You have signed out.");
        state = const AsyncValue.data(null);
      },
    );
  }
}
