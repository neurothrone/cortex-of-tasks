import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../utils/failure.dart';
import '../../models/models.dart';
import '../../utils/type_definitions.dart';
import '../../interfaces/repositories/auth_repository.dart';
import '../providers.dart';
import '../utils/utils.dart';

final appwriteAuthRepositoryProvider = Provider<AppwriteAuthRepository>((ref) {
  final Account account = ref.watch(appwriteAccountProvider);
  return AppwriteAuthRepository(account: account);
});

class AppwriteAuthRepository implements AuthRepository {
  AppwriteAuthRepository({required Account account}) : _account = account;

  final Account _account;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final currentUser = await _account.get();
      return AppUserFactory.fromAppwriteUser(currentUser);
    } on AppwriteException {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  FutureEitherVoid signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return Either.right(null);
    } on AppwriteException catch (exception, stackTrace) {
      return Either.left(
        Failure(
          "❌ -> Appwrite exception on signUp(). Exception: $exception",
          stackTrace,
        ),
      );
    } catch (exception, stackTrace) {
      return Either.left(
        Failure(exception.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _account.createEmailSession(
        email: email,
        password: password,
      );

      final user = await getCurrentUser();
      if (user == null) throw Exception();

      return Either.right(user);
    } on AppwriteException catch (exception, stackTrace) {
      return Either.left(
        Failure(
          "❌ -> Appwrite exception on signIn(). Exception: $exception",
          stackTrace,
        ),
      );
    } catch (exception, stackTrace) {
      return Either.left(
        Failure(exception.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEitherVoid signOut() async {
    try {
      await _account.deleteSession(sessionId: "current");
      return Either.right(null);
    } on AppwriteException catch (exception, stackTrace) {
      return Either.left(
        Failure(
          "❌ -> Appwrite exception on signOut(). Exception: $exception",
          stackTrace,
        ),
      );
    } catch (exception, stackTrace) {
      return Either.left(
        Failure(exception.toString(), stackTrace),
      );
    }
  }
}
