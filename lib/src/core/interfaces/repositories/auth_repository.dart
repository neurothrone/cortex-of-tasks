import '../../models/models.dart';
import '../../utils/type_definitions.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();

  FutureEitherVoid signUp({
    required String email,
    required String password,
  });

  FutureEither<AppUser> signIn({
    required String email,
    required String password,
  });

  FutureEitherVoid signOut();
}
